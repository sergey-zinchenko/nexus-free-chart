# Contributing

Thank you for your interest in improving this Helm chart.

## Development Workflow

1. Fork the repository and create a feature branch.
2. Make focused changes with clear commit messages.
3. Run local validation before opening a pull request.

## Local Validation

```bash
helm dependency update ./charts/nexus
helm lint ./charts/nexus
helm template nexus-free ./charts/nexus
```

If you modify examples or docs, verify they do not include real secrets, private hostnames, or private tokens.

## Pull Request Expectations

- Keep changes scoped to one problem.
- Update `CHANGELOG.md` under `Unreleased`.
- Update docs and examples when behavior changes.
- Preserve backward compatibility whenever possible.

## Versioning

- Chart version is defined in `charts/nexus/Chart.yaml`.
- Use SemVer for chart releases:
  - patch: docs/fixes/non-breaking changes
  - minor: new backward-compatible features
  - major: breaking behavior changes

## Release Workflow

Before publishing a new chart release:

1. Ensure no secrets or tokens are tracked by Git.
2. Ensure examples and docs contain only public placeholder domains.
3. Bump the chart version in `charts/nexus/Chart.yaml`.
4. Add the release entry to `CHANGELOG.md`.
5. Tag the release as `chart-vX.Y.Z`.

OCI publishing to GHCR:

```bash
helm registry login ghcr.io
helm dependency update ./charts/nexus
helm package ./charts/nexus --destination ./dist
helm push ./dist/nexus-free-<version>.tgz oci://ghcr.io/<owner>/charts
```

## Security Sensitive Changes

For security-related reports, do not open a public issue. See `SECURITY.md`.
