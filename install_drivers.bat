@echo off
:: Verifica se está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    :: Se não estiver sendo executado como administrador, relança o script com privilégios administrativos
    echo. & echo Precisa de permissões administrativas.
    pause
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)

:: Adiciona e instala os drivers
@echo on
for /r %%f in (*.inf) do pnputil.exe /add-driver "%%f" /install
pause