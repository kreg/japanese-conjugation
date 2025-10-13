FROM node:22
WORKDIR /usr/src/app
EXPOSE 1234
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev
RUN mkdir -p /usr/src/app/.parcel-cache && chown -R node:node /usr/src/app/.parcel-cache
RUN mkdir -p /usr/src/app/hot-reload-temp && chown -R node:node /usr/src/app/hot-reload-temp
USER node
COPY . .
CMD ["npm", "run", "dev"]