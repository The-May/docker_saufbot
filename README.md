

 1. Create docker-compose.yml file in your favourite directory:

```

#example:
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
```


 
 2. `docker-compose up --build --force-recreate`
 3.  if everything seems to work fine: ctrl+c out
 4. if you unintentionally exited the bot: `docker start telegram_saufbot`


alternatively for testing (for example in vscode): 

1. optional: set venv-> `pip install -r requirements.txt` -> `venv\Scripts\activate`
2.  install requirements.txt in venv -> `pip install -r requirements.txt`
3.  set env manually: 
- `$env:USE_LANGUAGE="de"` 
- `$env:TELEGRAM_BOT_TOKEN="a:b"`
5.  start saufbot.py with python
