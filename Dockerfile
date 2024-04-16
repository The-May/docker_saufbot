#v2
# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install git to enable fetching from Git repositories
RUN apt-get update && \
    apt-get install -y git

# Clean up everything in the /app/ directory in case there might be older files that mess with the newer version
RUN rm -rf /app/*

# Set the working directory to where the application files will reside
WORKDIR /app

# Clone the public Git repository into the container root directory
RUN git clone https://github.com/The-May/docker_saufbot.git /app/

# Pull the latest changes from the repository
RUN git pull origin main

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r /app/requirements.txt

# Clean up unnecessary files after pulling from Git
RUN rm -rf /app/.git  # Remove the .git directory to reduce image size
RUN rm -rf /app/Dockerfile  # Remove the Dockerfile copied from the repository

# Command to run the Python application
CMD ["python", "saufbot.py"]
