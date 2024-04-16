import os
import random
import logging
from telegram import InputMediaPhoto
from telegram.ext import CommandHandler, Updater

# Configure logging
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)

# Define supported languages
SUPPORTED_LANGUAGES = ["en", "de"]

# Get environment variables
use_language = os.environ.get('USE_LANGUAGE')
telegram_bot_token = os.environ.get('TELEGRAM_BOT_TOKEN')

# Check for missing environment variables
if not use_language:
    logging.error("Missing environment variable: USE_LANGUAGE. Please set USE_LANGUAGE.")
    exit()

if not telegram_bot_token:
    logging.error("Missing environment variable: TELEGRAM_BOT_TOKEN. Please set TELEGRAM_BOT_TOKEN.")
    exit()

# Check if specified language is supported
if use_language not in SUPPORTED_LANGUAGES:
    logging.error(f"Unsupported language '{use_language}'. Supported languages are: {', '.join(SUPPORTED_LANGUAGES)}")
    exit()

# Create Updater and Dispatcher
updater = Updater(token=telegram_bot_token, use_context=True)
dispatcher = updater.dispatcher

async def saufen(update, context):
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
        InputMediaPhoto(media=open(dice1_file, "rb")),
        InputMediaPhoto(media=open(dice2_file, "rb")),
        InputMediaPhoto(media=open(dice3_file, "rb"))
    ]

    await context.bot.send_media_group(chat_id=update.effective_chat.id, media=dice_group)

# Register command handler
dispatcher.add_handler(CommandHandler("saufen", saufen))

# Start polling
updater.start_polling()
updater.idle()
