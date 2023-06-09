# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory to /app.
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Expose port 5000 for the Flask app to run on
EXPOSE 5000

# Set the environment variable for Flask to run in debug mode
ENV FLASK_DEBUG=1

# Set the environment variable for Flask to run on all network interfaces
ENV FLASK_RUN_HOST=0.0.0.0

# Run app.py when the container launches
CMD ["python", "app.py"]
