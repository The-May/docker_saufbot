# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install git to enable fetching from Git repositories
RUN apt-get update && \
    apt-get install -y git

# Clone the public Git repository into the container root directory
RUN git clone https://github.com/The-May/docker_saufbot.git /

# Set the working directory to the cloned repository
WORKDIR /docker_saufbot

# Copy the requirements file to the working directory
COPY requirements.txt /docker_saufbot/

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

# Copy the main bot script and the 'pictures' directory into the container
COPY saufbot.py /docker_saufbot/
COPY pictures /docker_saufbot/pictures

# Command to run the Python application
CMD ["python", "saufbot.py"]
