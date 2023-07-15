# Packer

Builds an image containing the latest versions of:

* ansible
* packer

Built every day at 2AM to get latest changes and scanned for vulnerabilities using Aqua's [Trivy](https://github.com/aquasecurity/trivy).

## Usage

You can use the image in GitHub actions with a job definition like the one below:

```yaml
  packer:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Validate
        uses: docker://ghcr.io/batinicaz/packer:latest
        with:
          args: |
            validate
            packer/packer.hcl

      - name: Build
        uses: docker://ghcr.io/batinicaz/packer:latest
        with:
           args: |
              build
              -timestamp-ui
              -warn-on-undeclared-var
              packer/packer.hcl
```