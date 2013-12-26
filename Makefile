NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
MODULES = hdr hdr/request

default: test

test: deps
	@echo "$(OK_COLOR)==> Testing hdr$(NO_COLOR)"
	for path in $(MODULES); do \
		go test github.com/garethr/$$path -coverprofile=c.out; \
	done

build: deps
	go build

deps:
	@echo "$(OK_COLOR)==> Installing dependencies$(NO_COLOR)"
	cat BUILD_DEPENDENCIES | xargs -I{} go get -v {}

clean:
	rm -f c.out hdr

format:
	go fmt ./...

.PHONY: all default deps test build
