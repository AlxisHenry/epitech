FROM node:18.12-alpine

WORKDIR /Client

COPY . .

RUN npm install -g pnpm

RUN pnpm install
RUN pnpm run build

EXPOSE 4173

CMD ["pnpm", "run", "preview", "--host", "0.0.0.0"]
