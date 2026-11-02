all: build

-include config.sh
export

bin:
	mkdir -p bin

.PHONY: build
build: bin embedded
	mkdir -p bin/repo
	mkdir -p bin/fonts
	git clone "$(REPO)" bin/repo
	cd bin && npm i svgtofont
	for dir in "bin/repo$(REPO_DIRECTORY)/"*; do bin/node_modules/.bin/svgtofont --sources "$$dir" --output bin/fonts --fontName "$(PREFIX)$$(basename "$$dir")"; done
	go generate ./...
	cp -v -f bin/fonts/*.woff2 bin/fonts/*.css embedded/

.PHONY: clean
clean:
	rm -rf bin

embedded:
	mkdir -p embedded

.PHONY: test
test:
	go test ./...
