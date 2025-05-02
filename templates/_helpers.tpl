{{/*
Expand the namespace of the chart.
*/}}
{{- define "peertube.namespace" -}}
{{- if eq $.Release.Namespace "default"}}
{{- .Values.namespace }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "peertube.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the proxy name of the chart.
*/}}
{{- define "peertube.proxy.name" -}}
{{- printf "%s-proxy" ( include "peertube.name" . ) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the node name of the chart.
*/}}
{{- define "peertube.node.name" -}}
{{- printf "%s-node" ( include "peertube.name" . ) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the pg name of the chart.
*/}}
{{- define "peertube.pg.name" -}}
{{- printf "%s-pg" ( include "peertube.name" . ) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the redis name of the chart.
*/}}
{{- define "peertube.redis.name" -}}
{{- printf "%s-redis" ( include "peertube.name" . ) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the postfix name of the chart.
*/}}
{{- define "peertube.postfix.name" -}}
{{- printf "%s-postfix" ( include "peertube.name" . ) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "peertube.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if eq .Release.Name "release-name" }}
{{- printf "%s-%s" .Values.defaultName $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified proxy name.
*/}}
{{- define "peertube.proxy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if eq .Release.Name "release-name" }}
{{- printf "%s-%s-proxy" .Values.defaultName $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-proxy" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified node name.
*/}}
{{- define "peertube.node.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if eq .Release.Name "release-name" }}
{{- printf "%s-%s-node" .Values.defaultName $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-node" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified pg name.
*/}}
{{- define "peertube.pg.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if eq .Release.Name "release-name" }}
{{- printf "%s-%s-pg" .Values.defaultName $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-pg" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified redis name.
*/}}
{{- define "peertube.redis.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if eq .Release.Name "release-name" }}
{{- printf "%s-%s-redis" .Values.defaultName $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-redis" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified postfix name.
*/}}
{{- define "peertube.postfix.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- if eq .Release.Name "release-name" }}
{{- printf "%s-%s-postfix" .Values.defaultName $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-postfix" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "peertube.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "peertube.labels" -}}
helm.sh/chart: {{ include "peertube.chart" . }}
{{ include "peertube.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common proxy labels
*/}}
{{- define "peertube.proxy.labels" -}}
helm.sh/chart: {{ include "peertube.chart" . }}
{{ include "peertube.proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common node labels
*/}}
{{- define "peertube.node.labels" -}}
helm.sh/chart: {{ include "peertube.chart" . }}
{{ include "peertube.node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common pg labels
*/}}
{{- define "peertube.pg.labels" -}}
helm.sh/chart: {{ include "peertube.chart" . }}
{{ include "peertube.pg.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common redis labels
*/}}
{{- define "peertube.redis.labels" -}}
helm.sh/chart: {{ include "peertube.chart" . }}
{{ include "peertube.redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common postfix labels
*/}}
{{- define "peertube.postfix.labels" -}}
helm.sh/chart: {{ include "peertube.chart" . }}
{{ include "peertube.postfix.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "peertube.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peertube.name" . }}
{{- if eq .Release.Name "release-name" }}
app.kubernetes.io/instance: {{ .Values.defaultName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Selector proxy labels
*/}}
{{- define "peertube.proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peertube.proxy.name" . }}
{{- if eq .Release.Name "release-name" }}
app.kubernetes.io/instance: {{ .Values.defaultName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Selector node labels
*/}}
{{- define "peertube.node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peertube.node.name" . }}
{{- if eq .Release.Name "release-name" }}
app.kubernetes.io/instance: {{ .Values.defaultName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Selector pg labels
*/}}
{{- define "peertube.pg.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peertube.pg.name" . }}
{{- if eq .Release.Name "release-name" }}
app.kubernetes.io/instance: {{ .Values.defaultName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Selector redis labels
*/}}
{{- define "peertube.redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peertube.redis.name" . }}
{{- if eq .Release.Name "release-name" }}
app.kubernetes.io/instance: {{ .Values.defaultName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Selector postfix labels
*/}}
{{- define "peertube.postfix.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peertube.postfix.name" . }}
{{- if eq .Release.Name "release-name" }}
app.kubernetes.io/instance: {{ .Values.defaultName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "peertube.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "peertube.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
