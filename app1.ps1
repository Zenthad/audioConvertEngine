<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.156
	 Created on:   	2/1/2019 3:12 PM
	 Created by:   	Thaddeus Pearson
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

# declare the function that will be used to choose the source files

Function Get-AudioFiles($initialDirectory)
{
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	
	$foldername = New-Object System.Windows.Forms.OpenFileDialog
	
	if ($foldername.ShowDialog() -eq "OK")
	{
		$folder += $foldername.FileNames
	}
	return $folder
}

# declare the function that will be used to choose the destination folder

Function Get-AudioFolder($initialDirectory)
{
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	
	$foldername = New-Object System.Windows.Forms.FolderBrowserDialog
	
	if ($foldername.ShowDialog() -eq "OK")
	{
		$folder += $foldername.SelectedPath
	}
	return $folder
}

# set the ffmpeg execution directory and assign the psdrive "convertEngine"

new-psdrive -Name "convertEngine" -PSProvider FileSystem -root '\\<fileserverHostname>\shared\it dept\tadd\ScriptInterfaces\ffmpeg\bin\'

# locate the source audio files to be converted

Write-Host -ForegroundColor Yellow "Select the audio files you want to convert."

Pause

$sourceAudio = Get-AudioFiles

Write-Host -ForegroundColor Green "You have selected $sourceAudio to convert."

Pause

# locate the target for converted audio files to sit 

Write-Host -ForegroundColor Yellow "Select where you want the audio files to be saved after conversion."

Pause

$outputDestination = Get-AudioFolder

Write-Host -ForegroundColor Green "You have selected $outputDestination as the location to save your output audio."

Pause

# create the output command data 

$sourceAudioSplit = $sourceAudio.split("\")

$sourceAudioSingle = $sourceAudioSplit[$sourceAudioSplit.length - 1]

$sourceAudioSingle = $sourceAudioSingle.split(".")[0]

# compose the ffmpeg command with source and destination paths

Set-Location convertEngine:\

.\ffmpeg -i $sourceAudio $outputDestination\$sourceAudioSingle.mp3

.\ffmpeg -i $sourceAudio $outputDestination\$sourceAudioSingle.wav

# give the option to delete the .wma files 

Pause
