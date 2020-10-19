# SimpleCore Configuration for Angular SSR

# Stage 1: Build
FROM node:current-alpine3.12

LABEL author="Justin, SimpleCore"

WORKDIR /client/

COPY package*.json /client/

RUN npm install

COPY . /client/

# Build Server Side Rendered Production Files
RUN npm run build:ssr

COPY /dist/ /client/dist/

# Stage 2:
# Modify port as needed
EXPOSE 4001

# Start server
  # Replace with project name after dist/ folder
CMD ["node", "dist/{PROJECT_NAME}/server/main.js"]
