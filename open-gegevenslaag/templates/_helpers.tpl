{{/*
Expand the name <CHARTNAME> the chart.
*/}}
{{- define "<CHARTNAME>.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "<CHARTNAME>.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "<CHARTNAME>.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "<CHARTNAME>.commonLabels" -}}
helm.sh/chart: {{ include "<CHARTNAME>.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
<CHARTNAME> labels
*/}}
{{- define "<CHARTNAME>.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "<CHARTNAME>.commonLabels" . }}
{{ include "<CHARTNAME>.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "<CHARTNAME>.selectorLabels" -}}
app.kubernetes.io/name: {{ include "<CHARTNAME>.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "<CHARTNAME>.workerName" -}}
{{ include "<CHARTNAME>.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "<CHARTNAME>.workerFullname" -}}
{{ include "<CHARTNAME>.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "<CHARTNAME>.workerLabels" -}}
{{ include "<CHARTNAME>.commonLabels" . }}
{{ include "<CHARTNAME>.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "<CHARTNAME>.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "<CHARTNAME>.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "<CHARTNAME>.flowerName" -}}
{{ include "<CHARTNAME>.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "<CHARTNAME>.flowerFullname" -}}
{{ include "<CHARTNAME>.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "<CHARTNAME>.flowerLabels" -}}
{{ include "<CHARTNAME>.commonLabels" . }}
{{ include "<CHARTNAME>.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "<CHARTNAME>.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "<CHARTNAME>.flowerName" . }}
{{- end  }}

{{/*
Create a name for Beat
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "<CHARTNAME>.beatName" -}}
{{ include "<CHARTNAME>.name" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Create a default fully qualified name for the beat.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "<CHARTNAME>.beatFullname" -}}
{{ include "<CHARTNAME>.fullname" . | trunc 56 | trimSuffix "-" }}-beat
{{- end }}

{{/*
Beat labels
*/}}
{{- define "<CHARTNAME>.beatLabels" -}}
{{ include "<CHARTNAME>.commonLabels" . }}
{{ include "<CHARTNAME>.beatSelectorLabels" . }}
{{- end }}

{{/*
Beat selector labels
*/}}
{{- define "<CHARTNAME>.beatSelectorLabels" -}}
app.kubernetes.io/name: {{ include "<CHARTNAME>.beatName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "<CHARTNAME>.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "<CHARTNAME>.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for Config job
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "<CHARTNAME>.configName" -}}
{{ include "<CHARTNAME>.name" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
Create a default fully qualified name for config.
We truncate at 56 chars in order to provide space for the "-config" suffix
*/}}
{{- define "<CHARTNAME>.configFullname" -}}
{{ include "<CHARTNAME>.fullname" . | trunc 56 | trimSuffix "-" }}-config
{{- end }}

{{/*
config labels
*/}}
{{- define "<CHARTNAME>.configLabels" -}}
{{ include "<CHARTNAME>.commonLabels" . }}
{{ include "<CHARTNAME>.configSelectorLabels" . }}
{{- end }}

{{/*
config selector labels
*/}}
{{- define "<CHARTNAME>.configSelectorLabels" -}}
app.kubernetes.io/name: {{ include "<CHARTNAME>.configName" . }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "<CHARTNAME>.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "<CHARTNAME>.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "<CHARTNAME>.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
