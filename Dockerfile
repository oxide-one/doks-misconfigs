FROM node:current-alpine AS sass-build
COPY package.json .
RUN npm install --dev
RUN npm install -g sass
COPY sass/ /sass
RUN mkdir /out
RUN sass --no-source-map /sass:/out 

FROM caddy:alpine AS main
COPY src /src
COPY --from=sass-build /out /src/static
COPY Caddyfile /etc/caddy/Caddyfile
CMD caddy run --config /etc/caddy/Caddyfile