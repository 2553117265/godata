# escape=`
FROM --platform=windows/amd64 golang:1.26.5-windowsservercore-ltsc2022
SHELL ["powershell", "-NoLogo", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENV CGO_ENABLED=0
ENV GOTOOLCHAIN=local

WORKDIR C:\workspace
COPY . .
RUN if (Test-Path -LiteralPath go.mod) { go mod download }
WORKDIR C:\workspace\pkg\skaffold\schema\util
RUN if (Test-Path -LiteralPath go.mod) { go mod download }

CMD ["go","test","-json","-count=3",".","-run","^TestFlatMap_UnmarshalYAMLNestedArrays$"]
