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
COPY --from=root /app/dist /usr/share/nginx/html

RUN mkdir /usr/share/nginx/html/alpha
COPY --from=alpha /app/dist /usr/share/nginx/html/alpha
RUN mkdir /usr/share/nginx/html/alpha/alpha
RUN mv /usr/share/nginx/html/alpha/js /usr/share/nginx/html/alpha/alpha/js
RUN mv /usr/share/nginx/html/alpha/css /usr/share/nginx/html/alpha/alpha/css
RUN mv /usr/share/nginx/html/alpha/img /usr/share/nginx/html/alpha/alpha/img

RUN mkdir /usr/share/nginx/html/beta
COPY --from=beta /app/dist /usr/share/nginx/html/beta
RUN mkdir /usr/share/nginx/html/beta/beta
RUN mv /usr/share/nginx/html/beta/js /usr/share/nginx/html/beta/beta/js
RUN mv /usr/share/nginx/html/beta/css /usr/share/nginx/html/beta/beta/css
RUN mv /usr/share/nginx/html/beta/img /usr/share/nginx/html/beta/beta/img
