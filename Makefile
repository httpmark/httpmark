start:
	docker run -p 3000:3000 -v $(pwd):/app -it webpagetest
setup:
	docker build . -t webpagetest
