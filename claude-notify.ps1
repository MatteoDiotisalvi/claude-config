param(
    [string]$Title = "Claude Code",
    [string]$Message = "Claude needs your attention"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notification = New-Object System.Windows.Forms.NotifyIcon
$notification.Icon = [System.Drawing.SystemIcons]::Information
$notification.BalloonTipTitle = $Title
$notification.BalloonTipText = $Message
$notification.Visible = $true

$notification.ShowBalloonTip(5000)

Start-Sleep -Seconds 6

$notification.Dispose()