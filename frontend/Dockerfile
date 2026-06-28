FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

# Set backend API URL used at build time so the production build calls the backend
# service from the host browser when the frontend is served from a Docker container.
ARG REACT_APP_API_URL=/api
ENV REACT_APP_API_URL=${REACT_APP_API_URL}

COPY . .
RUN npm run build

# Serve with a lightweight static server
FROM node:18-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
