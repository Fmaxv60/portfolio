FROM node:20-alpine

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

# étape finale
FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html
