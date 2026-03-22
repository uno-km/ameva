#!/data/data/com.termux/files/usr/bin/bash

# --- [AMEVA VISUAL EFFECTS: THE INFECTED HUNGER] ---
clear
echo -e "\e[1;31m"
cat << "EOF"
    💀 AMEVA 4.2: RESILIENT EXYNOS PROTOCOL 💀
    -----------------------------------------
       ___      .___  ___.  _______ ____    ____  ___      
      /   \     |   \/   | |   ____|\   \  /   / /   \     
     /  ^  \    |  \  /  | |  |__    \   \/   / /  ^  \    
    /  /_\  \   |  |\/|  | |   __|    \      / /  /_\  \   
   /  _____  \  |  |  |  | |  |____    \    / /  _____  \  
  /__/     \__\ |__|  |__| |_______|     \__/ /__/     \__\ 

    [ SYSTEM: GALAXY A35 ARM64 - RECOVERY ENABLED ]
    [ STATUS: RUTHLESS REVOLUTION - BITNET OPTIMIZED ]
    [ SOURCE: https://github.com/uno-km/ ]
    -----------------------------------------
EOF
echo -e "\e[0m"

# ==============================================================================
# 0. 오류 처리 함수 (The Diagnoser)
# ==============================================================================
fail_check() {
    if [ $? -ne 0 ]; then
        echo -e "\e[1;41m [!!!] CRITICAL FAILURE DETECTED [!!!] \e[0m"
        echo -e "\e[1;33m단계: $1\e[0m"
        echo -e "\e[1;36m[분석 및 조치 가이드]\e[0m"
        
        case $1 in
            "환경 준비")
                echo "- 원인: 인터넷 연결 불안정 또는 저장공간 부족."
                echo "- 조치: 'termux-setup-storage' 확인 및 'pkg clean' 실행 후 재시도." ;;
            "레포 강탈")
                echo "- 원인: GitHub 서버 연결 실패 또는 기존 BitNet 폴더 권한 문제."
                echo "- 조치: rm -rf ~/projects/BitNet 명령 후 다시 실행하십시오." ;;
            "서브모듈 징집")
                echo "- 원인: llama.cpp 서브모듈 동기화 실패. (네트워크 이슈가 99%)"
                echo "- 조치: git submodule update --init --recursive --force 명령을 수동 실행해보세요." ;;
            "헤더 수동 이식")
                echo "- 원인: BitNet 레포 구조가 변경되어 파일을 찾을 수 없음."
                echo "- 조치: 'find . -name ggml-bitnet.h'로 경로를 찾아 스크립트를 수정해야 합니다." ;;
            "CMake 설계도")
                echo "- 원인: Clang/Cmake 버전 불일치 또는 잘못된 아키텍처 설정."
                echo "- 조치: 'pkg update'를 수행하여 모든 도구를 최신화하세요." ;;
            "닌자 빌드")
                echo "- 원인 1 (Memory): 엑시노스 메모리 부족으로 인한 'Killed' - 스와프 메모리 확보 필요."
                echo "- 원인 2 (Syntax): Clang 최신버전의 엄격한 문법 검사로 인한 컴파일 에러."
                echo "- 조치: 'ninja -j 4' 처럼 코어 수를 제한하거나, 'uno-kim.tistory.com'에서 최신 패치 코드를 확인하세요." ;;
        esac
        
        echo -e "\n\e[1;32m더 자세한 해결책은 여기서 확인: https://uno-kim.tistory.com/ \e[0m"
        exit 1
    fi
}

# ==============================================================================
# 1. 시스템 족쇄 파괴 및 최신 연장 징집
# ==============================================================================
echo -e "\e[1;31m[!] 시스템 준비 중...\e[0m"
termux-wake-lock
pkg update && pkg upgrade -y
pkg install x11-repo tur-repo -y
pkg install git wget curl mlocate nano tree build-essential clang cmake ninja \
            python python-pip termux-api openblas -y -y
fail_check "환경 준비"

# ==============================================================================
# 2. BitNet 점령 및 아메바식 수동 개조
# ==============================================================================
echo -e "\e[1;31m[!] 레포지토리 기습 (https://github.com/uno-km/)\e[0m"
mkdir -p ~/projects && cd ~/projects
rm -rf BitNet
git clone https://github.com/microsoft/BitNet.git
fail_check "레포 강탈"

cd BitNet
echo -e "\e[1;31m[!] 탈영병(서브모듈) 강제 징집...\e[0m"
git submodule update --init --recursive
fail_check "서브모듈 징집"

