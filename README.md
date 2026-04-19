# nexus-free

Open-source Helm chart repository for Sonatype Nexus Repository Community Edition.

This repository keeps two READMEs on purpose:

- this root README explains repository structure and maintainer/contributor context
- [charts/nexus/README.md](charts/nexus/README.md) is the self-contained README shipped with the chart for Helm/OCI/Artifact Hub consumers

## Repository Contents

- [charts/nexus](charts/nexus) - chart source (`name: nexus-free`)
- [charts/nexus/README.md](charts/nexus/README.md) - chart deployment and values documentation
- [examples](examples) - sanitized values examples used by the chart docs
- [.github/workflows/ci-chart.yaml](.github/workflows/ci-chart.yaml) - chart CI validation
- [.github/workflows/release-chart.yaml](.github/workflows/release-chart.yaml) - OCI release workflow
- [CHANGELOG.md](CHANGELOG.md), [LICENSE](LICENSE), [CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md)

## Chart Usage

Deployment, bootstrap behavior, security notes, and example values are documented in [charts/nexus/README.md](charts/nexus/README.md).

## Release Workflow

Publishing and release steps are documented in [CONTRIBUTING.md](CONTRIBUTING.md).

## More Details

For chart implementation details, see [charts/nexus/values.yaml](charts/nexus/values.yaml), [charts/nexus/values.schema.json](charts/nexus/values.schema.json), and [charts/nexus/README.md](charts/nexus/README.md).
