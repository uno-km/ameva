#!/data/data/com.termux/files/usr/bin/bash

# --- [AMEVA VISUAL EFFECTS: THE INFECTED HUNGER] ---
clear
echo -e "\e[1;31m"
cat << "EOF"
    💀 AMEVA 4.5: GENESIS ULTIMATE (EXYNOS 1380) 💀
    ---------------------------------------------
       ___      .___  ___.  _______ ____    ____  ___      
      /   \     |   \/   | |   ____|\   \  /   / /   \     
     /  ^  \    |  \  /  | |  |__    \   \/   / /  ^  \    
    /  /_\  \   |  |\/|  | |   __|    \      / /  /_\  \   
   /  _____  \  |  |  |  | |  |____    \    / /  _____  \  
  /__/     \__\ |__|  |__| |_______|     \__/ /__/     \__\ 

    [ SYSTEM: GALAXY A35 ARM64 - FULL STACK INFECTED ]
    [ STATUS: MICROSOFT LOGIC + AMEVA DNA INTEGRATED ]
    [ SOURCE: https://github.com/uno-km/ ]
    ---------------------------------------------
EOF
echo -e "\e[0m"

# ==============================================================================
# 0. 오류 처리 사령부 (The Diagnoser)
# ==============================================================================
fail_check() {
    if [ $? -ne 0 ]; then
        echo -e "\e[1;41m [!!!] CRITICAL FAILURE DETECTED [!!!] \e[0m"
        echo -e "\e[1;33m단계: $1\e[0m"
        echo -e "\e[1;36m[분석 및 조치 가이드]\e[0m"
        
        case $1 in
            "시스템 징집") echo "- 조치: 인터넷 연결 확인 및 'pkg clean' 실행 후 재시도." ;;
            "BitNet 복제") echo "- 조치: rm -rf ~/projects/BitNet 실행 후 다시 시도." ;;
            "닌자 빌드")   echo "- 조치: 엑시노스 메모리 초과. -j 1 옵션으로 강제 빌드 권장 (https://uno-kim.tistory.com/)" ;;
            "신경망 이식") echo "- 조치: 'pip install --upgrade pip' 후 개별 패키지 설치 확인." ;;
            "DB 구축")     echo "- 조치: 'postgresql' 서비스 상태 확인." ;;
        esac
        
        echo -e "\n\e[1;32m해결이 안 되면 여기서 답을 찾아라: https://uno-kim.tistory.com/ \e[0m"
        exit 1
    fi
}

# ==============================================================================
# 1. 시스템 족쇄 파괴 및 풀스택 도구 징집
# ==============================================================================
echo -e "\e[1;31m[!] 시스템 인프라 구축 중 (DB, Code-Server, C++ Tools)...\e[0m"
termux-wake-lock
pkg update && pkg upgrade -y
pkg install x11-repo tur-repo -y
pkg install git wget curl nano build-essential clang cmake ninja \
            sqlite libsqlite-dev postgresql openblas libandroid-support \
            python termux-api android-tools code-server tree mlocate -y
fail_check "시스템 징집"

# ==============================================================================
# 2. BitNet.cpp 사령부 건설 (The Core Engine)
# ==============================================================================
echo -e "\e[1;31m[!] BitNet 엔진 탈취 (https://github.com/uno-km/)\e[0m"
mkdir -p ~/projects && cd ~/projects
rm -rf BitNet
git clone https://github.com/microsoft/BitNet.git
fail_check "BitNet 복제"

cd BitNet
git submodule update --init --recursive

# 헤더 수동 이식 (Surgery)
mkdir -p include
cp 3rdparty/llama.cpp/spm-headers/bitnet-lut-kernels.h include/ 2>/dev/null || find . -name "bitnet-lut-kernels-tl1.h" -exec cp {} include/bitnet-lut-kernels.h \;
cp 3rdparty/llama.cpp/spm-headers/ggml-bitnet.h include/ 2>/dev/null || find . -name "ggml-bitnet.h" -exec cp {} include/ \;
find 3rdparty/llama.cpp -name "gemm-config.h" -exec cp {} include/ \;

# Clang 21+ 문법 교정
sed -i 's/void ggml_compute_forward_get_rows_i2_s(struct ggml_compute_params/void ggml_compute_forward_get_rows_i2_s(const struct ggml_compute_params/g' 3rdparty/llama.cpp/ggml/src/ggml.c 2>/dev/null
sed -i 's/void ggml_compute_forward_mul_mat_i2_s(struct ggml_compute_params/void ggml_compute_forward_mul_mat_i2_s(const struct ggml_compute_params/g' 3rdparty/llama.cpp/ggml/src/ggml.c 2>/dev/null

