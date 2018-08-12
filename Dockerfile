# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016 as build

COPY . .

RUN nuget restore; `
    msbuild .\AspNetApplication\AspNetApplication.csproj /nologo /v:m /t:Build /p:DeployOnBuild=true /p:PublishProfile=FolderProfile


FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016

RUN net localgroup "Performance Monitor Users" "IIS APPPOOL\DefaultAppPool" /add

COPY --from=build ./publish/ /inetpub/wwwroot