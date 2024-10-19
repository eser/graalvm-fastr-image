.PHONY: build
build:
	docker build --platform linux/amd64 -t eser/graalvm-fastr-image:latest .

.PHONY: rebuild
rebuild:
	docker build --no-cache --platform linux/amd64 -t eser/graalvm-fastr-image:latest .

.PHONY: run
run:
	docker run --rm -it eser/graalvm-fastr-image:latest
