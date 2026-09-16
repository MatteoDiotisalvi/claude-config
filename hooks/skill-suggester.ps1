param()

# UserPromptSubmit hook: matches the incoming prompt against skill-triggers.json and,
# on a hit, injects a reminder into Claude's context via hookSpecificOutput.additionalContext.
# Design goals: never block the prompt, never throw past this script, run in a few ms.

$ErrorActionPreference = 'Stop'
# Deliberately NOT setting [Console]::InputEncoding: on an already-redirected stdin in
# Windows PowerShell 5.1 this injects a spurious BOM character and breaks ConvertFrom-Json.
try { [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false) } catch {}

$hookDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$triggersPath = Join-Path $hookDir 'skill-triggers.json'
$logPath = Join-Path $hookDir 'skill-suggester.log'

function Write-SafeLog {
    param([string]$Message)
    try {
        $line = "{0}`t{1}" -f (Get-Date -Format 'o'), $Message
        Add-Content -LiteralPath $logPath -Value $line -Encoding utf8
    } catch { }
}

try {
    $stdin = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($stdin)) { exit 0 }
    $stdin = $stdin.TrimStart([char]0xFEFF)  # defensive: strip a stray BOM if one shows up

    $payload = $stdin | ConvertFrom-Json -ErrorAction Stop
    $prompt = $payload.prompt
    if ([string]::IsNullOrWhiteSpace($prompt)) { exit 0 }
    if (-not (Test-Path -LiteralPath $triggersPath)) { exit 0 }

    $triggers = Get-Content -LiteralPath $triggersPath -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
    $promptLower = $prompt.ToLowerInvariant()

    $hits = New-Object System.Collections.Generic.List[object]
    foreach ($prop in $triggers.PSObject.Properties) {
        $skillName = $prop.Name
        $def = $prop.Value
        foreach ($kw in $def.keywords) {
            if ($promptLower -match $kw) {
                $hits.Add([PSCustomObject]@{ Skill = $skillName; Reason = $def.reason })
                break
            }
        }
    }

    if ($hits.Count -eq 0) { exit 0 }

    $preview = $prompt.Substring(0, [Math]::Min(100, $prompt.Length)) -replace '[\r\n\t]', ' '
    Write-SafeLog ("MATCH prompt=`"{0}`" skills={1}" -f $preview, (($hits | ForEach-Object { $_.Skill }) -join ','))

    $lines = $hits | ForEach-Object { "- $($_.Skill): $($_.Reason)" }
    $contextText = "[skill-suggester hook] Keyword match against this prompt found candidate skill(s) below. " +
        "Before answering, briefly confirm whether one genuinely applies (invoke it via the Skill tool) or state in one line why it does not. " +
        "This is a mechanical keyword match, not a judgment, false positives are expected and fine to dismiss.`n" +
        ($lines -join "`n")

    $result = [PSCustomObject]@{
        hookSpecificOutput = [PSCustomObject]@{
            hookEventName     = 'UserPromptSubmit'
            additionalContext = $contextText
        }
    }

    $json = $result | ConvertTo-Json -Depth 6 -Compress
    [Console]::Out.Write($json)
    exit 0
} catch {
    try { Write-SafeLog ("ERROR {0}" -f $_.Exception.Message) } catch {}
    exit 0
}
