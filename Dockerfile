# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk as build

COPY . .

RUN nuget restore; `
    msbuild .\AspNetApplication\AspNetApplication.csproj /nologo /v:m /t:Build /p:DeployOnBuild=true /p:PublishProfile=FolderProfile


FROM microsoft/aspnet:4.7.2

COPY --from=build ./publish/ /inetpub/wwwroot