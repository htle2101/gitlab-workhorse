PREFIX=/usr/local
VERSION=$(shell git describe)-$(shell date -u +%Y%m%d.%H%M%S)

gitlab-git-http-server: main.go
	go build -ldflags "-X main.Version ${VERSION}" -o gitlab-git-http-server main.go

install: gitlab-git-http-server
	install gitlab-git-http-server ${PREFIX}/bin/

.PHONY: test
test: test/data/test.git
	go test -v

test/data/test.git: test/data
	git clone --bare https://gitlab.com/gitlab-org/gitlab-test.git test/data/test.git

test/data:
	mkdir -p test/data
