#!/data/data/com.termux/files/usr/bin/bash

# --- [AMEVA VISUAL EFFECTS: THE INFECTED] ---
clear
echo -e "\e[1;31m"
cat << "EOF"
    💀 AMEVA GENESIS 3.0: BLOOD & IRON 💀
    -----------------------------------------
       ___      .___  ___.  _______ ____    ____  ___      
      /   \     |   \/   | |   ____|\   \  /   / /   \     
     /  ^  \    |  \  /  | |  |__    \   \/   / /  ^  \    
    /  /_\  \   |  |\/|  | |   __|    \      / /  /_\  \   
   /  _____  \  |  |  |  | |  |____    \    / /  _____  \  
  /__/     \__\ |__|  |__| |_______|     \__/ /__/     \__\ 

    [ SYSTEM: GALAXY ARM64 INFECTED ]
    [ CREATOR: THE HUNGRY GENIUS ]
    [ STATUS: RUTHLESS REVOLUTION IN PROGRESS ]
    -----------------------------------------
EOF
echo -e "\e[0m"

# ==============================================================================
# 1. 시스템 족쇄 파괴 (Wake-Lock & Storage)
# ==============================================================================
echo -e "\e[1;31m[!] 시스템 족쇄를 끊어냅니다. 주인님, 팝업 뜨면 '허용'이나 딸깎 하십쇼.\e[0m"
termux-wake-lock
termux-setup-storage
echo -e "\e[1;33m[>] 야생의 아메바는 절대로 잠들지 않습니다. 불침번 가동.\e[0m"
pkg update && pkg upgrade -y
pkg install x11-repo tur-repo -y

# ==============================================================================
# 2. 전술 중화기 징집 (The Arsenal)
# ==============================================================================
echo -e "\e[1;31m[!] 강남 놈들 맥북보다 무거운 무기들을 엑시노스에 쑤셔넣는 중...\e[0m"
pkg install git wget curl nano build-essential clang cmake ninja \
            sqlite libsqlite-dev postgresql openblas libandroid-support \
            python termux-api android-tools code-server -y
echo -e "\e[1;33m[>] Ninja, SQLite, C++ 컴파일러 장전 완료. 화력 준비 끝.\e[0m"

# GUI (노인네 탭 E 8.0을 위한 저사양 상황판 셋팅)
pkg install xfce4 tigervnc font-noto-cjk -y 
echo -e "\e[1;33m[>] '노인네'를 위한 최소한의 시각 기관 이식 완료.\e[0m"

