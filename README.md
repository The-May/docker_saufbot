1. Create docker-compose.yml file
example:
version: '3'

services:
  telegram-saufbot:
    container_name: telegram_saufbot
    build:
      context: https://github.com/The-May/docker_saufbot.git
      dockerfile: Dockerfile  # Path to the Dockerfile within the repository
    environment:
      - USE_LANGUAGE=de  # Set your desired language here
      - TELEGRAM_BOT_TOKEN=a:b  # Set your Telegram bot token here
    restart: always  # Ensure the container always restarts


2. docker-compose up --build --force-recreate
3. if everything seems to work fine: ctrl+c out
4. docker run --restart always -d your_image_name


alternatively for testing (for example in vscode):
0 optional: set venv-> pip install -r requirements.txt -> venv\Scripts\activate
1. install requirements.txt in venv (pip install -r requirements.txt)
2. set env manually:
$env:USE_LANGUAGE="de" 
$env:TELEGRAM_BOT_TOKEN="a:b"
3. start saufbot.py
