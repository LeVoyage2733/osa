#!/bin/bash

echo "--- 셸 스크립트 시작 (ex3-8.sh) ---"
echo ""

# 1. "DB" 폴더가 있는지 확인하고, 없으면 생성
echo "1. 'DB' 폴더 확인 중..."
if [ ! -d "DB" ]; then
  # [ ! -d "DB" ] : "DB"라는 디렉터리(-d)가 존재하지 않으면(!)
  echo "   'DB' 폴더가 없습니다. 새로 생성합니다."
  mkdir DB
else
  echo "   'DB' 폴더가 이미 존재합니다."
fi

echo "" # 줄바꿈

# 2. "DB" 폴더에 임의의 5개 파일 생성
echo "2. 'DB' 폴더에 5개의 임의 파일 (file1.txt ~ file5.txt) 생성..."
# {1..5} : 1 2 3 4 5 를 순서대로 i에 넣으며 반복
for i in {1..5}
do
  # touch : 빈 파일을 생성하거나, 파일이 있으면 날짜만 갱신
  touch "DB/file$i.txt"
done
echo "   파일 5개 생성 완료."

# "DB" 폴더 안의 파일들을 압축
echo "3. 'DB' 폴더의 .txt 파일들을 'DB/archive.tar'로 압축..."
# tar : 묶음(archive) 파일 만들기
# -c : Create (새로 만들기)
# -v : Verbose (처리 과정 보여주기)
# -f : File (이름 지정)
# DB/archive.tar : 생성될 압축 파일 이름
# DB/file*.txt : 압축할 대상 파일들 (*는 file로 시작하고 .txt로 끝나는 모든 것을 의미)
tar -cvf DB/archive.tar DB/file*.txt

echo "" # 줄바꿈

# 3. "train" 폴더 생성
echo "4. 'train' 폴더 확인 및 생성..."
if [ ! -d "train" ]; then
  echo "   'train' 폴더가 없습니다. 새로 생성합니다."
  mkdir train
else
  echo "   'train' 폴더가 이미 존재합니다."
fi

echo "" # 줄바꿈

# 4. "train" 폴더에 "DB"의 파일 5개를 링크
echo "5. 'train' 폴더에 'DB'의 파일 5개를 '심볼릭 링크'로 생성..."

for i in {1..5}
do
  # 링크를 걸 때는 '절대 경로'를 사용하는 것이 가장 안전합니다.
  # $(pwd) : 현재 작업 디렉터리(Print Working Directory)의 전체 경로
  # (예: /home/hwko3/scripts)
  original_file="$(pwd)/DB/file$i.txt"
  
  # 링크가 생성될 위치와 이름
  link_file="train/file$i.txt"
  
  # ln -s [원본 파일] [링크 파일]
  # -s : Symbolic(심볼릭) 링크(바로가기) 만들기
  ln -s $original_file $link_file
done
echo "   링크 5개 생성 완료."
echo ""

# 5. 사용자가 결과를 쉽게 확인할 수 있도록 ls 명령어로 결과 출력
echo "--- 모든 작업 완료 ---"
echo ""
echo "[ 'DB' 폴더 최종 상태 ]"
ls -l DB
echo ""
echo "[ 'train' 폴더 최종 상태 (l로 시작하면 링크라는 뜻) ]"
ls -l train
