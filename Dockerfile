FROM nginx:latest

# Install necessary packages
RUN apt-get update && apt-get install -y cowsay && rm -rf /var/lib/apt/lists/*

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Set our custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
