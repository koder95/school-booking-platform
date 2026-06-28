# build
FROM node:20 AS build
WORKDIR /app

# dependencies
COPY ./frontend/package*.json ./
RUN npm install

# rest of code
COPY ./frontend/ .

RUN npm run build

# serving static files
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
