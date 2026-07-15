FROM node:24-alpine

ENV NODE_ENV=production
ENV PORT=3000

WORKDIR /app

COPY --chown=node:node package.json package-lock.json ./
RUN npm ci --omit=dev

COPY --chown=node:node index.js ./
COPY --chown=node:node routes ./routes
COPY --chown=node:node server ./server

USER node
EXPOSE 3000
CMD ["node", "index.js"]