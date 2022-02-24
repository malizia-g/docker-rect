#STAGE 1
FROM node:alpine as builder
WORKDIR '/app'
COPY  package.json .
RUN npm install
COPY . .
RUN npm run build

#nella cartella /app/build ci sarà la versione compilata

FROM nginx

#In locale non fa nulla ... serve solo per AWS
EXPOSE 80 

#Copia dalla fase builder la cartella build, nella cartella da cui ngx recupererà i file
COPY --from=builder /app/build usr/share/nginx/html 

