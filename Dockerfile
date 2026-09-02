# build
FROM node:20 AS build
WORKDIR /app

# Build-time argument for Vite environment variable (must be passed via --build-arg / compose build.args,
# Vite only inlines it during `npm run build`, not at container runtime)
ARG VITE_SBP_BACKEND_BASE_URL
ENV VITE_SBP_BACKEND_BASE_URL=$VITE_SBP_BACKEND_BASE_URL

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
