{{- define "teamcity-server.init" -}}
{{- if .Values.initImage.sha }}
image: "{{ .Values.initImage.repository }}:{{ .Values.initImage.tag }}@sha256:{{ .Values.initImage.sha }}"
{{- else }}
image: "{{ .Values.initImage.repository }}:{{ .Values.initImage.tag }}"
{{- end }}
imagePullPolicy: {{ .Values.initImage.pullPolicy }}
securityContext:
  runAsNonRoot: false
  runAsUser: 0
volumeMounts:
  - name: storage
    mountPath: /data/teamcity_server/datadir
    {{- if .Values.persistence.subPath }}
    subPath: {{ tpl .Values.persistence.subPath . }}
    {{- end }}
{{- end -}}
