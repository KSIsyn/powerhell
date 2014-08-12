<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2014 v4.1.54
	 Created on:   	7/23/2014 11:03 AM
	 Created by:   	KSI Syn
	 Organization: 	SCN
	 Filename:     	Microsoft.PowerShell_profile.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

function Get-Uptime{
$computer="localhost"
$time=Get-WmiObject -class Win32_OperatingSystem -computer $computer
$t=$time.ConvertToDateTime($time.Lastbootuptime)
[TimeSpan]$uptime=New-TimeSpan $t $(get-date)
"$($uptime.days) days $($uptime.hours):$($uptime.minutes)"
}

Function god-mode
{
	$computername = $env:computername.tolower()
	$a = $host.UI.RawUI
	$a.WindowTitle = "Windows Powershell"
#	$a.BackgroundColor = "Black"
#	$a.ForegroundColor = "White"
	
} #end function

function get-pro { notepad $profile }

Function Get-QOTD
{
	
	[cmdletBinding()]
	
	Param ()
	
	Write-Verbose "Starting Get-QOTD"
	#create the webclient object
	$webclient = New-Object System.Net.WebClient
	
	#define the url to connect to
	$url = "http://feeds.feedburner.com/brainyquote/QUOTEBR"
	
	Write-Verbose "Connecting to $url"
	Try
	{
		#retrieve the url and save results to an XML document
		[xml]$data = $webclient.downloadstring($url)
		#parse out the XML document to get the first item which
		#will be the most recent quote
		$quote = $data.rss.channel.item[0]
	}
	Catch
	{
		$msg = "There was an error connecting to $url"
		$msg += $_.Exception.Message
		Write-Warning $msg
	}
	
	if ($quote)
	{
		Write-Verbose $quote.OrigLink
		"{0} - {1}" -f $quote.Description, $quote.Title
	}
	else
	{
		Write-Warning "Failed to get data from $url"
	}
	
	Write-Verbose "Ending Get-QOTD"
	write-host ""
	
} #end function
$env:USERPROFILE
cd $env:USERPROFILE\Documents\GitHub\

$Uptime = Get-Uptime
[system.Version] $version = $PSVersionTable.PSVersion
$q = get-qotd

god-mode

Write-Host "`n`tWelcome to Microsoft Powershell" -ForegroundColor 'Magenta'
Write-Host "`tVersion: $version" -ForegroundColor 'Cyan'
Write-Host "`t`tCurrent System Uptime is $uptime`n`n"
write-host "`tYour Qoute of the day" -ForegroundColor 'Yellow'
write-host "`t`t$q`n" -foregroundcolor 'Green'