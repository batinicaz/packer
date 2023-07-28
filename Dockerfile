ARG GO_VERSION
FROM golang:${GO_VERSION}-alpine
ARG PACKER_VERSION
ARG TERRAFORM_VERSION

# Update base and install ansible
RUN apk --no-cache upgrade && apk add --no-cache ansible git openssh

# Install OCI
RUN apk add --no-cache oci-cli --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing

# Install packer
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O packer.zip \
    && unzip packer.zip \
    && mv packer /bin \
    && rm -rfv packer*

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O terraform.zip \
    && unzip terraform.zip \
    && mv terraform /bin \
    && rm -rfv terraform*