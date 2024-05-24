#!/bin/bash

DIFF_RES=""
COUNTER_SUCCESS=0
COUNTER_FAIL=0

./s21_grep e grep.c > s21_grep.txt
grep e grep.c > grep.txt
diff -s s21_grep.txt grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt

./s21_grep -e "for" grep.c > s21_grep.txt
grep -e "for" grep.c > grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt

./s21_grep -i e grep.c > s21_grep.txt
grep -i e grep.c > grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt

./s21_grep -v e grep.c > s21_grep.txt
grep -v e grep.c > grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt

./s21_grep -c e grep.c > s21_grep.txt
grep -c e grep.c > grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt

./s21_grep -l e grep.c grep.c grep.c > s21_grep.txt
grep -l e grep.c grep.c grep.c > grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt

./s21_grep -n e grep.c > s21_grep.txt
grep -n e grep.c > grep.txt
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
  then
    (( COUNTER_SUCCESS++ ))
      echo "OK"
  else
    echo "$TEST1" >> log.txt
      (( COUNTER_FAIL++ ))
fi
rm s21_grep.txt grep.txt


echo "SUCCESS: $COUNTER_SUCCESS"
echo "FAIL: $COUNTER_FAIL"