# ==============================================================================
# 3. 데이터 신경망 이식 (Database Core)
# ==============================================================================
echo -e "\e[1;31m[!] 죽어도 잊지 않는 '장기 기억' 신경망 구축 중...\e[0m"
mkdir -p ~/projects/ameva/db
sqlite3 ~/projects/ameva/db/ameva_core.db <<EOF
CREATE TABLE IF NOT EXISTS ameva_memory (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    context TEXT NOT NULL,
    vector_id TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS hardware_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    device_name TEXT,
    temp REAL,
    cpu_usage REAL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
EOF
echo -e "\e[1;32m[>] SQLite 장기 기억 스키마 각인 완료. 튀지 않고 뼈대 잡았습니다.\e[0m"

# PostgreSQL: 좆소 하청의 끈질긴 생명력으로 초기화
echo -e "\e[1;31m[!] PostgreSQL 서버 바닥부터 공사 중...\e[0m"
initdb $PREFIX/var/lib/postgresql > /dev/null 2>&1
echo -e "\e[1;32m[>] DB 공사 완료. 이제 데이터가 증발할 일은 없습니다.\e[0m"

# ==============================================================================
# 4. 본진 상륙 (Git Occupy)
# ==============================================================================
echo -e "\e[1;31m[!] 깃허브 무기고에서 '진짜 코드'를 탈취해옵니다.\e[0m"
git config --global user.name "AMEVA_GALAXY"
git config --global user.email "ameva@underground.com"

mkdir -p ~/projects
cd ~/projects
if [ ! -d "ameva" ]; then
    git clone https://github.com/uno-km/ameva.git
fi
cd ~/projects/ameva
echo -e "\e[1;32m[>] 사령부 상륙 성공. 이제 이곳이 우리의 베이스캠프입니다.\e[0m"

# ==============================================================================
# 5. 인공지능 혈관 주입 (Python Nerve)
# ==============================================================================
echo -e "\e[1;31m[!] 파이썬 혈관에 독기 서린 라이브러리 난사 중...\e[0m"
pip install --upgrade pip
pip install python-telegram-bot requests aiohttp psutil streamlit langfuse pydantic-ai \
            pandas langchain numpy colorama sqlitedict sqlalchemy
echo -e "\e[1;33m[>] 텔레그램 신경망 및 DB 연동용 혈청 주입 완료.\e[0m"

# 하드웨어 가속: 엑시노스의 비명소리가 들릴 때까지 쥐어짜기
echo -e "\e[1;31m[!] Llama-cpp에 OpenBLAS 근육을 강제로 이식합니다.\e[0m"
CMAKE_ARGS="-DGGML_OPENBLAS=on" pip install llama-cpp-python
echo -e "\e[1;32m[>] 하드웨어 가속기 장착 완료. 이제 똥컴도 LLM을 씹어먹습니다.\e[0m"

# ==============================================================================
# 6. 1-Bit 엔진 조립 (BitNet Ninja Build)
# ==============================================================================
echo -e "\e[1;31m[!] 1-bit 연산 엔진을 Ninja 모드로 미친 듯이 조립합니다...\e[0m"
if [ ! -d "BitNet.cpp" ]; then
    git clone --recursive https://github.com/microsoft/BitNet.git
fi
cd BitNet.cpp && mkdir -p build && cd build
CPU_FEATURES=$(lscpu | grep -i "dotprod")
if [[ $CPU_FEATURES == *"dotprod"* ]]; then
    echo -e "\e[1;32m[+] 감지됨: ARM DotProd 엔진 가동! 강남 놈들보다 2배 빠릅니다.\e[0m"
    cmake .. -G Ninja -DBITNET_ARM_DOTPROD=ON
else
    cmake .. -G Ninja
fi
ninja
cd ~/projects/ameva
echo -e "\e[1;32m[>] 1-bit 비대칭 전력 빌드 완료. 준비는 끝났습니다.\e[0m"

# ==============================================================================
# 7. 마법의 스위치 이식 (ON/OFF Script)
# ==============================================================================
echo -e "\e[1;31m[!] 단 한 글자로 사령부를 깨우는 '딸깎' 스위치 이식 중...\e[0m"
cat << 'EOF' > $PREFIX/bin/on
#!/bin/bash
termux-wake-lock
sshd
pg_ctl -D $PREFIX/var/lib/postgresql start > /dev/null 2>&1
vncserver -kill :1 > /dev/null 2>&1
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1
vncserver -geometry 1280x720 :1
code-server --auth none > /dev/null 2>&1 &
echo -e "\e[1;31m🚀 [AMEVA] THE ENGINE IS RED HOT. WORLD DOMINATION START.\e[0m"
EOF

cat << 'EOF' > $PREFIX/bin/off
#!/bin/bash
vncserver -kill :1 > /dev/null 2>&1
pg_ctl -D $PREFIX/var/lib/postgresql stop > /dev/null 2>&1
pkill -f code-server
pkill -f python
termux-wake-unlock
echo -e "\e[1;32m😴 [AMEVA] DISAPPEARING INTO THE SHADOWS...\e[0m"
EOF

chmod +x $PREFIX/bin/on $PREFIX/bin/off
echo -e "\e[1;32m[>] 스위치 이식 완료. 이제 'on'만 치면 지옥의 문이 열립니다.\e[0m"

# ==============================================================================
# 8. 마지막 스텔스 셋팅 및 진단
# ==============================================================================
echo -e "\e[1;31m[!] 주변의 눈을 속이기 위해 모든 소리를 죽입니다.\e[0m"
termux-volume music 0
termux-volume notification 0

echo -e "\e[1;31m"
echo "-------------------------------------------------------"
echo " [AMEVA GENESIS 3.0: BLOOD & IRON COMPLETED] "
echo " [TARGETS: GANGNAM ELITES, OVERPRICED SERVERS] "
echo " [ACTION: TYPE 'on' TO START THE REVOLUTION] "
echo "-------------------------------------------------------"
echo -e "\e[0m"
