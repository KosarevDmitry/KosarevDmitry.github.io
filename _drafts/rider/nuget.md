* nupkg is zip essentialy, so is opened usual way if to chahge the extension   

* How is look like  .csproj file which is convinient for nuget installation.I am going to add modifications later.
```xml 
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFrameworks>netstandard2.1;net6.0;net7.0;net8.0</TargetFrameworks>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
    <LangVersion>10.0</LangVersion>
    <GeneratePackageOnBuild>true</GeneratePackageOnBuild>
    <Authors>KosarevDm</Authors>
    <Version>1.0.0</Version>
    <Copyright>KosarevDm</Copyright>
    <PackageTags>C# Utility</PackageTags>
    <PackageLicenseExpression>MIT</PackageLicenseExpression>
    <PackageReadmeFile>readme.md</PackageReadmeFile>
    <Description>Utility for the personal using</Description>
  </PropertyGroup>

  <ItemGroup>
        <None Include="docs\readme.md" Pack="true" PackagePath="\" />
   </ItemGroup>
</Project>

```

* The pseudocode script for local manipulation with  a nuget package.

```bash
csproj="mylib.csproj"
open $csproj
find  <PropertyGroup> Node
add children "<GeneratePackageOnBuild>true</GeneratePackageOnBuild>"
lang= find <LangVersion> node 
$lang.content="10.0"
target=find  <TargetFrameworks> node 
$target.content ="netstandard2.1;net6.0;net7.0;net8.0" 
dotnet build 
!IsExist (nuget)  then
  download nuget.exe  --source <https://www.nuget.org/downloads>

folder = 'C:\nuget_repo`  
cp nuget.exe $folder 
path= path; $folder
cd ../bin/mypackage.1.0.0.nupkg
nuget add  mypackage.1.0.0.nupkg -source $folder
# ~~nuget delete Myattr.1.0.0.nupkg_ -source C:\nuget_repo~~  **fail**
nuget delete mypackage 1.0.0 -source $folder  **correct**
      
newprog="....src\name\"  
cd  newprog
dotnet add package mypackage.1.0.0.nupkg

# --- replacement if I pack repeatedly the same version, substitution is not happend  so remove package 
# dotnet delete package mypackage.1.0.0.nupkg
# rm	C:\Users\User\.nuget\packages\mypackage\1.0.0 
# dotnet add package mypackage.1.0.0.nupkg
```
