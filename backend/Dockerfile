FROM node:20-alpine

WORKDIR /app

# Install all deps (including dev) for building
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build TypeScript
RUN npm run build

ENV NODE_ENV=production
ENV PORT=3847

EXPOSE 3847

# Run the compiled JavaScript in production
CMD ["npm", "start"]
