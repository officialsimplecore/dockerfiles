# Dotnet Web API Dockerfile -- Ensure to change the entry point dll file name and versions

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source
# restore nuget packages
COPY *.csproj .
RUN dotnet restore
# copy source code
COPY . .
# build the source code using the SDK
RUN dotnet publish -c release -o /executable --no-restore

# runs the deployable using a separate image
# that is shipped with the .NET Runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /executable .
ENTRYPOINT ["dotnet", "{PROJECT_NAME}.dll"]
