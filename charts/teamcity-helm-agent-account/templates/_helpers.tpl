{{- define "teamcity-helm-agent-account.namespace" -}}
  {{- if .Values.namespace -}}
    {{- .Values.namespace -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{- define "teamcity-helm-agent-account.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "teamcity-helm-agent-account.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "teamcity-helm-agent-account.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "teamcity-helm-agent-account.labels" -}}
helm.sh/chart: {{ include "teamcity-helm-agent-account.chart" . }}
{{ include "teamcity-helm-agent-account.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "teamcity-helm-agent-account.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamcity-helm-agent-account.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "teamcity-helm-agent-account.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "teamcity-helm-agent-account.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
