#!/data/data/com.termux/files/usr/bin/bash

# --- [AMEVA VISUAL EFFECTS: THE INFECTED] ---
clear
echo -e "\e[1;31m"
cat << "EOF"
    💀 AMEVA GENESIS 3.0: REVENGE EDITION 💀
    -----------------------------------------
       ___      .___  ___.  _______ ____    ____  ___      
      /   \     |   \/   | |   ____|\   \  /   / /   \     
     /  ^  \    |  \  /  | |  |__    \   \/   / /  ^  \    
    /  /_\  \   |  |\/|  | |   __|    \      / /  /_\  \   
   /  _____  \  |  |  |  | |  |____    \    / /  _____  \  
  /__/     \__\ |__|  |__| |_______|     \__/ /__/     \__\ 
    
    [ SYSTEM: GALAXY A35/S20/A53 INFECTED ]
    [ STATUS: RUTHLESS EVOLUTION STARTING ]
    -----------------------------------------
EOF
echo -e "\e[0m"

# ==============================================================================
# 1. 시스템 족쇄 해제 (Wake-Lock & Storage) << 강제로 뚫어버립니다.
# ==============================================================================
echo -e "\e[1;33m[!] 야생의 아메바는 잠들지 않습니다. 시스템 저항 무력화 중...\e[0m"
termux-wake-lock << # CPU가 주인님 명령 도중에 자는 꼴은 못 봅니다.
termux-setup-storage << # 폰 저장소 다 뒤져서 우리 무대로 만듭니다.
pkg update && pkg upgrade -y
pkg install x11-repo tur-repo -y

# ==============================================================================
# 2. 전술 중화기(패키지) 장착 (Ninja, DB, Compiler) << 싹 다 긁어모았습니다.
# ==============================================================================
echo -e "\e[1;34m[2/8] 강남 놈들 서버보다 무거운 무기들 징집 중...\e[0m"
pkg install git wget curl nano build-essential clang cmake ninja \
            sqlite libsqlite-dev postgresql openblas libandroid-support \
            python termux-api android-tools code-server -y << # Ninja, DB 풀세트 완료.

# GUI (노인네 탭 E 8.0 상황판용)
pkg install xfce4 tigervnc font-noto-cjk -y 

# ==============================================================================
# 3. DB 사령부 구축 및 메모리 초기화 (SQLite/Postgres) << 이빨 꽉 깨물고 셋팅했습니다.
# ==============================================================================
echo -e "\e[1;34m[3/8] 기억 장치(Database) 신경망 연결 및 셋팅...\e[0m"
mkdir -p ~/projects/ameva/db

# ==============================================================================
# 4. Git 본진 점령 및 클론 << 우리 아지트입니다.
# ==============================================================================
echo -e "\e[1;34m[4/8] Git 사령부 셋팅 및 코드 탈취...\e[0m"
#git config --global user.name "AMEVA_GALAXY"
#git config --global user.email "ameva@underground.com"

mkdir -p ~/projects
cd ~/projects
if [ ! -d "ameva" ]; then
    git clone https://github.com/uno-km/ameva.git << # 우리 본진 상륙.
fi
cd ~/projects/ameva

# ==============================================================================
# 5. 파이썬 마약(Library) 주입 및 하드웨어 가속 << 독기 서린 최적화
# ==============================================================================
echo -e "\e[1;34m[5/8] 파이썬 혈관에 인공지능 라이브러리 난사...\e[0m"
pip install --upgrade pip
pip install python-telegram-bot requests aiohttp psutil streamlit langfuse pydantic-ai \
            pandas langchain numpy colorama sqlitedict sqlalchemy << # DB 연동용 추가.

# S20/A35의 스냅드래곤/엑시노스 심장에 OpenBLAS 박기
CMAKE_ARGS="-DGGML_OPENBLAS=on" pip install llama-cpp-python

# ==============================================================================
# 6. BitNet.cpp 초광속 빌드 (Ninja) << 강남 놈들보다 2배 빨라야 합니다.
# ==============================================================================
echo -e "\e[1;34m[6/8] 1-bit 연산 엔진 Ninja 모드로 조립...\e[0m"
if [ ! -d "BitNet.cpp" ]; then
    git clone --recursive https://github.com/microsoft/BitNet.git
fi
cd BitNet.cpp && mkdir -p build && cd build
CPU_FEATURES=$(lscpu | grep -i "dotprod")
if [[ $CPU_FEATURES == *"dotprod"* ]]; then
    cmake .. -G Ninja -DBITNET_ARM_DOTPROD=ON << # Ninja로 시간 단축.
else
    cmake .. -G Ninja
fi
ninja << # 개같이 빌드 시작.
cd ~/projects/ameva

# ==============================================================================
# 7. 'on'/'off' 스위치 - 세상을 뒤엎는 버튼 << 이식 완료
# ==============================================================================
# [ON 스크립트] - 사령부를 깨웁니다.
cat << 'EOF' > $PREFIX/bin/on
#!/bin/bash
termux-wake-lock
sshd
pg_ctl -D $PREFIX/var/lib/postgresql start > /dev/null 2>&1 << # DB 서버 기동
vncserver -kill :1 > /dev/null 2>&1
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1
vncserver -geometry 1280x720 :1
code-server --auth none > /dev/null 2>&1 &
echo -e "\e[1;31m🚀 [AMEVA] THE WORLD IS UNDER OUR CONTROL.\e[0m"
EOF

# [OFF 스크립트] - 흔적도 없이 사라집니다.
cat << 'EOF' > $PREFIX/bin/off
#!/bin/bash
vncserver -kill :1 > /dev/null 2>&1
pg_ctl -D $PREFIX/var/lib/postgresql stop > /dev/null 2>&1
pkill -f code-server
pkill -f python
termux-wake-unlock
echo -e "\e[1;32m😴 [AMEVA] HIBERNATING IN THE SHADOWS.\e[0m"
EOF

chmod +x $PREFIX/bin/on $PREFIX/bin/off

# ==============================================================================
# 8. 마지막 하드웨어 장악 (무음 및 진단)
# ==============================================================================
termux-volume music 0 << # 아무도 모르게 숨어야죠.
echo -e "\e[1;31m"
echo "---------------------------------------------------"
echo " [AMEVA GENESIS 3.0: REVENGE EDITION COMPLETED] "
echo " [COMMAND: 'on' / 'off'] "
echo "---------------------------------------------------"
echo -e "\e[0m"
