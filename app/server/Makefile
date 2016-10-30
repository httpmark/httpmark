SHELL:=/bin/bash

clean: ## Removes all built files
	rm ui/index.html
	rm -rf out

build: ui/index.html out/bundle.js ## Build front-end
	node out/bundle.js

ui/index.html:
	cd ./ui; \
	elm-make Index.elm --output=index.html

out/bundle.js:
	npm run build

.PHONY: \
	build \
	clean
