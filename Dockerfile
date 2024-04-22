FROM node:18-alpine as base

WORKDIR /usr/src/app

COPY package.json package-lock.json ./
COPY tsconfig.json ./
RUN npm install 

COPY ./src ./src
RUN npm run compile

FROM node:18-alpine as production

WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm install --production

FROM node:18-alpine as final

ENV NODE_ENV production

WORKDIR /usr/src/app

COPY package.json package-lock.json entrypoint.sh ./
COPY --from=base /usr/src/app/dist ./dist/
COPY --from=production /usr/src/app/node_modules ./node_modules/

RUN chmod +x ./entrypoint.sh

USER node

ENTRYPOINT ["./entrypoint.sh"]
