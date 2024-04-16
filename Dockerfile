# Use the latest version of the official Python runtime as base image
FROM python:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install git to enable fetching from Git repositories
RUN apt-get update && \
    apt-get install -y git

# Clone the public Git repository into the container root directory
RUN git clone https://github.com/The-May/docker_saufbot.git /git/

# Set the working directory to where the application files will reside
WORKDIR /app

# Copy the requirements file from the cloned repository to the working directory
COPY /git/requirements.txt /app/

# Install Python dependencies using the requirements.txt file
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the main bot script from the cloned repository to the working directory
COPY /git/saufbot.py /app/

# Copy the 'pictures' directory (including subfolders) from the cloned repository to /app/pictures in the container
COPY /git/pictures /app/pictures

# Command to run the Python application
CMD ["python", "saufbot.py"]
