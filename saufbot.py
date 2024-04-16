import os
import random
import logging
from telegram import *
from telegram.ext import *
#
# Configure logging
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)
httpx_logger = logging.getLogger('httpx')
httpx_logger.setLevel(logging.WARNING) #prevents 10-second spam that http is alright
logging.info(f"test")

# Define supported languages
SUPPORTED_LANGUAGES = ["en", "de"]

# Get environment variables
use_language = os.environ.get('USE_LANGUAGE')
logging.info(f"Language: {use_language}")
telegram_bot_token = os.environ.get('TELEGRAM_BOT_TOKEN')
logging.info(f"Bot Token: {telegram_bot_token}")

# Check for missing environment variables
if not use_language:
    logging.error("Missing environment variable: USE_LANGUAGE. Please set USE_LANGUAGE.")
    exit()
if not telegram_bot_token:
    logging.error("Missing environment variable: TELEGRAM_BOT_TOKEN. Please set TELEGRAM_BOT_TOKEN.")
    exit()

try:
    application = Application.builder().token(telegram_bot_token).build()
    logging.info("Telegram bot started successfully.")
except Exception as e:
    logging.error(f"Failed to create Telegram bot application: {e}")
    exit()

# Check if specified language is supported
if use_language not in SUPPORTED_LANGUAGES:
    logging.error(f"Unsupported language '{use_language}'. Supported languages are: {', '.join(SUPPORTED_LANGUAGES)}")
    exit()

async def saufen(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:

    # Roll three 6-sided dice
    dice1 = random.randint(1, 6)
    dice2 = random.randint(1, 6)
    dice3 = random.randint(1, 6)
    logging.info(f"Command issued by {update.effective_user}. Results: {dice1} {dice2} {dice3}")

    lang_var = use_language
    dice1_file = f"./pictures/{lang_var}/1_{dice1}.png"
    dice2_file = f"./pictures/{lang_var}/2_{dice2}.png"
    dice3_file = f"./pictures/{lang_var}/3_{dice3}.png"

    dice_group = [
        InputMediaPhoto(media=open(dice3_file, "rb")),
        InputMediaPhoto(media=open(dice1_file, "rb")),
        InputMediaPhoto(media=open(dice2_file, "rb"))
    ]

    await context.bot.send_media_group(chat_id=update.effective_chat.id, media=dice_group)

application.add_handler(CommandHandler("saufen", saufen))
application.run_polling(drop_pending_updates = True)
