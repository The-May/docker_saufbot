# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install git to enable fetching from Git repositories
RUN apt-get update && \
    apt-get install -y git

# Create and set the working directory in the container
WORKDIR /app

# Clone the public Git repository into the container
RUN git clone https://github.com/The-May/docker_saufbot.git /app/public_repo

# Copy the requirements file to the working directory
COPY /app/public_repo/requirements.txt /app/

# Install Python dependencies using the specific path to requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the main bot script and the 'pictures' directory into the container
COPY /app/public_repo/saufbot.py /app/
COPY /app/public_repo/pictures /app/pictures

# Command to run the Python application
CMD ["python", "saufbot.py"]
