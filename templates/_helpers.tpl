{{- define "homelab.fullname" -}}
{{- if .Values.global.fullnameOverride -}}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}