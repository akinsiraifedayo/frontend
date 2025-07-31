FROM node:18.19.0-alpine AS builder
WORKDIR /frontend
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Serve static files with lightweight server
FROM node:18.19.0-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /frontend/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]