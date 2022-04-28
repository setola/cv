FROM node:current-alpine

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
RUN npm install -g \
    resume-cli \
    jsonresume-theme-elegant \
    jsonresume-theme-eloquent \
    jsonresume-theme-orbit \
    jsonresume-theme-ks \
    jsonresume-theme-macchiato \
    jsonresume-theme-even

USER node

ENV APP_ROOT /home/node/app
RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

CMD ["resume", "serve"]