# 마의 Ninja 빌드 구간
echo -e "\e[1;31m[!] 마소 공식 엔진 닌자 빌드 가동 (Exynos High-Heat Mode)...\e[0m"
mkdir -p build && cd build
cmake .. -G "Ninja" -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DBITNET_ARM_DOTPROD=ON -DCMAKE_BUILD_TYPE=Release
ninja || ninja -j 1
fail_check "닌자 빌드"

# 모델 다운로드
cd ~/projects/BitNet
mkdir -p models/BitNet-b1.58-2B-4T
wget -c https://huggingface.co/microsoft/BitNet-b1.58-2B-4T-gguf/resolve/main/ggml-model-i2_s.gguf -O models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf

# ==============================================================================
# 3. AMEVA 신경망 DNA 및 DB 이식
# ==============================================================================
echo -e "\e[1;31m[!] 아메바 독기(Python AI Libraries) 주입...\e[0m"
pip install --upgrade pip
pip install python-telegram-bot requests aiohttp psutil streamlit langfuse pydantic-ai \
            pandas langchain numpy colorama sqlitedict sqlalchemy
fail_check "신경망 이식"

# DB 사령부 초기화 (PostgreSQL & SQLite)
echo -e "\e[1;31m[!] 데이터베이스 사령부(PostgreSQL) 동기화...\e[0m"
mkdir -p ~/projects/ameva/db
initdb $PREFIX/var/lib/postgresql 2>/dev/null
sqlite3 ~/projects/ameva/db/ameva_core.db "CREATE TABLE IF NOT EXISTS memory (id INTEGER PRIMARY KEY, context TEXT, time DATETIME DEFAULT CURRENT_TIMESTAMP);"
fail_check "DB 구축"

# ==============================================================================
# 4. 감각기관(Sensors) 및 스텔스 활성화
# ==============================================================================
echo -e "\e[1;31m[!] 스텔스 모드 및 센서 점검...\e[0m"
termux-volume music 0
termux-volume notification 0
termux-volume alarm 0

# ==============================================================================
# 5. 사령부 통합 스위치 'on' 생성
# ==============================================================================
cat << 'EOF' > $PREFIX/bin/on
#!/bin/bash
termux-wake-lock
sshd
# PostgreSQL 시작
pg_ctl -D $PREFIX/var/lib/postgresql start > /dev/null 2>&1

echo -e "\e[1;31m🚀 [AMEVA GENESIS] 사령부 가동...\e[0m"
echo -e "\e[1;32m[SYSTEM] SSHD/PostgreSQL: ACTIVE\e[0m"
echo -e "\e[1;33m[ENGINE] 마소 공식 BitNet 추론기 가동 준비 완료\e[0m"
echo -e "\e[1;36m[GUIDE] 아래 명령어로 즉시 추론을 시작하십시오:\e[0m"
echo -e "\e[1;37mpython ~/projects/BitNet/run_inference.py -m ~/projects/BitNet/models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf -p \"Greetings, AMEVA.\" -cnv\e[0m"
echo -e "\e[1;32m--------------------------------------------------\e[0m"
echo -e "\e[1;35m[!] 기술지원: https://uno-kim.tistory.com/\e[0m"
EOF
chmod +x $PREFIX/bin/on

# ==============================================================================
# 6. 최종 보고 (The Final Report)
# ==============================================================================
echo -e "\e[1;32m"
echo "-------------------------------------------------------"
echo " [AMEVA GENESIS 4.5: FULL-STACK INFECTED COMPLETED] "
echo "-------------------------------------------------------"
echo -e "\e[0m"
echo -e "1. SSHD & PG-SQL: \e[1;32mREADY\e[0m"
echo -e "2. Code-Server: \e[1;32mINSTALLED\e[0m (cmd: code-server)"
echo -e "3. BitNet Engine: \e[1;32mOPTIMIZED\e[0m"
echo -e "4. Stealth: \e[1;32mMUTED\e[0m"
echo -e "5. Battery: \e[1;33m$(termux-battery-status | grep -oP 'percentage": \K[^,]+')%\e[0m"
echo -e "6. DNA Source: \e[1;36mhttps://github.com/uno-km/\e[0m"
echo ""
echo -e "\e[1;31m[ACTION] 'on'을 입력하여 사령부를 깨우십시오.\e[0m"
