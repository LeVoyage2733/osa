#!/bin/bash

# "$@" : 스크립트에 입력된 모든 인자 (점수들)
# "$#" : 스크립트에 입력된 인자의 총 개수 (과목 수)

# 1. 각 과목++의 등급 출력 및 총점 계산
echo "--- 개별 과목 등급 ---"

total_score=0 # 총점을 저장할 변수 (초기값 0)
subject_count=$# # 인자의 개수 = 과목 수

# $@ (모든 인자)에서 점수(score)를 하나씩 꺼내 반복
for score in "$@"
do
  # 점수가 90 이상인지 확인 (정수 비교)
  # [ $score -ge 90 ] : $score가 90보다 크거나(-gt) 같으면(-eq) => -ge
  if [ $score -ge 90 ]; then
    grade="A"
  else
    grade="B"
  fi
  
  echo "점수: $score  =>  등급: $grade"
  
  # 총점에 현재 점수를 더함
  total_score=$(($total_score + $score))
done

# 2. 평균 점수 및 평균 등급 계산
echo "--- 평균 등급 ---"

# 실수 계산을 위해 bc 사용
# scale=2 : 소수점 2자리까지만 계산
# 나눗셈을 할 때는 정수 계산이 되지 않도록 주의 (total_score / subject_count)
average=$(echo "scale=2; $total_score / $subject_count" | bc)

# bc로 계산한 평균 점수(average)가 90.00 보다 큰지 비교
# bc는 조건식도 계산할 수 있습니다. (1이면 참, 0이면 거짓)
# $average >= 90
avg_check=$(echo "$average >= 90" | bc)

if [ $avg_check -eq 1 ]; then
  avg_grade="A"
else
  avg_grade="B"
fi

echo "총점: $total_score"
echo "과목 수: $subject_count"
echo "평균 점수: $average"
echo "평균 등급: $avg_grade"


