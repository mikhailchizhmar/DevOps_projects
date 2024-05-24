#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <unistd.h>

int bflag, eflag, nflag, sflag, tflag, vflag;
int rval;
const char *filename;

int main(int, char *[]);
void cook_args(char *argv[]);
void cook_buf(FILE *);
void raw_args(char *argv[]);
void raw_cat(int);

int main(int argc, char *argv[]) {
  int ch;

  const char *short_options = "benstvT";

  const struct option long_options[] = {
      {"number-nonblank", no_argument, NULL, 'b'},
      {"number", no_argument, NULL, 'n'},
      {"squeeze-blank", no_argument, NULL, 's'}};

  int option_index;
  (void)setlocale(LC_ALL, "");

  while ((ch = getopt_long(argc, argv, short_options, long_options,
                           &option_index)) != -1)
    switch (ch) {
      case 'b':
        bflag = nflag = 1; /* -b implies -n */
        break;
      case 'e':
        eflag = vflag = 1; /* -e implies -v */
        break;
      case 'n':
        nflag = 1;
        break;
      case 's':
        sflag = 1;
        break;
      case 't':
        tflag = vflag = 1; /* -t implies -v */
        break;
      case 'v':
        vflag = 1;
        break;
      case 'T':
        tflag = 1;
        break;
      default:
      case '?':
        (void)fprintf(stderr, "usage: cat [-benstvT] [-] [file ...]\n");
        exit(EXIT_FAILURE);
    };

  argv += optind;

  if (bflag || eflag || nflag || sflag || tflag || vflag)
    cook_args(argv);
  else
    raw_args(argv);
  if (fclose(stdout)) err(EXIT_FAILURE, "stdout");
  return (rval);
}

void cook_args(char **argv) {
  FILE *fp;

  fp = stdin;
  filename = "stdin";
  do {
    if (*argv) {
      if (!strcmp(*argv, "-"))
        fp = stdin;
      else if ((fp = fopen(*argv, "r")) == NULL) {
        warn("%s", *argv);
        rval = EXIT_FAILURE;
        ++argv;
        continue;
      }
      filename = *argv++;
    }
    cook_buf(fp);
    if (fp != stdin)
      (void)fclose(fp);
    else
      clearerr(fp);
  } while (*argv);
}

void cook_buf(FILE *fp) {
  int ch, gobble, line, prev;

  line = gobble = 0;
  for (prev = '\n'; (ch = getc(fp)) != EOF; prev = ch) {
    if (prev == '\n') {
      if (ch == '\n') {
        if (sflag) {
          if (!gobble && nflag && !bflag)
            (void)fprintf(stdout, "%6d\t\n", ++line);
          else if (!gobble && putchar(ch) == EOF)
            break;
          gobble = 1;
          continue;
        }
        if (nflag) {
          if (!bflag) {
            (void)fprintf(stdout, "%6d\t", ++line);
            if (ferror(stdout)) break;
          } else if (eflag) {
            (void)fprintf(stdout, "%6s\t", "");
            if (ferror(stdout)) break;
          }
        }
      } else if (nflag) {
        (void)fprintf(stdout, "%6d\t", ++line);
        if (ferror(stdout)) break;
      }
    }
    gobble = 0;
    if (ch == '\n') {
      if (eflag)
        if (putchar('$') == EOF) break;
    } else if (ch == '\t') {
      if (tflag) {
        if (putchar('^') == EOF || putchar('I') == EOF) break;
        continue;
      }
    } else if (vflag) {
      if (!isascii(ch)) {
        if (putchar('M') == EOF || putchar('-') == EOF) break;
        ch = toascii(ch);
      }
      if (iscntrl(ch)) {
        if (putchar('^') == EOF ||
            putchar(ch == '\177' ? '?' : ch | 0100) == EOF)
          break;
        continue;
      }
    }
    if (putchar(ch) == EOF) break;
  }
  if (ferror(fp)) {
    warn("%s", filename);
    rval = EXIT_FAILURE;
    clearerr(fp);
  }
  if (ferror(stdout)) err(EXIT_FAILURE, "stdout");
}

void raw_args(char **argv) {
  int fd;

  fd = fileno(stdin);
  filename = "stdin";
  do {
    if (*argv) {
      if (!strcmp(*argv, "-"))
        fd = fileno(stdin);
      else if ((fd = open(*argv, O_RDONLY, 0)) < 0) {
        fprintf(stderr, "%s: No such file or directory", argv[0]);
      }
      filename = *argv++;
    }
    raw_cat(fd);
    if (fd != fileno(stdin)) (void)close(fd);
  } while (*argv);
}

void raw_cat(int rfd) {
  static char *buf;
  static char fb_buf[BUFSIZ];
  static size_t bsize;

  ssize_t nr, nw, off;
  int wfd;

  wfd = fileno(stdout);
  if (buf == NULL) {
    struct stat sbuf;

    if (fstat(wfd, &sbuf) == 0 &&
        (long unsigned int)sbuf.st_blksize > sizeof(fb_buf)) {
      bsize = sbuf.st_blksize;
      buf = malloc(bsize);
    }
    if (buf == NULL) {
      bsize = sizeof(fb_buf);
      buf = fb_buf;
    }
  }
  while ((nr = read(rfd, buf, bsize)) > 0)
    for (off = 0; nr; nr -= nw, off += nw)
      if ((nw = write(wfd, buf + off, (size_t)nr)) < 0)
        err(EXIT_FAILURE, "stdout");
  if (nr < 0) {
    warn("%s", filename);
    rval = EXIT_FAILURE;
  }
}