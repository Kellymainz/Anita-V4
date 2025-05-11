FROM node:lts-buster
  
COPY package.json .


RUN npm install pm2 -g
RUN npm install --legacy-peer-deps

COPY . .

EXPOSE 3000

# Add a basic healthcheck (optional but recommended)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# in your Dockerfile, change CMD to:
CMD ["pm2-runtime", "start", "index.js", "--max-memory-restart", "200M"]

