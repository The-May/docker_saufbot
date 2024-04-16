# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install git to enable fetching from Git repositories
RUN apt-get update && \
    apt-get install -y git

# Clone the public Git repository into the container root directory
RUN git clone https://github.com/The-May/docker_saufbot.git /app/

# Set the working directory to where the application files will reside
WORKDIR /app

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r /app/requirements.txt

# Command to run the Python application
CMD ["python", "saufbot.py"]
