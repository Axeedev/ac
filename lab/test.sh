#!/bin/bash
TEST_LOG_DIR="/home/nik/test"
cd /home/nik/test
for i in {1..20}; do
    dd if=/dev/zero of=file_$i.txt bs=200K count=1
done
cd /home/nik/lab

echo "Тест 1: Проверка с порогом 90%"
./script.sh "$TEST_LOG_DIR" 70

echo "Тест 2: Проверка с порогом 60%"
./script.sh "$TEST_LOG_DIR" 50

echo "Тест 3: Проверка с порогом 30%"
./script.sh "$TEST_LOG_DIR" 30

echo "Тест 4: Проверка с порогом 10%"
./script.sh "$TEST_LOG_DIR" 10
