export ROOT=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))

check-formatter:
	which goimports || GO111MODULE=off go get -u golang.org/x/tools/cmd/goimports

format: check-formatter
	find $(ROOT) -type f -name "*.go" -not -path "$(ROOT)/vendor/*" | xargs -n 1 -I R goimports -w R
	find $(ROOT) -type f -name "*.go" -not -path "$(ROOT)/vendor/*" | xargs -n 1 -I R gofmt -s -w R

check-linter:
	which golangci-lint || GO111MODULE=off go get -u github.com/golangci/golangci-lint/cmd/golangci-lint@v1.23.8

lint: check-linter
	golangci-lint run $(ROOT)/...
