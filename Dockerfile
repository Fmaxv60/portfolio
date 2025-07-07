<<<<<<< HEAD
# Étape 1 : Build du site Astro
FROM node:20 AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Étape 2 : Serveur statique avec Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
=======
FROM node:20-alpine

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

# étape finale
FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html
>>>>>>> 7110a392f67793aebfc657f42a2512f0ce77475e
