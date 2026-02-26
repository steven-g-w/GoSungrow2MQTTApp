FROM node:18-alpine

RUN apk add --no-cache jq

WORKDIR /app
COPY app/ /app
RUN npm install --production

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]