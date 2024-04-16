# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install git to enable fetching from Git repositories
RUN apt-get update && \
    apt-get install -y git

# Set the working directory to where the application files will reside
WORKDIR /app

# Clone the repository into a temporary directory
RUN git clone https://github.com/The-May/docker_saufbot.git /tmp/

# Copy specific files and directories from the cloned repository
RUN cp /tmp/saufbot.py /app/saufbot.py
RUN cp /tmp/pictures /app/pictures

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Clean up unnecessary files
RUN rm -rf /tmp/*

# Command to run the Python application
CMD ["python", "saufbot.py"]
