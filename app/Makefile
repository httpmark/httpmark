SHELL:=/bin/bash

clean: ## Removes all build files
	rm -rf server/build
	rm -rf ui/build

build: ui/build/index.html server/build/server.js ## Build front-end
	node server/build/server.js

ui/build/index.html:
	cd ./ui; \
	elm-make Index.elm --output=./build/index.html

server/build/server.js:
	cd ./server; \
	npm run build

.PHONY: \
	build \
	clean
