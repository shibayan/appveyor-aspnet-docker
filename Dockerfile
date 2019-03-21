# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016 as build

COPY . .

RUN nuget restore; `
    msbuild .\AspNetApplication\AspNetApplication.csproj /nologo /v:m /t:Build /p:Configuration=Release /p:DeployOnBuild=true /p:PublishProfile=FolderProfile


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2016

COPY --from=build ./publish/ /inetpub/wwwroot

RUN net localgroup 'Performance Monitor Users' 'IIS APPPOOL\DefaultAppPool' /add