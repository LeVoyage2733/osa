#!/bin/bash

# 첫 번째 인자(argument)를 num1 변수에 저장
num1=$1
# 두 번째 인자를 num2 변수에 저장
num2=$2

# 1. 덧셈
sum=$(($num1 + $num2))

# 2. 뺄셈
diff=$(($num1 - $num2))

# 3. 곱셈
product=$(($num1 * $num2))

# 4. 나눗셈 (정수 나눗셈)
quotient=$(($num1 / $num2))

# 결과 출력
echo "두 수: $num1, $num2"
echo "덧셈 결과: $sum"
echo "뺄셈 결과: $diff"
echo "곱셈 결과: $product"
echo "나눗셈 결과: $quotient"


