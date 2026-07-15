FROM node:24-alpine

ENV NODE_ENV=production
ENV PORT=3000

WORKDIR /app

# Copy dependency files
COPY --chown=node:node package.json package-lock.json ./
# Install dependencies
RUN npm ci --omit=dev

# Copy app files
COPY --chown=node:node index.js ./
COPY --chown=node:node routes ./routes
COPY --chown=node:node server ./server

USER node
EXPOSE 3000
CMD ["node", "index.js"]