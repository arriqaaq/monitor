TAG?=latest
NAMESPACE?=arriqaaq

.PHONY: build
build:
	docker build -t ${NAMESPACE}/monitor:${TAG} .