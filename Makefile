TAG?=latest
NAMESPACE?=arriqaaq

.PHONY: build
build:
	docker build -t ${NAMESPACE}/monitor:${TAG} .

.PHONY: push
push:
	docker push ${NAMESPACE}/monitor:${TAG}