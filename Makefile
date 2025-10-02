UBUNTU_VERSION ?= 22.04

build:
	docker build --network=host --platform=linux/amd64 \
		--build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
		-t test-tf-vtk:$(UBUNTU_VERSION) .

push: build
	docker tag test-tf-vtk:$(UBUNTU_VERSION) ghcr.io/oblynx/test-vtk-tf:$(UBUNTU_VERSION)
	docker push ghcr.io/oblynx/test-vtk-tf:$(UBUNTU_VERSION)