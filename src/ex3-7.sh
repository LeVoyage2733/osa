#!/bin/bash

# ex3-4.sh에서 사용했던, Enter를 누르기 전까지 대기하는 함수
pause_enter() {
  echo "" # 줄바꿈
  echo -n "메인 메뉴로 돌아가려면 Enter를 누르세요..."
  read # 사용자가 Enter를 입력할 때까지 대기
}

# 무한 루프 시작
while true
do
  clear # 화면 정리
  echo "==================="
  echo "    시스템 상태 확인"
  echo "==================="
  echo " 1) 사용자 정보 확인 (who, id)"
  echo " 2) CPU/GPU 사용률 (top, nvidia-smi)"
  echo " 3) 메모리 사용량 (free)"
  echo " 4) 디스크 사용량 (df)"
  echo " 5) 종료"
  echo "==================="
  echo -n "메뉴를 선택하세요 (1-5): "
  
  read choice # 사용자 입력 받기

  # 입력된 choice 값에 따라 분기
  case $choice in
    1) # 1) 사용자 정보
      echo "--- 1) 사용자 정보 확인 ---"
      
      echo "[현재 시스템에 접속한 사용자 (who)]"
      who
      echo "" # 줄바꿈
      
      echo "[이 스크립트를 실행한 사용자 (id)]"
      id
      
      pause_enter
      ;; # 1번 종료

    2) # 2) CPU/GPU 사용률
      echo "--- 2) CPU/GPU 사용률 확인 ---"
      
      # 'command -v nvidia-smi'는 'nvidia-smi' 명령어가 존재하는지 확인
      # &> /dev/null 은 성공/오류 메시지를 모두 숨김
      if command -v nvidia-smi &> /dev/null; then
        echo "[NVIDIA GPU 사용률 (nvidia-smi)]"
        nvidia-smi
      else
        echo "[CPU 사용률 확인 (top 1회 실행)]"
        # top 명령어는 기본적으로 실시간 반복 실행됨.
        # -b : 배치 모드 (텍스트로 출력)
        # -n 1 : 1회만 실행하고 종료
        # | head -n 5 : 위에서 5줄만 잘라서 보여줌 (요약 정보)
        top -b -n 1 | head -n 5
      fi
      
      pause_enter
      ;; # 2번 종료

    3) # 3) 메모리 사용량
      echo "--- 3) 메모리 사용량 확인 ---"
      
      # free : 메모리 사용량 확인
      # -h : Human-readable (사람이 읽기 편하게 G, M 단위로 보여줌)
      echo "[메모리 사용량 (free -h)]"
      free -h
      
      pause_enter
      ;; # 3번 종료

    4) # 4) 디스크 사용량
      echo "--- 4) 디스크 사용량 확인 ---"
      
      # df : 디스크(파일 시스템) 사용량 확인
      # -h : Human-readable (G, M 단위)
      echo "[디스크 사용량 (df -h)]"
      df -h
      
      pause_enter
      ;; # 4번 종료

    5) # 5) 종료
      echo "프로그램을 종료합니다."
      break # while true 루프를 탈출
      ;;

    *) # 1~5가 아닌 경우
      echo "잘못된 입력입니다. 1~5 사이의 숫자를 입력하세요."
      pause_enter
      ;;
      
  esac # case 문 종료
done # while 문 종료
