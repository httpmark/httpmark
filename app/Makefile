SHELL:=/bin/bash

run: build-ui build-server
	node server/build/server.js

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

.PHONY: \
	run \
