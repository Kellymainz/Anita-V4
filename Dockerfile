FROM node:lts-buster

# Copy package.json and install dependencies
COPY package.json package-lock.json* ./

# Install PM2 globally for process management
RUN npm install pm2 -g && \
    npm install --legacy-peer-deps

# Copy application source
COPY . .

# Expose application port
EXPOSE 3000

# Add a basic healthcheck (optional but recommended)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# Use PM2 runtime to keep the app alive, auto-restart on crash
CMD ["pm2-runtime", "start", "index.js", "--no-daemon"]
