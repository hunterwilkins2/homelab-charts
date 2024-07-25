{{- define "homelab.db.fullname" -}}
{{- if .Values.global.fullnameOverride -}}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-db" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}