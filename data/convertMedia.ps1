# Get the directory of the script
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Loop through each JSON file in the script's directory
Get-ChildItem -Path $scriptDirectory -Filter *.json | ForEach-Object {
    # Get the full file path
    $filePath = $_.FullName

    # Read the JSON content
    $jsonContent = Get-Content -Path $filePath -Raw | ConvertFrom-Json

    # Extract the dApp name from the file name (assuming it's the name of the dApp)
    $dAppName = $_.BaseName

    # Check and update the media URLs
    if ($jsonContent.media) {
        $jsonContent.media.logoUrl = "/dapps/$dAppName/$dAppName-logo.webp"
        $jsonContent.media.bannerUrl = "/dapps/$dAppName/$dAppName-banner.webp"
        $jsonContent.media.previewUrl = "/dapps/$dAppName/$dAppName-preview.webp"
    }

    # Convert the modified JSON object back to JSON string with indentation
    $updatedJsonContent = $jsonContent | ConvertTo-Json -Depth 10 -Compress:$false | Out-String

    # Save the updated JSON back to the file with preserved format
    Set-Content -Path $filePath -Value $updatedJsonContent -NoNewline

    # Output a message indicating the file has been updated
    Write-Output "Updated media URLs in: $filePath"
}
