SHELL := /bin/bash

export GO111MODULE=on
export GOPROXY=

export PATH := $(GOPATH)/bin:$(PATH)

BINARY_VERSION?=0.0.1
BINARY_OUTPUT?=steamer
EXTRA_FLAGS?=-mod=vendor

define timed_function
	@d=$$(date +%s); \
	$(shell echo $1); \
	echo "=> Ran $1 in $$(($$(date +%s)-d)) seconds"
endef

.PHONY: all install uninstall build test clean deps upgrade tidy

all: deps build

install:
	go install -v $(EXTRA_FLAGS) -ldflags "-X main.Version=$(BINARY_VERSION)"

uninstall:
	rm -f $(GOPATH)/bin/$(BINARY_OUTPUT)

build:
	go build -v $(EXTRA_FLAGS) -ldflags "-X main.Version=$(BINARY_VERSION)" -o $(BINARY_OUTPUT)

test:
	go test -v $(EXTRA_FLAGS) -race -coverprofile=coverage.txt -covermode=atomic ./...

clean:
	go clean
	rm -f $(BINARY_OUTPUT)

deps:
	go build -v $(EXTRA_FLAGS) ./...

upgrade:
	go get -u ./...
	go mod vendor
	go mod tidy

tidy:
	go mod tidy
