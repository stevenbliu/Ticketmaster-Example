# Use official Python runtime as base image
FROM python:3.10-slim

# Set environment variables to avoid Python buffering
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt to the container
COPY requirements.txt /app/

# Install dependencies from requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the entire project into the container (including manage.py)
COPY . /app/

# Expose the port Django will run on
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
