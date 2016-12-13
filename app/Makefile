SHELL:=/bin/bash

# Check for global dependencies and install them if necessary

check-elm-install:
	@type elm >/dev/null 2>&1 || npm i -g elm@0.18.0

check-yarn-install:
	@type yarn >/dev/null 2>&1 || npm i -g yarn

# UI setup

UI_DEPS=./ui/elm-stuff ./ui/node_modules

./ui/node_modules: check-yarn-install
	cd ./ui && yarn

./ui/elm-stuff: check-elm-install
	cd ./ui && elm-package install

build-ui:
	cd ./ui && yarn run build

dev-build-ui:
	cd ./ui && yarn run build:dev

test-ui: $(UI_DEPS)
	cd ./ui && yarn test

run: build-ui build-server
	node server/build/server.js

build-server:
	cd ./server && yarn run build

dev-build-server:
	cd ./server && yarn run build:dev

test: test-ui

.PHONY: \
	build-ui \
	build-server \
	dev-build-ui \
	dev-build-server \
	check-elm-install \
	check-yarn-install \
	run \
	test \
	test-ui \
