# nexus-free Helm Chart

Production-oriented Helm chart for Sonatype Nexus Repository Community Edition with PostgreSQL.

## Quick Start

```bash
helm dependency update ./charts/nexus
helm lint ./charts/nexus
helm template nexus-free ./charts/nexus -f ./examples/values.example.minimal.yaml
helm upgrade --install nexus-free ./charts/nexus -n nexus --create-namespace -f ./examples/values.example.minimal.yaml
```

## Requirements

- Kubernetes `>= 1.25`
- Helm `>= 3.11`
- PostgreSQL with `pg_trgm` extension

## Features

- Nexus CE deployment with PostgreSQL datastore support
- Support for existing Kubernetes Secrets for DB and admin credentials
- Security-oriented pod and container defaults
- Optional bootstrap hook for repositories, roles, and users via Nexus REST API
- Optional operational resources:
  - PodDisruptionBudget
  - NetworkPolicy
  - ServiceMonitor
  - PrometheusRule
- `values.schema.json` validation

## Minimal Example

```yaml
secret:
 existingDbSecret:
  enabled: true
  name: nexus-dbsecret
  usernameKey: db-user
  passwordKey: db-password
 nexusAdminSecret:
  enabled: true
  existingSecret:
   enabled: true
   name: nexus-adminsecret
   key: nexus-admin-password

postgresql:
 enabled: true
 database: nexus
 username: nexus
 password: "set-via-set-file"

pvc:
 storage: 20Gi

statefulset:
 container:
  resources:
   requests:
    cpu: "500m"
    memory: "2Gi"
   limits:
    cpu: "1"
    memory: "4Gi"

ingress:
 enabled: false

bootstrap:
 enabled: false
```

## Recommended Production Baseline

Use the repository examples as a starting point for production customization:

- [examples/values.example.ingress-tls.yaml](../../examples/values.example.ingress-tls.yaml)
- [examples/values.example.external-db.yaml](../../examples/values.example.external-db.yaml)

At minimum configure:

- existing DB and admin secrets
- persistent storage size and storage class
- ingress host and TLS
- explicit CPU and memory requests and limits

## Bootstrap Behavior

Bootstrap runs as a post-install/post-upgrade Helm hook and can upsert:

- proxy, group, and hosted repositories
- repository read roles
- managed users and role mappings

Important:

- deployments with `--no-hooks` skip bootstrap actions
- deleted managed repositories are recreated only after a deploy with hooks enabled

## Managed Proxy Types

Bootstrap supports managed proxy repositories for:

- `pypiProxy`
- `npmProxy`
- `dockerProxy`
- `huggingfaceProxy`
- `rawProxy`
- `nugetProxy`
- `mavenProxy`

Example bootstrap structure:

```yaml
bootstrap:
 enabled: true
 repositories:
  pypiProxy:
   - name: pypi
    remoteUrl: https://pypi.org/
  npmProxy:
   - name: npmjs
    remoteUrl: https://registry.npmjs.org/
  dockerProxy:
   - name: docker-hub
    remoteUrl: https://registry-1.docker.io
    indexType: REGISTRY
    host: docker.example.com
    port: 5000
    targetPort: 5000
    secretName: nexus-docker-hub-tls
  huggingfaceProxy:
   - name: huggingface
    remoteUrl: https://huggingface.co/
    bearerTokenFromSecret:
     name: nexus-hf-token
     key: token
```

## Monitoring

Prometheus Operator integrations are available through:

- `monitoring.serviceMonitor.enabled`
- `monitoring.prometheusRule.enabled`

## Deployment Security Notes

1. Do not commit real credentials.
2. Use existing Kubernetes Secrets in production.
3. Keep image tags pinned and patch regularly.
4. Keep anonymous access explicit and minimal.
5. Enable TLS on all public ingress endpoints.

## Values and Examples

- Main values: [values.yaml](values.yaml)
- JSON schema: [values.schema.json](values.schema.json)
- Example values:
  - [examples/values.example.minimal.yaml](../../examples/values.example.minimal.yaml)
  - [examples/values.example.ingress-tls.yaml](../../examples/values.example.ingress-tls.yaml)
  - [examples/values.example.external-db.yaml](../../examples/values.example.external-db.yaml)
  - [examples/values.example.bootstrap.yaml](../../examples/values.example.bootstrap.yaml)

## Project Links

- Repository: <https://github.com/sergey-zinchenko/nexus-free-chart>
- Issues: <https://github.com/sergey-zinchenko/nexus-free-chart/issues>
- Nexus Documentation: <https://help.sonatype.com/en/sonatype-nexus-repository.html>
