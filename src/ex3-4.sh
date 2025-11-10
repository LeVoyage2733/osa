#!/bin/bash

# 1. 프로그램 전체에서 사용할 변수들을 미리 선언합니다.
# while 문 안에서 선언하면 반복할 때마다 초기화되므로, 반드시 밖에 선언해야 합니다.
total_score=0     # 총점을 저장할 변수
subject_count=0   # 과목 수를 저장할 변수
all_scores_list="" # "모든 점수 보기"를 위한 문자열 변수

# 2. "Press Enter" 기능을 위한 함수 (선택 사항이지만, 편의성을 위해 추가)
#    결과를 보여준 뒤, 사용자가 Enter를 누르기 전까지 메뉴로 돌아가지 않고 기다리게 함
pause_enter() {
  echo "" # 줄바꿈
  echo -n "메인 메뉴로 돌아가려면 Enter를 누르세요..."
  read # 사용자가 Enter를 입력할 때까지 대기
}

# 3. 메인 프로그램 루프
# while true : 무한히 반복합니다. (5번을 누르면 'break'로 탈출)
while true
do
  # 3-1. 메뉴판 출력 (clear는 화면을 깨끗하게 정리)
  clear
  echo "==================="
  echo " 1) 과목 성적 추가"
  echo " 2) 입력된 모든 점수 보기"
  echo " 3) 평균 점수 확인"
  echo " 4) 평균 등급 (A/B) 변환"
  echo " 5) 종료"
  echo "==================="
  
  # 3-2. 사용자에게 선택을 받음 (-n은 줄바꿈을 하지 않음)
  echo -n "메뉴를 선택하세요 (1-5): "
  read choice # 사용자의 입력을 'choice' 변수에 저장

  # 3-3. 사용자의 선택(choice)에 따라 다른 동작 수행
  case $choice in
    1) # 1) 과목 성적 추가
      echo "--- 1) 과목 성적 추가 ---"
      echo -n "추가할 점수를 입력하세요 (0-100): "
      read score

      # 계산: 총점과 과목 수 업데이트
      total_score=$(($total_score + $score))
      subject_count=$(($subject_count + 1))
      
      # "모든 점수 보기"용 리스트 업데이트
      if [ $subject_count -eq 1 ]; then
        all_scores_list="$score" # 첫 번째 점수
      else
        all_scores_list="$all_scores_list, $score" # 콤마로 이어서 추가
      fi
      
      echo "$score 점이 추가되었습니다. (현재 총 $subject_count 과목)"
      pause_enter # Enter 대기
      ;; # case 1 끝
      
    2) # 2) 입력된 모든 점수 보기
      echo "--- 2) 입력된 모든 점수 보기 ---"
      if [ $subject_count -eq 0 ]; then
        echo "입력된 점수가 없습니다."
      else
        echo "입력된 모든 점수: [ $all_scores_list ]"
      fi
      pause_enter # Enter 대기
      ;; # case 2 끝

    3) # 3) 평균 점수 확인
      echo "--- 3) 평균 점수 확인 ---"
      if [ $subject_count -eq 0 ]; then
        echo "입력된 점수가 없습니다."
      else
        # 'bc'를 사용한 실수 나눗셈 (ex3-3 활용)
        average=$(echo "scale=2; $total_score / $subject_count" | bc)
        echo "총점: $total_score / 과목 수: $subject_count"
        echo "평균 점수: $average"
      fi
      pause_enter # Enter 대기
      ;; # case 3 끝

    4) # 4) 평균 등급 (GPA) 변환
      echo "--- 4) 평균 등급 (A/B) 변환 ---"
      if [ $subject_count -eq 0 ]; then
        echo "입력된 점수가 없습니다."
      else
        # 평균 계산
        average=$(echo "scale=2; $total_score / $subject_count" | bc)
        
        # 'bc'를 사용한 실수 비교 (ex3-3 활용)
        # $average >= 90
        avg_check=$(echo "$average >= 90" | bc) 

        if [ $avg_check -eq 1 ]; then # bc 결과가 1(참)이면
          avg_grade="A"
        else
          avg_grade="B"
        fi
        echo "평균 점수($average)는 $avg_grade 등급입니다."
      fi
      pause_enter # Enter 대기
      ;; # case 4 끝

    5) # 5) 종료
      echo "프로그램을 종료합니다."
      break # 'while true' 무한 루프를 탈출
      ;; # case 5 끝

    *) # 1~5 외의 잘못된 입력
      echo "잘못된 입력입니다. 1~5 사이의 숫자를 입력하세요."
      pause_enter # Enter 대기
      ;; # case default 끝
      
  esac # case 문 종료
done # while 문 종료
