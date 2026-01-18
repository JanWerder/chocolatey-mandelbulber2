import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyinstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        'mandelbulber2.nuspec' = @{
            "(<version>).*?(</version>)" = "`$1$($Latest.Version)`$2"
        }
    }
}

function global:au_GetLatest {
    $headers = @{}
    if ($env:GITHUB_TOKEN) {
        $headers['Authorization'] = "token $env:GITHUB_TOKEN"
    }
    $release = Invoke-RestMethod -Uri 'https://api.github.com/repos/buddhi1980/mandelbulber2/releases/latest' -Headers $headers
    $asset = $release.assets | Where-Object { $_.name -match 'Setup\.exe$' } | Select-Object -First 1

    $url = $asset.browser_download_url
    $version = $release.tag_name
    $checksum = Get-RemoteChecksum $url

    return @{ URL32 = $url; Version = $version; Checksum32 = $checksum; ChecksumType32 = 'sha256' }
}

update
