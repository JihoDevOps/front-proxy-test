FROM node:lts as root
WORKDIR /app
COPY ./root/package.json .
RUN npm install
COPY ./root .
RUN npm run build

FROM node:lts as alpha
WORKDIR /app
COPY ./alpha/package.json .
RUN npm install
COPY ./alpha .
RUN npm run build

FROM node:lts as beta
WORKDIR /app
COPY ./beta/package.json .
RUN npm install
COPY ./beta .
RUN npm run build

FROM nginx as proxy
COPY ./proxy/default.conf /etc/nginx/conf.d/defalut.conf

COPY --from=alpha /app/dist /usr/share/nginx/html
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/alpha.html

COPY --from=beta /app/dist /usr/share/nginx/html
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/beta.html

COPY --from=root /app/dist /usr/share/nginx/html
