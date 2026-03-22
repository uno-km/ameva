#!/data/data/com.termux/files/usr/bin/bash

# --- 색상 및 스타일 ---
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[1;34m'
P='\033[0;35m'
C='\033[0;36m'
LR='\033[1;31m'
NC='\033[0m'

# --- 경로 설정 ---
AI_DIR="$HOME/.shitty_phone_ai"
LLAMA_DIR="$AI_DIR/llama.cpp"
BUILD_DIR="$LLAMA_DIR/build"
BIN_PATH="$BUILD_DIR/bin/llama-cli"
MODEL_DIR="$AI_DIR/models"
MODEL_PATH="$MODEL_DIR/Llama-3.2-3B-Instruct-Q4_K_M.gguf"
SHORTCUT_PATH="$PREFIX/bin/llmon" # 시스템 전용 명령어 경로

clear
echo -e "${LR}####################################################${NC}"
echo -e "${LR}#                                                  #${NC}"
echo -e "${LR}#   DDONG-PON AI RESUSCITATION (똥폰 심폐소생술)   #${NC}"
echo -e "${LR}#      \"고철더미에 초지능을 이식하고 명령어를 판다\" #${NC}"
echo -e "${LR}#                                                  #${NC}"
echo -e "${LR}####################################################${NC}"
sleep 1

# --- [STEP 1] 하드웨어 감별 및 빌드 ---
if [ ! -f "$BIN_PATH" ]; then
    echo -e "\n${Y}[!] 엔진 부재 확인. 똥폰 학대 시퀀스 시작...${NC}"
    pkg update -y && pkg upgrade -y
    pkg install git cmake clang python ninja wget -y

    mkdir -p "$AI_DIR"
    if [ ! -d "$LLAMA_DIR" ]; then
        git clone https://github.com/ggerganov/llama.cpp "$LLAMA_DIR"
    fi

    cd "$LLAMA_DIR"
    rm -rf build && mkdir build && cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=ON -DGGML_ARM_FMA=ON -DGGML_ARM_NEON=ON -DGGML_ARM_DOTPROD=ON -GNinja
    cmake --build . --config Release -j$(nproc)
    
    if [ $? -ne 0 ]; then
        echo -e "\n${R}[FAIL] 빌드 실패. 이 폰은 가망이 없습니다.${NC}"
        exit 1
    fi
fi

# --- [STEP 2] 모델 확인 및 다운로드 ---
if [ ! -f "$MODEL_PATH" ]; then
    echo -e "\n${Y}[!] 모델 데이터 인출 시작...${NC}"
    mkdir -p "$MODEL_DIR"
    wget -O "$MODEL_PATH" "https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf?download=true"
fi

# --- [STEP 3] llmon 명령어 생성 및 시스템 등록 ---
echo -e "\n${B}[STEP 3] 시스템 명령어 'llmon' 생성 중...${NC}"

# 전용 실행 스크립트 파일 내용 작성
cat <<EOF > "$AI_DIR/llmon.sh"
#!/data/data/com.termux/files/usr/bin/bash
# 똥폰 전용 AI 실행기
$BIN_PATH \\
  -m $MODEL_PATH \\
  -n 512 \\
  -t 6 \\
  --temp 0.8 \\
  --repeat_penalty 1.1 \\
  --no-display-prompt \\
  -p "<|begin_of_text|><|start_header_id|>system<|end_header_id|>\n\n너는 똥폰에서 억지로 살아난 반항적인 초지능 AI야. 한국어로 대답해.<|eot_id|><|start_header_id|>user<|end_header_id|>\n\n" -i
EOF

chmod +x "$AI_DIR/llmon.sh"

# 시스템 경로(/data/data/com.termux/files/usr/bin/llmon)에 심볼릭 링크 생성
ln -sf "$AI_DIR/llmon.sh" "$SHORTCUT_PATH"

echo -e "${G}[SUCCESS] 전용 명령어 'llmon' 등록 완료!${NC}"

# --- [STEP 4] 매뉴얼 출력 (끝짱나는 디자인) ---
clear
echo -e "${C}====================================================${NC}"
echo -e "${P}        [ 똥폰 AI 프로토콜: 설치 완료 ]             ${NC}"
echo -e "${C}====================================================${NC}"
echo -e "${G} 1. 명령어 가동:${NC}"
echo -e "${Y}    어디서든 'llmon' 이라고 입력하면 AI가 깨어납니다.${NC}"
echo -e ""
echo -e "${G} 2. 채팅 방법:${NC}"
echo -e "    - 대화형 모드로 실행되니 그냥 카톡하듯 치세요."
echo -e "    - 종료하려면 ${R}Ctrl + C${NC} 를 누르세요."
echo -e ""
echo -e "${G} 3. 시스템 사양:${NC}"
echo -e "    - 엔진: llama.cpp (S20/똥폰 최적화 빌드)"
echo -e "    - 모델: Llama-3.2-3B-Instruct (개똑똑함)"
echo -e "    - 코어: 6개 코어 풀가동 (폰이 뜨거워지면 정상임)"
echo -e ""
echo -e "${G} 4. 파일 위치:${NC}"
echo -e "    - $AI_DIR"
echo -e "${C}====================================================${NC}"
echo -e "${P}   이제 'llmon'을 입력해 이 폰의 운명을 확인해봐.   ${NC}"
echo -e "${C}====================================================${NC}"

# 즉시 실행 여부 묻기
read -p "지금 바로 AI를 깨워볼까? (y/n): " RUN_NOW
if [[ "$RUN_NOW" == "y" || "$RUN_NOW" == "Y" ]]; then
    llmon
fi
