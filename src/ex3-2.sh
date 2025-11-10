#!/bin/bash

echo "y = (1/2) * x^2 계산을 시작합니다."
echo "---"

#for문은 이 값들을 x라는 변수에 하나씩 넣어가며 do.. done 안의 코드를 반복 실행한다.
for x in "$@"
do
  y=$(echo "scale=4; 0.5 * $x * $x" | bc)
  #결과 출력
  echo "입력값 x = $x => y = $y"
done

echo "---"
echo "계산 완료."
