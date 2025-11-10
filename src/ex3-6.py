import sys

# 1. 실행파일의 시작 출력
print("[Python] 스크립트 실행 시작")

# 2. 입력된 인자 확인
#    sys.argv는 리스트(list)입니다.
#    sys.argv[0]은 스크립트 이름(ex3-6.py) 자체이므로,
#    실제 인자는 [1]부터 끝까지([1:])입니다.
script_name = sys.argv[0]
arguments = sys.argv[1:] # 1번 인덱스부터 끝까지

print(f"[Python] 스크립트 이름: {script_name}")
print(f"[Python] 입력된 인자 리스트: {arguments}")
print(f"[Python] 입력된 인자 개수: {len(arguments)}")

# 3. 실행파일의 끝 출력
print("[Python] 스크립트 실행 종료")
