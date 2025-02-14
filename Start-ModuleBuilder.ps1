
#Requires -Modules ModuleBuilder
<#
.NOTES
Including the modulebuilder which takes all of the ps1 files and combines them into a single psm1 file.
The playtyPS is used to build the markdown help files for the module.

#>
Param (
	[version]
	$Version="2025.2.14.1",
	
	[switch]
	$OverwriteUserModule,

	[switch]
	$UpdateDocumentation


)
$params = @{
	SourcePath = "$($PSScriptRoot)\HuduAPI\HuduAPI.psd1"
	CopyPaths = "$($PSScriptRoot)\README.md"
	Version = $Version
	UnVersionedOutputDirectory = $true
	OutputDirectory = "$($PSScriptRoot)\Output"
	PublicFilter = @("Public","Private")
}
Build-Module @params -Verbose

if ($params.UnVersionedOutputDirectory -eq $true ) {
	$OutputDirectory = "$($PSScriptRoot)\Output\HuduAPI"
} else {
	$OutputDirectory = "$($PSScriptRoot)\Output\HuduAPI\$($Version)"
}


if ([System.IO.File]::Exists("$($OutputDirectory)\HuduAPI.psm1")) {
	#Add-Content -Path "$($OutputDirectory)\HuduAPI.psm1" -Value "Invoke-HuduAPIStartup"
}

if ($OverwriteUserModule -eq $true) {	
	$UserModulePath = "$($env:USERPROFILE)\Documents\PowerShell\Modules"
	Write-Host "Copying HuduAPI Files to $($UserModulePath)\HuduAPI" -ForegroundColor Green
	Copy-Item "$($OutputDirectory)" -Destination $UserModulePath -Force -Recurse
}

if ($UpdateDocumentation -eq $true) {
	Remove-Module HuduAPI -ErrorAction SilentlyContinue
	Import-Module HuduAPI
	New-MarkdownHelp -Module HuduAPI -OutputFolder "$($PSScriptRoot)\Docs\" -Force
}
