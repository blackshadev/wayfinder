FROM golang:1.25-alpine AS base

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -v -o /app/bin/wayfinder-server .

FROM scratch

WORKDIR /app

COPY --from=base /app/bin/wayfinder-server /app/
COPY --from=base /app/views/ /app/views/
COPY --from=base /app/public/ /app/public/

ENTRYPOINT ["/app/wayfinder-server"]
CMD [""]