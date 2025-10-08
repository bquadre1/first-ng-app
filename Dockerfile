FROM node:slim AS build
WORKDIR /app
COPY package*.json ./
RUN npm install && npm audit fix
COPY . .
RUN npm run build  
RUN npm prune --production

From nginx:alpine
COPY --from=build /app/dist/first-ng-app/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]  