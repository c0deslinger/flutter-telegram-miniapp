from telegram.ext import Updater, CommandHandler

def start(update, context):
    chat_id = update.effective_chat.id
    context.bot.send_message(
        chat_id=chat_id,
        text=f"Halo! Chat ID Anda adalah: {chat_id}\nSilakan masukkan ini ke dalam aplikasi."
    )

def main():
    updater = Updater('7801729215:AAHYNaLC86VFnPLBBRAxGx3VW_nrMPPm3e4', use_context=True)
    dp = updater.dispatcher
    dp.add_handler(CommandHandler('start', start))
    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()
