SHELL:=/bin/bash
UI_DEPS=./ui/elm-stuff ./ui/node_modules
SERVER_DEPS=./server/node_modules

# Check for global dependencies and install them if necessary

check-elm-install:
	@type elm >/dev/null 2>&1 || npm i -g elm@0.18.0

check-yarn-install:
	@type yarn >/dev/null 2>&1 || npm i -g yarn

# UI setup

./ui/node_modules: check-yarn-install
	cd ./ui && yarn

./ui/elm-stuff: check-elm-install
	cd ./ui && elm-package install -y

build-ui: $(UI_DEPS)
	cd ./ui && yarn run build

dev-build-ui: $(UI_DEPS)
	cd ./ui && yarn run build:dev

test-ui: $(UI_DEPS)
	cd ./ui && yarn test

# Server setup

./server/node_modules: check-yarn-install
	cd ./server && yarn

build-server: $(SERVER_DEPS)
	cd ./server && yarn run build

dev-build-server: $(SERVER_DEPS)
	cd ./server && yarn run build:dev

run: build-ui build-server
	node server/build/server.js

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
