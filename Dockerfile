# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install curl to download files
RUN apt-get update && \
    apt-get install -y curl

# Set the working directory
WORKDIR /app

# Download saufbot.py and requirements.txt into /tmp/
RUN curl -o /tmp/saufbot.py https://raw.githubusercontent.com/The-May/docker_saufbot/main/saufbot.py
RUN curl -o /tmp/requirements.txt https://raw.githubusercontent.com/The-May/docker_saufbot/main/requirements.txt

# Copy files from /tmp/ to /app/
RUN cp /tmp/saufbot.py /app/saufbot.py

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Command to run the Python application
CMD ["python", "saufbot.py"]
