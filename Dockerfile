FROM golang:1.16-buster AS build_base

RUN apt-get update && apt-get install git -y
# Set the Current Working Directory inside the container
WORKDIR /app/

COPY . .

# Build the Go app
RUN go mod tidy
RUN go build -o ./sia-exporter .

FROM debian:buster-slim

COPY --from=build_base /app/sia-exporter /sia-exporter
CMD chmod 755 /sia-exporter
CMD ["./sia-exporter"]
