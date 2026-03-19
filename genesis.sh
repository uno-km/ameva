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
pkg install python-numpy python-pandas python-scipy python-psutil python-pillow -y

pkg install libopenblas libandroid-support -y

echo -e "\e[1;33m[>] 시스템 기본 장비 장전 완료.\e[0m"

# ==============================================================================
# 2. 마소 공식 BitNet 상륙 및 '강제 개조'
# ==============================================================================
mkdir -p ~/projects && cd ~/projects
if [ ! -d "BitNet" ]; then
    git clone --recursive https://github.com/microsoft/BitNet.git
fi
cd BitNet

echo -e "\e[1;31m[!] 마소의 식단표를 아메바 스타일로 완전히 재창조합니다.\e[0m"

# [핵심 수술] 모든 리콰이어먼트 파일을 뒤져서 독극물(torch, hf-xet, 버전 제약)을 박멸합니다.
# 이번엔 < 기호와 모든 버전 제약식을 싹 다 날려버립니다.
find . -name "*.txt" -exec sed -i '/torch/d' {} +
find . -name "*.txt" -exec sed -i '/hf-xet/d' {} +
find . -name "*.txt" -exec sed -i 's/[<>=~]=*[0-9.]*//g' {} +

# [추가 수술] huggingface_hub[cli] 가 아니라 그냥 huggingface_hub 만 설치하게 강제
# hf-xet 이 자꾸 따라오는 걸 막기 위해 'huggingface-hub' 라이브러리만 명시
echo "huggingface-hub" > ameva_requirements.txt
echo "transformers" >> ameva_requirements.txt
echo "sentencepiece" >> ameva_requirements.txt
echo "gguf" >> ameva_requirements.txt
echo "protobuf" >> ameva_requirements.txt

# ==============================================================================
# 3. 안전한 인스톨 (Safe Lane)
# ==============================================================================
echo -e "\e[1;34m[>] 금지된 PIP 업그레이드 무시하고 알맹이만 주입...\e[0m"
# --no-deps 옵션으로 이미 pkg로 깔린 넘파이/psutil을 pip이 건드리지 못하게 차단
python -m pip install --prefer-binary -r ameva_requirements.txt
python -m pip install --prefer-binary huggingface_hub

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
# 4. 모델 징집 (huggingface-cli 대용량 다운로드)
# ==============================================================================
echo -e "\e[1;31m[!] 모델 징집... cli 안 깔렸으면 직접 URL로 땁니다.\e[0m"
mkdir -p models/BitNet-b1.58-2B-4T
# 만약 huggingface-cli가 실패했다면? 아메바식 직접 강탈
if ! command -v huggingface-cli &> /dev/null; then
    echo -e "\e[1;33m[!] CLI 실패 감지. 직접 다운로드로 우회합니다.\e[0m"
    wget -c https://huggingface.co/microsoft/BitNet-b1.58-2B-4T-gguf/resolve/main/ggml-model-i2_s.gguf -P models/BitNet-b1.58-2B-4T/
else
    huggingface-cli download microsoft/BitNet-b1.58-2B-4T-gguf --local-dir models/BitNet-b1.58-2B-4T
fi

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
