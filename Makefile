all: build

-include config.sh
export

bin:
	mkdir -p bin

.PHONY: build
build: bin embedded
	which inkscape
	inkscape -V
	which npm
	which readlink
	mkdir -p bin/repo
	mkdir -p bin/fonts
	git clone "$(REPO)" bin/repo
	cd bin && npm i svgtofont
	for dir in "bin/repo$(REPO_DIRECTORY)/"*; do \
		for file in "$$dir"/*.svg; do \
			echo "Converting strokes to paths: $$(readlink -f "$$file")"; \
			inkscape --actions='select-all;object-stroke-to-path;' --export-filename=$$(readlink -f "$$file") $$(readlink -f "$$file"); \
		done; \
		bin/node_modules/.bin/svgtofont --sources "$$dir" --output bin/fonts --fontName "$(PREFIX)$$(basename "$$dir")"; \
	done
	for file in bin/fonts/*.css; do \
		sed "$$file" -i -e 's/[?]t=[0-9]\+//'; \
		sed "$$file" -i -e '/\.\(eot\|svg\|ttf\|woff\)\b/d'; \
		sed "$$file" -i -e 's/\(url.*woff2.*\),$/src: \1;/'; \
	done
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
