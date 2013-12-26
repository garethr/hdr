MODULES = hdr hdr/request

default: test

test: deps
	for path in $(MODULES); do \
		go test github.com/garethr/$$path -coverprofile=c.out; \
	done

build: deps
	go build

deps:
	cat BUILD_DEPENDENCIES | xargs -I{} go get -v {}

clean:
	rm -f c.out hdr

.PHONY: all default deps test build
