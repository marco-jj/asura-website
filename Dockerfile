FROM node:22.11.0-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
COPY . .
RUN npm install
RUN npm run build

FROM httpd:2.4 AS runtime
WORKDIR /app
COPY --from=builder /app/dist /usr/local/apache2/htdocs/
ENV NODE_ENV=production
ENV PORT=3001
ENV HOST=0.0.0.0
EXPOSE 3001