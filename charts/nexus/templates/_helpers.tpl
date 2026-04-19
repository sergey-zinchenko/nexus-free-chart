{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nexus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nexus.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nexus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "nexus.labels" -}}
helm.sh/chart: {{ include "nexus.chart" . }}
{{ include "nexus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "nexus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nexus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "nexus.serviceAccountName" -}}
{{- if .Values.serviceAccount.enabled -}}
    {{ default (include "nexus.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the default FQDN for the nexus headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "nexus.service.headless" -}}
{{- printf "%s-hl" (include "nexus.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Handles merging common service annotations with headless service annotations
*/}}
{{- define "nexus.service.headless.annotations" -}}
{{- $allAnnotations := merge (default (dict) (default (dict) .Values.service.headless).annotations) .Values.service.annotations -}}
{{- if $allAnnotations -}}
{{- toYaml $allAnnotations -}}
{{- end -}}
{{- end -}}

{{/*
Secret name containing database credentials.
*/}}
{{- define "nexus.dbSecretName" -}}
{{- if and .Values.secret.existingDbSecret .Values.secret.existingDbSecret.enabled .Values.secret.existingDbSecret.name -}}
{{- .Values.secret.existingDbSecret.name -}}
{{- else -}}
{{- printf "%s-dbsecret" (include "nexus.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Key name for database username in DB secret.
*/}}
{{- define "nexus.dbSecretUsernameKey" -}}
{{- default "db-user" .Values.secret.existingDbSecret.usernameKey -}}
{{- end -}}

{{/*
Key name for database password in DB secret.
*/}}
{{- define "nexus.dbSecretPasswordKey" -}}
{{- default "db-password" .Values.secret.existingDbSecret.passwordKey -}}
{{- end -}}

{{/*
Secret name containing Nexus admin password.
*/}}
{{- define "nexus.adminSecretName" -}}
{{- if and .Values.secret.nexusAdminSecret.existingSecret .Values.secret.nexusAdminSecret.existingSecret.enabled .Values.secret.nexusAdminSecret.existingSecret.name -}}
{{- .Values.secret.nexusAdminSecret.existingSecret.name -}}
{{- else -}}
{{- printf "%s-adminsecret" (include "nexus.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Key name for Nexus admin password in admin secret.
*/}}
{{- define "nexus.adminSecretPasswordKey" -}}
{{- default "nexus-admin-password" .Values.secret.nexusAdminSecret.existingSecret.key -}}
{{- end -}}

{{/*
Secret name containing Nexus encryption key material.
*/}}
{{- define "nexus.encryptionSecretName" -}}
{{- if and .Values.secret.nexusSecret.existingSecret .Values.secret.nexusSecret.existingSecret.enabled .Values.secret.nexusSecret.existingSecret.name -}}
{{- .Values.secret.nexusSecret.existingSecret.name -}}
{{- else -}}
{{- default (printf "%s-nexus-secret" (include "nexus.fullname" .)) .Values.secret.nexusSecret.name -}}
{{- end -}}
{{- end -}}

{{/*
Key name for Nexus encryption key in secret.
*/}}
{{- define "nexus.encryptionSecretKey" -}}
{{- if and .Values.secret.nexusSecret.existingSecret .Values.secret.nexusSecret.existingSecret.enabled .Values.secret.nexusSecret.existingSecret.key -}}
{{- .Values.secret.nexusSecret.existingSecret.key -}}
{{- else -}}
{{- default "secret.key" .Values.secret.nexusSecret.key -}}
{{- end -}}
{{- end -}}

{{/*
ConfigMap name containing shell bootstrap scripts for Nexus REST API resources.
*/}}
{{- define "nexus.bootstrapConfigMapName" -}}
{{- printf "%s-bootstrap" (include "nexus.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Stable role id for Helm-managed repository read access.
*/}}
{{- define "nexus.bootstrapRoleId" -}}
{{- $format := lower .format -}}
{{- $name := regexReplaceAll "[^a-z0-9]+" (lower .name) "-" | trimAll "-" -}}
{{- $access := default "read" .access | lower -}}
{{- printf "helm-repo-%s-%s-%s" $format $name $access | trunc 128 | trimSuffix "-" -}}
{{- end -}}