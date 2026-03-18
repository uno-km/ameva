from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, MessageHandler, filters
import config

class AmevaMessenger:
    def __init__(self, brain_callback):
        self.brain_callback = brain_callback # 해석을 위해 brain으로 넘겨줄 함수

    async def handle_message(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        user_id = update.effective_user.id
        text = update.message.text
	
        # 보안 체크: 주인님인지 확인
        if user_id != config.ALLOWED_USER_ID:
            print(f"📢 접속 시도한 ID: {user_id}")
            await update.message.reply_text("누구세요? (접근 거부됨)")	
            return

        # 주인님의 명령을 Brain(AI)에게 전달
        response = self.brain_callback(text)
        await update.message.reply_text(f"👾 [AMEVA]: {response}")

    def run(self):
        application = ApplicationBuilder().token(config.TELEGRAM_TOKEN).build()
        
        handler = MessageHandler(filters.TEXT & (~filters.COMMAND), self.handle_message)
        application.add_handler(handler)
        
        print("🚀 AMEVA 신경망 가동 중... (텔레그램 대기 중)")
        application.run_polling()
