# A PowerShell script to test EDR malware detection using the EICAR standard test file.
# This script will download the EICAR test string and save it to a file.
# If a configured EDR is running in "Protect" mode, this action should be blocked immediately.

$eicarString = 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
$testFilePath = "$env:USERPROFILE\Downloads\eicar_test_file.txt"

Write-Host "--- Starting EDR Malware Detection Test ---"
Write-Host "This script will attempt to create the EICAR test file at: $testFilePath"
Write-Host "A successful test means this operation will be BLOCKED by the EDR."
Write-Host ""

try {
    # Attempt to write the malicious string to a file
    Set-Content -Path $testFilePath -Value $eicarString -ErrorAction Stop
    
    # If this line is reached, the EDR did not block the file creation.
    Write-Host " TEST FAILED: The EICAR test file was created successfully."
    Write-Host "   This indicates the EDR is not in protection mode or is misconfigured."
}
catch {
    # If an error occurs (e.g., "Access is denied"), it's likely the EDR blocked it.
    Write-Host " TEST SUCCESSFUL: File creation was blocked as expected."
    Write-Host "   Error message: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "--- Test Complete ---"
