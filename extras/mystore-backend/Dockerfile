# Base
FROM node:22-alpine
WORKDIR /app
ENV NODE_ENV=production

# Dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Application
COPY . .

# Runtime
EXPOSE 3000
CMD ["npm", "start"]
