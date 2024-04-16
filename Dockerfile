# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install curl
RUN apt-get update && \
    apt-get install -y curl

# Set the working directory to where the application files will reside
WORKDIR /app

# Download saufbot.py and requirements.txt from the GitHub repository
RUN curl -LJO https://raw.githubusercontent.com/The-May/docker_saufbot/main/saufbot.py
RUN curl -LJO https://raw.githubusercontent.com/The-May/docker_saufbot/main/requirements.txt

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

# Command to run the Python application
CMD ["python", "saufbot.py"]
