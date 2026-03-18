from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, MessageHandler, filters
import config

class AmevaMessenger:
    def __init__(self, brain_callback):
        self.brain_callback = brain_callback

    async def handle_message(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        user_id = update.effective_user.id
        if user_id != config.ALLOWED_USER_ID:
            print(f"📢 침입 시도 ID: {user_id}")
            return

        # 뇌에게 판단을 맡김 (동기 함수라도 비동기 핸들러 안에서 실행 가능)
        response = self.brain_callback(update.message.text)
        await update.message.reply_text(f"👾 [AMEVA]:\n{response}")

    def run(self):
        app = ApplicationBuilder().token(config.TELEGRAM_TOKEN).build()
        app.add_handler(MessageHandler(filters.TEXT & (~filters.COMMAND), self.handle_message))
        print("🚀 AMEVA 신경망 가동 중...")
        app.run_polling()