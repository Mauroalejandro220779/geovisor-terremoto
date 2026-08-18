try {
    $stdin = [Console]::In.ReadToEnd()
    $payload = $stdin | ConvertFrom-Json
} catch {
    exit 0
}

$filePath = $payload.tool_input.file_path
if (-not $filePath) { $filePath = $payload.tool_response.filePath }
if (-not $filePath -or $filePath -notmatch 'index\.html$') { exit 0 }

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Set-Location $repoRoot

$diff = git diff -- index.html 2>$null
if (-not $diff) { exit 0 }

$changed = $diff | Where-Object { $_ -match '^[+-][^+-]' }
$touchedTimestamp = $changed | Where-Object { $_ -match 'SITE_LAST_UPDATED' }
$otherChanges = $changed | Where-Object { $_ -notmatch 'SITE_LAST_UPDATED' }

if ($otherChanges -and -not $touchedTimestamp) {
    $result = @{
        decision = 'block'
        reason = 'index.html content changed but SITE_LAST_UPDATED was not bumped. Update the SITE_LAST_UPDATED constant near the data array before finishing (project rule: content changes must bump the timestamp; pure infra changes do not count).'
    }
    $result | ConvertTo-Json -Compress
}
exit 0
