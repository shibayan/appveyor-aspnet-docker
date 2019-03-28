# escape=`

FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019 as build

COPY . .

RUN nuget restore; `
    msbuild .\AspNetApplication\AspNetApplication.csproj /nologo /v:m /t:Build /p:Configuration=Release /p:DeployOnBuild=true /p:PublishProfile=FolderProfile


FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019

COPY --from=build ./publish/ /inetpub/wwwroot

RUN net localgroup 'Performance Monitor Users' 'IIS APPPOOL\DefaultAppPool' /add