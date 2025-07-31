FROM node:22-alpine AS builder
WORKDIR /frontend
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Serve static files with lightweight server
FROM node:22-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /frontend/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]