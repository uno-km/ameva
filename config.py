import os

# 기본 경로
BASE_DIR = "/data/data/com.termux/files/home/projects/ameva"

# 텔레그램 설정
# @BotFather에게 받은 토큰을 입력하세요
TELEGRAM_TOKEN = "7727470990:AAFv7mpgg5xfzKecV4H3QGBkiSvPgHdTOzg" 

# 아메바가 응답할 주인님의 ID (숫자)
# @userinfobot 에게 메시지를 보내면 확인할 수 있습니다
ALLOWED_USER_ID = 8033398163 

# 모델 경로 (나중에 BitNet 빌드 후 사용)
MODEL_PATH = os.path.join(BASE_DIR, "models/bitnet_engine")

# DB 경로
DB_PATH = os.path.join(BASE_DIR, "data/ameva_db.sqlt3") # 우선 파일형 
