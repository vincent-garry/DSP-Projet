# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Create a non-root user
RUN useradd -m myuser

# Create and set the working directory
RUN mkdir -p /home/myuser/app && chown -R myuser:myuser /home/myuser/app
WORKDIR /home/myuser/app

# Copy the requirements file
COPY --chown=myuser:myuser src/requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY --chown=myuser:myuser src .

# Switch to the non-root user
USER myuser

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV PYTHONUNBUFFERED=1

# Run app.py when the container launches
CMD ["python", "app.py"]