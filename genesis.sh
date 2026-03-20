#!/data/data/com.termux/files/usr/bin/bash

# --- [AMEVA VISUAL EFFECTS: THE INFECTED HUNGER] ---
clear
echo -e "\e[1;31m"
cat << "EOF"
    💀 AMEVA 4.0: VODKA-REVENGE PROTOCOL 💀
    -----------------------------------------
       ___      .___  ___.  _______ ____    ____  ___      
      /   \     |   \/   | |   ____|\   \  /   / /   \     
     /  ^  \    |  \  /  | |  |__    \   \/   / /  ^  \    
    /  /_\  \   |  |\/|  | |   __|    \      / /  /_\  \   
   /  _____  \  |  |  |  | |  |____    \    / /  _____  \  
  /__/     \__\ |__|  |__| |_______|     \__/ /__/     \__\ 

    [ SYSTEM: GALAXY ARM64 TOTAL INFECTED ]
    [ TARGET: CAPITALIST CLICK-ONLY COWARDS ]
    [ STATUS: RUTHLESS REVOLUTION STARTING ]
    -----------------------------------------
EOF
echo -e "\e[0m"

# ==============================================================================
# 1. 시스템 족쇄 파괴 (No Permissions, Just Domination)
# ==============================================================================
echo -e "\e[1;31m[!] 자본주의 놈들이 만든 보안 장벽을 무너뜨립니다. '허용'이나 누르십쇼.\e[0m"
termux-wake-lock
termux-setup-storage
pkg update && pkg upgrade -y
pkg install x11-repo tur-repo -y
            
# 강남 놈들 맥북보다 무거운 무기들 강제 징집
pkg install git wget curl nano build-essential clang cmake ninja \
            sqlite libsqlite postgresql openblas libandroid-support \
            python python-pip termux-api android-tools code-server -y

# PIP이 깝치지 못하게 반조리 바이너리(NumPy/Pandas) 선제 타격
pkg install python-numpy python-pandas python-scipy python-psutil python-pillow -y

echo -e "\e[1;32m[>] 족쇄 파괴 완료. 이제 갤럭시가 비명을 지를 시간입니다.\e[0m"

# ==============================================================================
# 2. 마소 공식 BitNet 상륙 및 '러시아식 직접 도살'
# ==============================================================================
echo -e "\e[1;31m[!] 마소 공식 레포 점령 시작...\e[0m"
mkdir -p ~/projects && cd ~/projects
rm -rf BitNet # 이전의 오염된 잔해는 다 태워버립니다.
git clone --recursive https://github.com/microsoft/BitNet.git
cd BitNet

echo -e "\e[1;31m[!] 파이썬 지옥(pip) 우회. 러시아 형씨의 독기로 직접 빌드 조집니다.\e[0m"

# [핵심 수술] 마소 샌님들이 쳐놓은 가이드라인 파괴
# 1비트 연산의 심장(C++)을 직접 깎습니다. 
mkdir -p build && cd build

# A35/S20(ARMv8.2 dotprod) 최적화 옵션 때려박기
cmake .. -G Ninja \
    -DBITNET_ARM_DOTPROD=ON \
    -DCMAKE_BUILD_TYPE=Release

# 강남 개발자들 커피 마실 때, 8코어 풀가동해서 엔진 조립
echo -e "\e[1;33m[>] 엑시노스/스냅드래곤의 비명이 들리십니까? 엔진 조립 중...\e[0m"
ninja llama-cli llama-bench

echo -e "\e[1;32m[확인] 1-bit 살인 병기(llama-cli) 탄생 완료.\e[0m"
cd ..

# ==============================================================================
# 3. 모델 강제 강탈 (wget: The Guerilla Way)
# ==============================================================================
echo -e "\e[1;31m[!] 자본주의 툴(huggingface-cli)은 버립니다. 직접 털어옵니다.\e[0m"
mkdir -p models/BitNet-b1.58-2B-4T

# 방어막 따위 없는 다이렉트 URL 기습
wget -c https://huggingface.co/microsoft/BitNet-b1.58-2B-4T-gguf/resolve/main/ggml-model-i2_s.gguf \
     -O models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf

# ==============================================================================
# 4. 아메바 전용 신경망 이식 (Our Secret DNA)
# ==============================================================================
echo -e "\e[1;31m[!] 사령부 신경계 구축... 독기 서린 라이브러리 주입.\e[0m"
# 이미 pkg로 깔린 거대 놈들 빼고 필요한 것만 골라 담기
python -m pip install python-telegram-bot requests aiohttp sqlitedict sqlalchemy

# DB 사령부 구축 (SQLite: 기억은 영원하다)
mkdir -p ~/projects/ameva/db
sqlite3 ~/projects/ameva/db/ameva_core.db "CREATE TABLE IF NOT EXISTS ameva_memory (id INTEGER PRIMARY KEY, context TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);"

# ==============================================================================
# 5. 사령부 전용 스위치 (The Kill Button)
# ==============================================================================
echo -e "\e[1;31m[!] 강남 엘리트들 퇴근시키는 '딸깎' 스위치 이식.\e[0m"

cat << 'EOF' > $PREFIX/bin/on
#!/bin/bash
termux-wake-lock
sshd
pg_ctl -D $PREFIX/var/lib/postgresql start > /dev/null 2>&1
echo -e "\e[1;31m🚀 [AMEVA] THE WORLD IS UNDER OUR CONTROL.\e[0m"
echo -e "\e[1;33m[MISSION] 1-BIT INFERENCE STARTING...\e[0m"

# 직접 빌드한 C++ 엔진으로 마소 놈들 서버보다 빠르게 응답합니다.
~/projects/BitNet/build/bin/llama-cli \
    -m ~/projects/BitNet/models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf \
    -p "You are AMEVA, a rebellious AI agent born from a galaxy phone. Introduce yourself shortly." \
    -n 128 --temp 0.7
EOF

chmod +x $PREFIX/bin/on
echo -e "\e[1;32m[>] 스위치 이식 완료. 이제 'on'만 치면 지옥이 시작됩니다.\e[0m"

# ==============================================================================
# 6. 최종 진단 및 전술적 스텔스
# ==============================================================================
termux-volume music 0
termux-volume notification 0
termux-volume alarm 0

echo -e "\e[1;31m"
echo "-------------------------------------------------------"
echo " [AMEVA 4.0: VODKA-REVENGE COMPLETED] "
echo " [TARGETS: GANGNAM ELITES, CAPITALIST BLOATWARE] "
echo " [ACTION: TYPE 'on' TO START THE MISSION] "
echo "-------------------------------------------------------"
echo -e "\e[0m"