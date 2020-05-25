# Minimal Docker image
FROM alpine:latest

# Install git and ssh client
RUN apk add --no-cache git openssh-client

# Copy script file from the repository to the filesystem of the container
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# File to execute when the container start
ENTRYPOINT ["/entrypoint.sh"]