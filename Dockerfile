FROM node:18-alpine

WORKDIR /app

COPY app/ /app

RUN npm install --production

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]