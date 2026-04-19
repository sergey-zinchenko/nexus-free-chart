# Security Policy

## Reporting security issues

Please do not report security vulnerabilities in public issues.

Preferred channel:

- GitHub Security Advisory form: `/security/advisories/new`

Fallback channel:

- Email: `sergey.zinchenko.rnd@gmail.com`

Please include:

- affected chart version
- clear reproduction steps
- expected vs actual behavior
- impact assessment
- any proposed fix or mitigation

## Triage and response

This project is maintained by a single maintainer on a best-effort basis.

I will:

- acknowledge valid reports as soon as possible
- reproduce and triage the issue
- prioritize fixes based on severity and exploitability
- publish a coordinated fix and notes when ready

There is no guaranteed SLA for response or fix delivery.

## Scope

This policy covers:

- Helm templates and defaults in this repository
- chart examples and release workflows

This policy does not directly cover vulnerabilities in third-party software (for example, Kubernetes, container runtime, Nexus image, PostgreSQL image), but reports that affect safe chart usage are welcome.

## Severity levels

- Critical: remote compromise or major integrity/confidentiality impact with minimal prerequisites.
- High: serious impact but requires specific conditions or elevated positioning.
- Moderate: meaningful but limited impact, such as partial disruption.
- Low: minor or hard-to-exploit issues with low practical impact.

CVSS may be used as supporting input, but final priority is based on real deployment impact for this chart.

## Disclosure policy

For confirmed vulnerabilities, I aim for coordinated disclosure:

- fix first
- publish advisory and release notes after a patch is available

If immediate disclosure is needed to protect users, I may publish mitigation guidance before a full fix is released.
