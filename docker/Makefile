.PHONY: build publish shell

IMAGE = jenkinsciinfra/helmfile
TAG = $(shell git rev-parse HEAD | cut -c1-6)

build: 
	docker build -t $(IMAGE):$(TAG) .

publish:
	docker push $(IMAGE):$(TAG)

shell:
	docker run -i -t --rm --entrypoint $(IMAGE):$(TAG)
