# Claude Code statusLine script
# Shows real account-level rate limit usage (5-hour and 7-day windows)
# for Claude Pro/Max subscribers, in amber/gold ANSI truecolor.
#
# Reads the statusLine JSON payload from stdin and prints a single
# status line. Falls back to "N/A" when rate limit data is not present
# (e.g. first message of a session, or non-Pro/Max accounts).

$ErrorActionPreference = 'SilentlyContinue'

try {
    $raw = [Console]::In.ReadToEnd()
    $data = $raw | ConvertFrom-Json
} catch {
    $data = $null
}

function Get-JsonPath {
    param($obj, $path)
    $parts = $path -split '\.'
    $cur = $obj
    foreach ($p in $parts) {
        if ($null -eq $cur) { return $null }
        if ($cur.PSObject.Properties.Name -contains $p) {
            $cur = $cur.$p
        } else {
            return $null
        }
    }
    return $cur
}

$esc = [char]27
$labelColor = "${esc}[38;2;122;82;0m"
$valueColor = "${esc}[38;2;255;176;0m"
$warnColor  = "${esc}[38;2;255;69;0m"
$reset      = "${esc}[0m"

function Format-Pct {
    param($val)
    if ($null -eq $val) { return "N/A" }
    return ([math]::Round([double]$val)).ToString() + "%"
}

function Get-ValueColor {
    param($val)
    if ($null -ne $val -and [double]$val -ge 90) { return $warnColor }
    return $valueColor
}

$fivePct = Get-JsonPath $data 'rate_limits.five_hour.used_percentage'
$weekPct = Get-JsonPath $data 'rate_limits.seven_day.used_percentage'

$fiveStr = Format-Pct $fivePct
$weekStr = Format-Pct $weekPct

$fiveColor = Get-ValueColor $fivePct
$weekColor = Get-ValueColor $weekPct

$output = $labelColor + "5H " + $fiveColor + $fiveStr + $reset + $labelColor + "  |  " + "7D " + $weekColor + $weekStr + $reset

Write-Output $output