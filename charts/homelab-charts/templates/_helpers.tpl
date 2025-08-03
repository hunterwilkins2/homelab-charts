{{- define "homelab.fullname" -}}
{{- .Values.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "homelab.labels" -}}
{{- if gt (len .Values.global.labels) 0 }}
  {{- .Values.global.labels | toYaml }}
{{ end }}
{{- include "homelab.selectors" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "homelab.annotations" -}}
{{- .Values.global.annotations | toYaml -}}
{{- end -}}

{{- define "homelab.selectors" -}}
app.kubernetes.io/name: {{ include "homelab.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