echo -e "\e[1;31m[!] 설계도(헤더) 수동 이식 및 패치...\e[0m"
mkdir -p include
cp 3rdparty/llama.cpp/spm-headers/bitnet-lut-kernels.h include/ 2>/dev/null || find . -name "bitnet-lut-kernels-tl1.h" -exec cp {} include/bitnet-lut-kernels.h \;
cp 3rdparty/llama.cpp/spm-headers/ggml-bitnet.h include/ 2>/dev/null || find . -name "ggml-bitnet.h" -exec cp {} include/ \;
find 3rdparty/llama.cpp -name "gemm-config.h" -exec cp {} include/ \;
fail_check "헤더 수동 이식"

# Clang 21+ 호환성 패치
sed -i 's/void ggml_compute_forward_get_rows_i2_s(struct ggml_compute_params/void ggml_compute_forward_get_rows_i2_s(const struct ggml_compute_params/g' 3rdparty/llama.cpp/ggml/src/ggml.c 2>/dev/null
sed -i 's/void ggml_compute_forward_mul_mat_i2_s(struct ggml_compute_params/void ggml_compute_forward_mul_mat_i2_s(const struct ggml_compute_params/g' 3rdparty/llama.cpp/ggml/src/ggml.c 2>/dev/null
# 시간 함수 패치
sed -i 's/std::chrono::high_resolution_clock/std::chrono::steady_clock/g' 3rdparty/llama.cpp/common/common.cpp 2>/dev/null

# ==============================================================================
# 3. 마의 구간: 닌자 빌드 (The Heart of Darkness)
# ==============================================================================
echo -e "\e[1;31m[!] CMake 구성 중...\e[0m"
mkdir -p build && cd build
rm -rf *
cmake .. -G "Ninja" \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DBITNET_ARM_DOTPROD=ON \
    -DCMAKE_BUILD_TYPE=Release
fail_check "CMake 설계도"

echo -e "\e[1;31m"
echo "-------------------------------------------------------"
echo " [!] NINJA 빌드 시작: 엑시노스 1380 고문 모드"
echo " [!] 이 단계에서 폰이 뜨거워지거나 멈출 수 있습니다."
echo " [!] 실패 시: https://uno-kim.tistory.com/ 방문 요망"
echo "-------------------------------------------------------"
echo -e "\e[0m"

# Ninja 빌드 실행 (메모리 부족 방지를 위해 -j 4 정도로 제한 권장하나 일단 풀가동)
# 만약 Killed 오류가 나면 -j 2 또는 -j 1로 낮춰야 합니다.
ninja
if [ $? -ne 0 ]; then
    echo -e "\e[1;43m[!] 빌드 중단! 메모리 부족이 의심됩니다. 저사양 모드(-j 2)로 재시도합니다...\e[0m"
    ninja -j 2
    fail_check "닌자 빌드"
fi

# ==============================================================================
# 4. 모델 게릴라 탈취 및 최종 설정
# ==============================================================================
echo -e "\e[1;31m[!] 모델 강탈 (HuggingFace)...\e[0m"
cd ~/projects/BitNet
mkdir -p models/BitNet-b1.58-2B-4T
wget -c https://huggingface.co/microsoft/BitNet-b1.58-2B-4T-gguf/resolve/main/ggml-model-i2_s.gguf \
     -O models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf
fail_check "모델 강탈"

# 전용 실행 스위치 'on' 생성
cat << 'EOF' > $PREFIX/bin/on
#!/bin/bash
termux-wake-lock
echo -e "\e[1;31m🚀 [AMEVA] 1-BIT REVOLUTION STARTING...\e[0m"
echo -e "\e[1;33m팁: 오류 해결은 https://uno-kim.tistory.com/ \e[0m"
~/projects/BitNet/build/bin/llama-cli \
    -m ~/projects/BitNet/models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf \
    -p "You are AMEVA, a cynical AI born from a budget phone. Greet your master shortly." \
    -n 128 --temp 0.8 -t 8
EOF
chmod +x $PREFIX/bin/on

echo -e "\e[1;32m"
echo "-------------------------------------------------------"
echo " [AMEVA 4.2: INFECTED EXYNOS COMPLETED] "
echo " [모든 고난을 이겨내고 1-비트의 꽃을 피웠습니다.] "
echo " [기술 지원: https://github.com/uno-km/ ] "
echo " [추가 가이드: https://uno-kim.tistory.com/ ] "
echo "-------------------------------------------------------"
echo -e "\e[0m"
