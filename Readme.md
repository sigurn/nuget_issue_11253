# Test repository to reproduce NuGet Issue [#11253](https://github.com/NuGet/Home/issues/11253)

## Files

 * build.proj -- MSBuild project which has references to packages and target `Test` to show package reference result
 * build_vs2017.cmd -- Builds build.proj file using Visual Studio 2017
 * build_vs2019.cmd -- Builds build.proj file using Visual Studio 2019
 * build_vs2019.cmd -- Builds build.proj file using Visual Studio 2019 but it uses packages with `buildTransitive` folders
 * clean.cmd -- Removes all files created by `build_*.cmd` files
 * NuGet.Config -- NuGet configuration file, adds directory `packages` to NuGet sources
 * global.json -- SDK configuration. Defines version of `Microsoft.Build.NoTargets` SDK. 
 * out_vs2017.txt -- Output of running `Test` target in `build.proj` file using Visual Studio 2017
 * out_vs2019.txt -- Output of running `Test` target in `build.proj` file using Visual Studio 2019
 * out_vs2019_transitive.txt -- Output of running `Test` target in `build.proj` file using Visual Studio 2019 but using packages with `buildTransitive` folders


## Directories

 * packages -- NuGet packages source. It contains test packages.
 * package_sources -- Sources of all packages in `packages` directory.
 * out_vs2017 -- Files created during restore of `build.proj` using Visual Studio 2017
 * out_vs2019 -- Files created during restore of `build.proj` using Visual Studio 2019
 * out_vs2019_transitive -- Files created during restore of `build.proj` using Visual Studio 2019 but using packages with `buildTransitive` folders

## Run

To run build just run  `build_*.cmd` files but make sure that path to VS in those files is correct

## Build packages

Every package in `package_sources` folder has `build.cmd` file whicg creates package and pushed it to `packages` folder.

**NOTE:** build.cmd uses `nuget` so path to NuGet should be configured in environment PATH variable.

## Problem

Using the same project and the same packages Visual Studio 2017 produces correct result using transitive depndencies whereas Visual Studio 2019 uses only direct references and ignores transitive dependencies that we can see in `out_vs*.txt` files

### Visual Studio 2017

*build.proj.nuget.g.props*
```
  <ImportGroup Condition=" '$(ExcludeRestorePackageImports)' != 'true' ">
    <Import Project="$(NuGetPackageRoot)nuget.issue11253.packageb\1.0.0\build\NuGet.Issue11253.PackageB.props" Condition="Exists('$(NuGetPackageRoot)nuget.issue11253.packageb\1.0.0\build\NuGet.Issue11253.PackageB.props')" />
    <Import Project="$(NuGetPackageRoot)nuget.issue11253.packagea\1.0.0\build\NuGet.Issue11253.PackageA.props" Condition="Exists('$(NuGetPackageRoot)nuget.issue11253.packagea\1.0.0\build\NuGet.Issue11253.PackageA.props')" />
  </ImportGroup>
```

*out_vs2017.txt*
```
     1>Test:
         D:\nuget\packages\nuget.issue11253.packageb\1.0.0\build\PackageB.wxi
         D:\nuget\packages\nuget.issue11253.packagea\1.0.0\build\PackageA.wxi
```

### Visual Studio 2019

*build.proj.nuget.g.props*
```
  <ImportGroup Condition=" '$(ExcludeRestorePackageImports)' != 'true' ">
    <Import Project="$(NuGetPackageRoot)nuget.issue11253.packagea\1.0.0\build\NuGet.Issue11253.PackageA.props" Condition="Exists('$(NuGetPackageRoot)nuget.issue11253.packagea\1.0.0\build\NuGet.Issue11253.PackageA.props')" />
  </ImportGroup>
```

*out_vs2019.txt*
```
     1>Test:
         D:\nuget\packages\nuget.issue11253.packagea\1.0.0\build\PackageA.wxi
```