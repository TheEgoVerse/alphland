@echo off
setlocal enabledelayedexpansion

:: Specify the directory (default is current directory)
set "input_dir=%~dp0"

:: Ensure ffmpeg is installed and in the system PATH
where ffmpeg >nul 2>&1
if errorlevel 1 (
    echo ffmpeg not found. Please ensure ffmpeg is installed and in the PATH.
    pause
    exit /b
)

:: Loop through all jpg, jpeg, and png files in the directory and subdirectories
for /r "%input_dir%" %%f in (*.jpg *.jpeg *.png) do (
    :: Get the full path and file name without extension
    set "filepath=%%~f"
    set "filename=%%~nf"
    set "filedir=%%~dpf"

    :: Convert to .webp format using ffmpeg with 80% quality
    ffmpeg -i "!filepath!" -q:v 80 "!filedir!!filename!.webp" -loglevel error

    if !errorlevel! equ 0 (
        echo Converted: %%f to !filename!.webp
        del /q "%%~f" 2>nul
        if exist "%%~f" (
            echo Failed to delete: %%f
        ) else (
            echo Deleted original: %%f
        )
    ) else (
        echo Failed to convert: %%f
    )
)

echo Conversion completed.
pause
