@echo off
setlocal enabledelayedexpansion

:: Specify the directory containing JSON files
set "input_dir=%~dp0"

:: Loop through all JSON files in the directory
for %%f in ("%input_dir%*.json") do (
    echo Processing: %%f

    :: Use PowerShell to update the extensions in the JSON file
    powershell -Command ^
        "(Get-Content -Raw '%%f') -replace '\.jpg', '.webp' -replace '\.jpeg', '.webp' -replace '\.png', '.webp' | Set-Content '%%f'"
    
    if !errorlevel! equ 0 (
        echo Updated: %%f
    ) else (
        echo Failed to update: %%f
    )
)

echo All JSON files processed.
pause
