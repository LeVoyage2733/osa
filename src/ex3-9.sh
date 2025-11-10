#!/bin/bash

# 데이터베이스로 사용할 파일 이름
DB_FILE="DB.txt"

# 1. DB.txt 파일이 없으면 새로 생성 (오류 방지)
if [ ! -f "$DB_FILE" ]; then
    touch "$DB_FILE"
    echo "데이터베이스 파일($DB_FILE)을 새로 생성했습니다."
fi

# 2. Enter 대기 함수 (이전 예제와 동일)
pause_enter() {
  echo "" # 줄바꿈
  echo -n "메인 메뉴로 돌아가려면 Enter를 누르세요..."
  read # 사용자가 Enter를 입력할 때까지 대기
}

# 3. 메인 프로그램 루프
while true
do
  clear
  echo "==================="
  echo "   팀 관리 데이터베이스"
  echo "==================="
  echo " 1) 팀원 정보 추가"
  echo " 2) 팀원과 한 일 기록"
  echo " 3) 팀원 검색 (이름)"
  echo " 4) 수행 내용 검색 (날짜/키워드)"
  echo " 5) 종료"
  echo "==================="
  echo -n "메뉴를 선택하세요 (1-5): "
  
  read choice

  case $choice in
    1) # 1) 팀원 정보 추가
      echo "--- 1) 팀원 정보 추가 ---"
      echo -n "팀원 이름: "
      read name
      echo -n "생일 또는 전화번호: "
      read info

      # [INFO] 라는 태그를 붙여서 DB.txt에 한 줄 추가 (>>)
      # >> : 덮어쓰지 않고, 파일 맨 뒤에 이어붙이기(append)
      echo "[INFO] 이름: $name | 정보: $info" >> "$DB_FILE"
      
      echo "'$name' 님의 정보를 저장했습니다."
      pause_enter
      ;;

    2) # 2) 팀원과 한 일 기록
      echo "--- 2) 팀원과 한 일 기록 ---"
      
      # date +'%Y-%m-%d' : 2025-11-10 (오늘 날짜) 형식으로 자동 입력
      today=$(date +'%Y-%m-%d')
      
      echo -n "기록할 내용 (오늘 날짜: $today): "
      read note

      # [MEETING] 태그를 붙여서 저장
      echo "[MEETING] 날짜: $today | 내용: $note" >> "$DB_FILE"
      
      echo "수행 내용을 저장했습니다."
      pause_enter
      ;;

    3) # 3) 팀원 검색 (이름)
      echo "--- 3) 팀원 검색 (이름) ---"
      echo -n "검색할 팀원 이름: "
      read search_name

      echo "--- [' $search_name ' 검색 결과 (팀원 정보)] ---"
      # grep : 파일에서 문자열을 검색하는 강력한 명령어
      # -i : 대소문자 무시 (Ignore case)
      # "$DB_FILE" 에서 "$search_name"을 검색한 후,
      # | (파이프) : 그 결과 중에서 "[INFO]"가 포함된 줄만 다시 grep
      grep -i "$search_name" "$DB_FILE" | grep "[INFO]"
      
      pause_enter
      ;;

    4) # 4) 수행 내용 검색 (날짜/키워드)
      echo "--- 4) 수행 내용 검색 (날짜/키워드) ---"
      echo -n "검색할 날짜(YYYY-MM-DD) 또는 키워드: "
      read search_term
      
      echo "--- [' $search_term ' 검색 결과 (수행 내용)] ---"
      # [MEETING] 태그가 포함된 줄 중에서 검색
      grep -i "$search_term" "$DB_FILE" | grep "[MEETING]"
      
      pause_enter
      ;;

    5) # 5) 종료
      echo "프로그램을 종료합니다."
      break # while 루프 탈출
      ;;

    *) # 1~5 외의 잘못된 입력
      echo "잘못된 입력입니다. 1~5 사이의 숫자를 입력하세요."
      pause_enter
      ;;
      
  esac # case 문 종료
done # while 문 종료
