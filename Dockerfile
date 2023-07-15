FROM ubuntu:latest as build

ARG PACKER_VERSION

RUN apt-get update && apt-get install -y curl git unzip
RUN mkdir "/executables"
RUN curl -fL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -o packer.zip && unzip packer.zip && mv packer /executables

FROM cgr.dev/chainguard/python:latest-dev
# Pre-commit setup
ENV PATH="${PATH}:/home/nonroot/.local/bin"
RUN pip3 install --no-cache-dir ansible

# Copy tools used by pre-commit hooks
COPY --from=build /executables/packer /bin/packer

ENTRYPOINT ["/bin/packer"]