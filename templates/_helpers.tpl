{{- define "homelab.fullname" -}}
  {{- if .Values.global.nameOverride -}}
    {{- .Values.global.nameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- printf .Release.Name | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "homelab.labels" -}}
labels:
    {{- if gt (len .Values.global.labels) 0 }}
      {{- .Values.global.labels | toYaml | nindent 4 }}
    {{- end }}
    app.kubernetes.io/name: {{ include "homelab.fullname" . }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    app.kubernetes.io/version: {{ .Chart.AppVersion }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "homelab.annotations" -}}
{{ if gt (len .Values.global.annotations) 0 }}
  annotations:
    {{- .Values.global.annotations | toYaml | nindent 4 -}}
{{- end -}}
{{- end -}}
