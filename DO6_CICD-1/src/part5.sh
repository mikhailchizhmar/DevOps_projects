#!/bin/bash

scp /home/gitlab-runner/builds/qCzp2k9k/0/students/DO6_CICD.ID_356283/newtonbe_student.21_school.ru/DO6_CICD-1/src/cat/s21_cat newtonbe2@192.168.0.109:/usr/local/bin/
scp /home/gitlab-runner/builds/qCzp2k9k/0/students/DO6_CICD.ID_356283/newtonbe_student.21_school.ru/DO6_CICD-1/src/grep/s21_grep newtonbe2@192.168.0.109:/usr/local/bin/

ssh newtonbe2@192.168.0.109 ls -lah /usr/local/bin
