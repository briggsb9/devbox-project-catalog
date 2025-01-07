param (
    [Parameter(Mandatory=$true)]
    [string]$fileUri,

    [Parameter(Mandatory=$true)]
    [string]$destination,

    [Parameter(Mandatory=$false)]
    [string]$sasToken
)

#$ProgressPreference = 'SilentlyContinue'	# hide any progress output

Write-Output "Start to download $($fileUri) ..."
try {
    if(test-path $destination){
        write-output "File Already Exists... Skipping!"
        exit 0
    }
    if($PSBoundParameters.ContainsKey('sasToken') -or ![string]::IsNullOrEmpty($sasToken)){
        Write-Output "Downloading using SAS Token"
        Invoke-WebRequest -Uri "$($fileUri)?$($sasToken)" -OutFile $destination -ErrorAction Stop
        Write-Output "End to download $($fileUri) ..."
    } else {
        Write-Output "Downloading NOT using SAS Token"
        Invoke-WebRequest -Uri "$($fileUri)" -OutFile $destination -ErrorAction Stop
        Write-Output "End to download $($fileUri) ..." 
    }


}
catch {
    Write-Output "Failed to download file $($fileUri): $_"
    Write-Output "End to download $($fileUri) ..."
    exit 1
}



