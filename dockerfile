# Dockerfile
FROM jenkins/jenkins:jdk17

USER root

# Set the timezone
ENV TZ=Asia/Seoul

# Update and install basic packages
RUN apt-get update -y && \
    apt-get install -y ca-certificates curl gnupg lsb-release

# Create the directory for Docker's keyring
RUN mkdir -p /etc/apt/keyrings

# Remove any existing Docker keyring file
RUN rm -f /etc/apt/keyrings/docker.gpg

# Download and add Docker’s GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker's official APT repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index after adding Docker's repository
RUN apt-get update

# Install Docker packages
RUN apt-get install -y docker-ce docker-ce-cli docker-compose-plugin

# Clean up APT cache
RUN apt-get clean

# Switch back to Jenkins user
USER jenkins
