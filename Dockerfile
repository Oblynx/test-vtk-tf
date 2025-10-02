# Reproduced with both ubuntu:22.04 and 24.04
ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION

# Add metadata labels to associate with GitHub repository
LABEL org.opencontainers.image.source="https://github.com/Oblynx/test-vtk-tf"
LABEL org.opencontainers.image.description="Test container for TensorFlow and VTK segfault reproduction"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Oblynx"
LABEL org.opencontainers.image.title="test-vtk-tf"
LABEL org.opencontainers.image.url="https://github.com/Oblynx/test-vtk-tf"
LABEL org.opencontainers.image.documentation="https://github.com/Oblynx/test-vtk-tf"

RUN apt-get update && apt-get -y install \
    python3.$( [ "${UBUNTU_VERSION}" = "22.04" ] && echo "11" || echo "12" ) python3-pip vim tar \
    libgl1 libglu1-mesa libx11-6 libxext6 libxrender1
RUN pip install uv $( [ "${UBUNTU_VERSION}" = "24.04" ] && echo "--break-system-packages" || echo "" )

WORKDIR /
COPY tf-vtk-segfault-repro-uv-project.tgz /
RUN tar -xvzf /tf-vtk-segfault-repro-uv-project.tgz
WORKDIR /test-tf-vtk

ENTRYPOINT [ "bash", "-c", "uv sync && uv run tf_vtk.py" ]