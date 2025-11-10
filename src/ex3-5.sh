#!/bin/bash

# 1. 내부 함수를 정의합니다. (이름은 'run_command'로 정했습니다)
run_command() {
  
  # 함수로 전달된 모든 인자들($@)을 'options'라는 하나의 변수에
  # "공백으로 구분된" 문자열로 저장합니다.
  local options="$@"
  
  # 2. 우리가 실행할 'ls' 명령어와 전달받은 인자(options)를 합쳐서
  # 하나의 "명령어 문자열"로 만듭니다.
  # local은 이 변수가 run_command 함수 안에서만 쓰인다는 의미입니다. (좋은 습관)
  local command_string="ls $options"
  
  # --- (이해를 돕기 위한 보너스 출력) ---
  echo "스크립트가 받은 인자: $@"
  echo "▶ 실행될 명령어 문자열: $command_string"
  echo "--- (ls 명령어 결과) ---"
  
  # 3. eval 명령어를 사용하여 "명령어 문자열" 변수($command_string)를
  # 단순한 텍스트가 아닌, 실제 셸 명령어로 해석하여 실행합니다.
  eval $command_string
}

# 4. 스크립트를 실행할 때 받은 모든 인자들("$@")을
#    그대로 'run_command' 함수에게 전달하면서 함수를 호출합니다.
run_command "$@"
