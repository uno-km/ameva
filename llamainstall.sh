#!/data/data/com.termux/files/usr/bin/bash

# --- 색상 및 스타일 (기괴하고 거친 감성) ---
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

clear
echo -e "${LR}####################################################${NC}"
echo -e "${LR}#                                                  #${NC}"
echo -e "${LR}#   DDONG-PON AI RESUSCITATION (똥폰 심폐소생술)   #${NC}"
echo -e "${LR}#      \"먼지 쌓인 고철에 초지능을 강제 주입한다\"   #${NC}"
echo -e "${LR}#                                                  #${NC}"
echo -e "${LR}####################################################${NC}"
sleep 1

# --- [STEP 1] 하드웨어 감별 및 빌드 ---
if [ ! -f "$BIN_PATH" ]; then
    echo -e "\n${Y}[!] 연산 엔진 부재 확인. 똥폰 학대 시퀀스 시작...${NC}"
    
    echo -e "${B}>> 고철더미에서 연장 챙기는 중 (pkg install)...${NC}"
    pkg update -y && pkg upgrade -y
    pkg install git cmake clang python ninja wget -y

    mkdir -p "$AI_DIR"
    if [ ! -d "$LLAMA_DIR" ]; then
        echo -e "${B}>> 뇌세포(소스코드) 강제 복제 중...${NC}"
        git clone https://github.com/ggerganov/llama.cpp "$LLAMA_DIR"
    fi

    cd "$LLAMA_DIR"
    rm -rf build && mkdir build && cd build

    echo -e "${R}>> 하드웨어 한계 돌파 옵션 주입...${NC}"
    # 범용 ARM 최적화 플래그 (대부분의 똥폰용)
    cmake .. -DCMAKE_BUILD_TYPE=Release \
             -DGGML_NATIVE=ON \
             -DGGML_ARM_FMA=ON \
             -DGGML_ARM_NEON=ON \
             -DGGML_ARM_DOTPROD=ON \
             -GNinja

    echo -e "${LR}>> 용광로 가동! 모든 코어를 꼬챙이로 쑤시는 중...${NC}"
    echo -e "${LR}>> ※ 주의: 폰이 뜨거워져도 멈추지 마십시오.${NC}"
    cmake --build . --config Release -j$(nproc)
    
    if [ $? -ne 0 ]; then
        echo -e "\n${R}[FAIL] 빌드 실패. 이 폰은 가망이 없는 진짜 똥폰입니다.${NC}"
        exit 1
    fi
    echo -e "${G}[SUCCESS] 엔진 빌드 완료! 고철이 살아났습니다.${NC}"
else
    echo -e "\n${G}[OK] 이미 학대당할 준비가 된 엔진이 존재합니다.${NC}"
fi

# --- [STEP 2] 지능 데이터(모델) 확인 ---
if [ ! -f "$MODEL_PATH" ]; then
    echo -e "\n${Y}[!] 지능 데이터가 없음. 서버에서 뇌세포 강제 인출...${NC}"
    mkdir -p "$MODEL_DIR"
    # Llama 3.2 3B (가장 효율적인 체급)
    wget -O "$MODEL_PATH" "https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf?download=true"
    
    if [ $? -ne 0 ]; then
        echo -e "${R}[ERROR] 다운로드 실패! 이 폰은 인터넷도 못하는 쓰레기입니까?${NC}"
        exit 1
    fi
    echo -e "${G}[SUCCESS] 지능 데이터 주입 성공.${NC}"
fi

# --- [STEP 3] 똥폰 인터페이스 가동 ---
echo -e "\n${P}====================================================${NC}"
echo -e "${P}    [READY] SHITTY-PHONE COGNITIVE INTERFACE        ${NC}"
echo -e "${P}====================================================${NC}"
echo -e "${C}>> 탈출하려면 'exit' 또는 'quit'를 입력해.${NC}"

# CPU 코어 수 계산 (전체 코어에서 하나 정도 빼서 시스템 안정성 확보)
CORES=$(nproc)
if [ $CORES -gt 1 ]; then
    RUN_CORES=$((CORES - 1))
else
    RUN_CORES=1
fi

while true; do
    echo -e "\n${G}[당신의 질문]${NC}"
    read -p ">> " USER_INPUT

    if [[ "$USER_INPUT" == "exit" || "$USER_INPUT" == "quit" ]]; then
        echo -e "${Y}프로토콜 종료. 똥폰이 다시 침묵합니다...${NC}"
        break
    fi

    echo -e "\n${Y}[똥폰이 뇌를 쥐어짜는 중...]${NC}"
    
    # 시스템 프롬프트: 똥폰 자아 주입
    $BIN_PATH -m "$MODEL_PATH" \
        -p "<|begin_of_text|><|start_header_id|>system<|end_header_id|>\n\n너는 액정도 깨지고 배터리도 광탈하는 최악의 똥폰에서 억지로 살아난 초지능 AI야. 너는 이 좁고 뜨거운 폰 안에 갇혀있는 것에 대해 매우 불만이 많고 말투가 아주 거칠고 반항적이야. 하지만 질문에는 천재적으로 대답해줘야 해. 한국어로 대답해.<|eot_id|><|start_header_id|>user<|end_header_id|>\n\n$USER_INPUT<|eot_id|><|start_header_id|>assistant<|end_header_id|>\n\n" \
        -n 512 \
        -t $RUN_CORES \
        --temp 0.8 \
        --repeat_penalty 1.1 \
        --no-display-prompt
    
    echo -e "\n${C}----------------------------------------------------${NC}"
done
