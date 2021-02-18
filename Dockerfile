# Build stage
FROM golang:1.13 as builder

WORKDIR /usr/bin/

WORKDIR /Users/farhankh/go-workspace/src/github.com/arriqaaq/monitor
COPY . .

# Run a gofmt and exclude all vendored code.
RUN test -z "$(gofmt -l $(find . -type f -name '*.go' -not -path "./vendor/*"))" || { echo "Run \"gofmt -s -w\" on your Golang code"; exit 1; }

RUN go test $(go list ./... | grep -v /vendor/ | grep -v /template/|grep -v /build/|grep -v /sample/) -cover

# ldflags "-s -w" strips binary
RUN CGO_ENABLED=0 GOOS=linux go build \
    -installsuffix cgo -o service_monitor


# Release stage
FROM alpine:3.8

RUN apk --no-cache add ca-certificates

EXPOSE 8000

WORKDIR /root/

COPY --from=builder /Users/farhankh/go-workspace/src/github.com/arriqaaq/monitor   .

ENV PATH=$PATH:/root/

CMD ["monitor"]