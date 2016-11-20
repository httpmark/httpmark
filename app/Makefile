SHELL:=/bin/bash

run: build-ui build-server
	node server/build/server.js

test: test-ui

build-ui:
	cd ./ui; \
	npm run build

build-server:
	cd ./server; \
	npm run build

dev-build-ui:
	cd ./ui; \
	npm run build:dev

dev-build-server:
	cd ./server; \
	npm run build:dev

test-ui:
	cd ./ui; \
	npm test

.PHONY: \
	run \
	test \
