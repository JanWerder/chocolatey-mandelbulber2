$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/buddhi1980/mandelbulber2/releases/download/2.34/Mandelbulber2-v2.34.2-Setup.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = $url
  softwareName   = 'Mandelbulber2*'
  checksum       = '0929eab9126f759dc8a9a7c64c579e8cd3bac92bb923e5c93d516dc97996f3a2'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
