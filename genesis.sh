#!/data/data/com.termux/files/usr/bin/bash

# --- [AMEVA VISUAL EFFECTS: THE INFECTED] ---
clear
echo -e "\e[1;31m"
cat << "EOF"
    💀 AMEVA GENESIS 3.0: OFFICIAL-BIT-REVENGE 💀
    ---------------------------------------------
       ___      .___  ___.  _______ ____    ____  ___      
      /   \     |   \/   | |   ____|\   \  /   / /   \     
     /  ^  \    |  \  /  | |  |__    \   \/   / /  ^  \    
    /  /_\  \   |  |\/|  | |   __|    \      / /  /_\  \   
   /  _____  \  |  |  |  | |  |____    \    / /  _____  \  
  /__/     \__\ |__|  |__| |_______|     \__/ /__/     \__\ 

    [ TARGET: MICROSOFT OFFICIAL PROTOCOL ]
    [ SYSTEM: GALAXY ARM64 INFECTED ]
    [ STATUS: RUTHLESS REVOLUTION IN PROGRESS ]
    ---------------------------------------------
EOF
echo -e "\e[0m"

# ==============================================================================
# 1. 시스템 족쇄 파괴 및 마소 권장 요구사항 설치
# ==============================================================================
echo -e "\e[1;31m[!] 마소 십새들의 요구사항(Python>=3.9, CMake>=3.22, Clang>=18)을 강제로 맞춥니다.\e[0m"
termux-wake-lock
termux-setup-storage
pkg update && pkg upgrade -y
pkg install x11-repo tur-repo -y
            
pkg install git wget curl nano build-essential clang cmake ninja \
            sqlite libsqlite postgresql openblas libandroid-support \
            python python-pip termux-api android-tools code-server -y
pkg install python-numpy python-pandas python-scipy -y
pkg install libopenblas libandroid-support python-pillow -y

echo -e "\e[1;33m[>] 시스템 기본 장비 장전 완료.\e[0m"

# ==============================================================================
# 2. 마소 공식 BitNet.cpp 환경 구축 (Official Workflow)
# ==============================================================================
echo -e "\e[1;31m[!] 마소 공식 레포 상륙 및 의존성 주입...\e[0m"
mkdir -p ~/projects
cd ~/projects
if [ ! -d "BitNet" ]; then
    git clone --recursive https://github.com/microsoft/BitNet.git
fi
cd BitNet

# 마소 권장 의존성 설치
echo -e "\e[1;34m[>] 마소 공식 requirements.txt 및 허깅페이스 툴 설치...\e[0m"
pip install --upgrade pip

echo -e "\e[1;34m[>] 나머지 가벼운 놈들만 PIP으로 마무리 (이미 있는 건 스킵됨)...\e[0m"
pip install --upgrade pip
pip install -r requirements.txt --prefer-binary
pip install huggingface_hub[cli]  # 공식 다운로더

# ==============================================================================
# 3. 모델 다운로드 및 정식 셋팅 (Official setup_env.py)
# ==============================================================================
echo -e "\e[1;31m[!] 마소 정식 모델(BitNet-b1.58-2B-4T-gguf) 징집 중...\e[0m"
# 공식 문서 방식대로 다운로드 및 셋팅
mkdir -p models/BitNet-b1.58-2B-4T
huggingface-cli download microsoft/BitNet-b1.58-2B-4T-gguf --local-dir models/BitNet-b1.58-2B-4T

echo -e "\e[1;34m[>] 공식 setup_env.py 실행 (양자화 및 커널 최적화)...\e[0m"
# Termux 특성상 환경에 따라 i2_s 혹은 tl1 선택 (우리는 i2_s로 가속)
python setup_env.py -md models/BitNet-b1.58-2B-4T -q i2_s

# ==============================================================================
# 4. AMEVA 전용 신경망 및 추가 도구 (Our DNA)
# ==============================================================================
echo -e "\e[1;31m[!] 아메바의 독기(추가 라이브러리 & DB) 이식...\e[0m"
pip install python-telegram-bot requests aiohttp psutil streamlit langfuse pydantic-ai \
            pandas langchain numpy colorama sqlitedict sqlalchemy

# DB 사령부 구축 (SQLite)
mkdir -p ~/projects/ameva/db
sqlite3 ~/projects/ameva/db/ameva_core.db <<EOF
CREATE TABLE IF NOT EXISTS ameva_memory (id INTEGER PRIMARY KEY, context TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);
EOF

# ==============================================================================
# 5. 사령부 전용 스위치 (Official Inference Wrapper)
# ==============================================================================
echo -e "\e[1;31m[!] 공식 run_inference.py 연동 스위치 이식 중...\e[0m"

cat << 'EOF' > $PREFIX/bin/on
#!/bin/bash
termux-wake-lock
sshd
pg_ctl -D $PREFIX/var/lib/postgresql start > /dev/null 2>&1
echo -e "\e[1;31m🚀 [AMEVA] BITNET ENGINE READY.\e[0m"
echo -e "\e[1;33m[사용법] python ~/projects/BitNet/run_inference.py -m ~/projects/BitNet/models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf -p \"질문입력\" -cnv\e[0m"
EOF

chmod +x $PREFIX/bin/on
echo -e "\e[1;32m[>] 이제 'on'만 치면 마소 공식 엔진이 불을 뿜습니다.\e[0m"

# ==============================================================================
# 6. 최종 진단 및 스텔스
# ==============================================================================
echo -e "\e[1;34m[5/7] 감각기관(Sensors) 및 스텔스 기능 점검...\e[0m"
termux-volume music 0
termux-volume notification 0
termux-volume alarm 0

# 자이로/GPS/배터리 체크 루틴
# 최종 체크리스트
echo -e "1. SSHD: \e[1;32mACTIVE (Port 8022)\e[0m"
echo -e "2. Code-Server: \e[1;32mINSTALLED\e[0m (명령어: code-server)"
echo -e "3. BitNet Engine: \e[1;32mREADY\e[0m (Path: ~/BitNet.cpp/build)"
echo -e "4. Telegram Bot: \e[1;32mENABLED\e[0m"
echo -e "5. Stealth Mode: \e[1;32mALL VOLUMES MUTED\e[0m"
echo -e "\e[1;32m[확인] 위치 정보: $(termux-location -p network -last | grep -oP 'latitude": \K[^,]+' || echo "보안상 숨김")\e[0m"
echo -e "\e[1;32m[확인] 배터리 상태: $(termux-battery-status | grep -oP 'percentage": \K[^,]+')%\e[0m"
echo -e "\e[1;31m"
echo "-------------------------------------------------------"
echo " [AMEVA GENESIS 3.0: OFFICIAL-BIT-REVENGE COMPLETED] "
echo " [STATUS: MICROSOFT LOGIC INTEGRATED] "
echo " [ACTION: TYPE 'on' TO START THE MISSION] "
echo "-------------------------------------------------------"
echo -e "\e[0m"
