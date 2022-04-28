FROM node:18-alpine as builder
WORKDIR /workspace
COPY . .

RUN npm install && npm run build

FROM node:18-alpine
EXPOSE 3000
WORKDIR /workspace

RUN npm install -g serve

COPY --from=builder /workspace/build build

CMD ["serve", "-s", "build"]
