import os
from dotenv import load_dotenv

# .env 파일 로드
load_dotenv()

# 환경 변수에서 값 가져오기
TELEGRAM_TOKEN = os.getenv("TELEGRAM_TOKEN")
ALLOWED_USER_ID = int(os.getenv("ALLOWED_USER_ID"))
BASE_DIR = os.getenv("BASE_DIR", "/data/data/com.termux/files/home/projects/ameva")

# 경로 자동 생성
MODEL_PATH = os.path.join(BASE_DIR, "models/bitnet_engine")
DB_PATH = os.path.join(BASE_DIR, "data/ameva_db.sqlite3")
LOG_DIR = os.path.join(BASE_DIR, "data/logs")