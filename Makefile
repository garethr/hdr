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
	@echo "$(OK_COLOR)==> Build binaries$(NO_COLOR)"
	@go build

deps:
	@echo "$(OK_COLOR)==> Installing dependencies$(NO_COLOR)"
	cat BUILD_DEPENDENCIES | xargs -I{} go get -v {}

clean:
	@echo "$(WARN_COLOR)==> Delete temporary files$(NO_COLOR)"
	rm -f c.out hdr

format:
	@echo "$(WARN_COLOR)==> Format Go source code$(NO_COLOR)"
	@go fmt ./...

coverage:
	@echo "$(OK_COLOR)==> Record coverage with coveralls.io$(NO_COLOR)"
	$(HOME)/gopath/bin/goveralls -coverprofile=c.out -service=travis $(COVERALLS_TOKEN)


.PHONY: all default deps test build format coverage
.SILENT: deps test clean
