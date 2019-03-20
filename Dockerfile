# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016 as build

RUN Invoke-WebRequest -UseBasicParsing https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi -OutFile WebDeploy_amd64_en-US.msi; `
    Start-Process WebDeploy_amd64_en-US.msi -ArgumentList '/qn' -Wait; `
    Remove-Item -Force WebDeploy_amd64_en-US.msi

COPY . .

RUN nuget restore; `
    msbuild .\AspNetApplication\AspNetApplication.csproj /nologo /v:m /t:Build /p:DeployOnBuild=true /p:PublishProfile=FolderProfile


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2016

COPY --from=build ./publish/ /inetpub/wwwroot

RUN net localgroup 'Performance Monitor Users' 'IIS APPPOOL\DefaultAppPool' /add