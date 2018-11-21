# STEP 1 build executable binary
FROM golang:alpine as builder

# Install git + SSL ca certificates
RUN apk update && apk add git && apk add ca-certificates

# Create appuser
RUN adduser -D -g '' appuser

COPY . $GOPATH/src/bheight-Zymergen/hello-service/
WORKDIR $GOPATH/src/bheight-Zymergen/hello-service/

# get our dependancies (shouldn't be any in this circumstance)
RUN go get -d -v

# build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/hello-service

# STEP 2 build a small image
# start from scratch
FROM scratch

# Copy in the certs
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable
COPY --from=builder /go/bin/hello-service /go/bin/hello-service

USER appuser

EXPOSE 8080

ENTRYPOINT ["/go/bin/hello-service"]
