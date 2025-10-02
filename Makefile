build-2204:
	docker build --network=host --platform=linux/amd64 \
		--build-arg UBUNTU_VERSION=22.04 -t test-tf-vtk:22.04 .

build-2404:
	docker build --network=host --platform=linux/amd64 \
		--build-arg UBUNTU_VERSION=24.04 -t test-tf-vtk:24.04 .

build-latest:
	docker build --network=host --platform=linux/amd64 \
		--build-arg UBUNTU_VERSION=latest -t test-tf-vtk:latest .