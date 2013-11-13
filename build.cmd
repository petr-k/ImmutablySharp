SET Config=%1
IF "%Config%" == "" (
  SET Config=Release
)

SET PackageVersion=%2
IF "%PackageVersion%" == "" (
  SET PackageVersion=1.0.0.0
)

SET BasePath=%~dp0
SET NuGetExePath=%BasePath%tools\nuget.exe

"%NuGetExePath%" restore "%BasePath%src\ImmutablySharp.sln"

%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild.exe "%BasePath%src\ImmutablySharp.sln" /t:Rebuild /p:Configuration="%Config%"

%NuGetExePath% pack "%BasePath%nuspec\ImmutablySharp.nuspec" -NoPackageAnalysis -verbosity detailed -o . -Version %PackageVersion% -p Configuration="%Config%" -OutputDirectory "%BasePath%output"
