# Use official Node.js image for build
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Use official Nginx image for serving static files
FROM nginx:alpine

COPY --from=build /app/dist/mebloggy /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
