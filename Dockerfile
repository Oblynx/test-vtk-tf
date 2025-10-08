# Reproduced with both ubuntu:22.04 and 24.04
ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION
LABEL org.opencontainers.image.source="https://github.com/Oblynx/test-vtk-tf"

RUN apt-get update && apt-get -y install \
      python3.$( [ "${UBUNTU_VERSION}" = "22.04" ] && echo "11" || echo "12" ) python3-pip \
      vim tar libgl1 libglu1-mesa libx11-6 libxext6 libxrender1 xvfb
RUN pip install uv $( [ "${UBUNTU_VERSION}" != "22.04" ] && echo "--break-system-packages" || echo "" )

WORKDIR /
COPY tf-vtk-segfault-repro-uv-project.tgz /
RUN tar -xvzf /tf-vtk-segfault-repro-uv-project.tgz
WORKDIR /test-tf-vtk

ENTRYPOINT [ "bash", "-c", "uv sync && xvfb-run -s '-screen 0 1280x800x24' uv run tf_vtk.py" ]
