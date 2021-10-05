del /q *.nupkg
nuget pack package.nuspec
nuget push *.nupkg
