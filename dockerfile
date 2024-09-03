FROM golang:1.20-alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

RUN go mod init desafio-go

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o hello

FROM scratch 

COPY --from=builder /app/hello /hello

CMD [ "./hello" ]