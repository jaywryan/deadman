FROM golang:alpine as builder

RUN apk add git
RUN go get -u -v github.com/golang/dep/cmd/dep && go get -u -v github.com/jaywryan/deadman
WORKDIR /go/src/github.com/gouthamve/deadman

RUN CGO_ENABLED=0 GOOS=linux go install -a -ldflags '-extldflags "-s -w -static"' .

FROM scratch
COPY --from=builder /go/bin/deadman /usr/local/bin/deadman

EXPOSE 9095

ENTRYPOINT ["/usr/local/bin/deadman"]
