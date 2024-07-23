{{- define "fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}