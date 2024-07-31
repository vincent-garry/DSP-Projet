# Use the official Swift image as base
FROM swift:latest

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container
COPY ./src .

# Install dependencies and build the application
RUN swift package resolve
RUN swift build -c release

# Make sure the build directory exists
RUN mkdir -p /app/.build/release

# Expose the port on which the application runs
EXPOSE 80

# Command to run the application
CMD ["/app/.build/release/P3_Battle"]
