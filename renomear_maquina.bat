@echo off

net session >nul 2>&1 || (powershell start -verb runas '"%~0"' &exit /b)
chcp 1252 >nul

:: Informe o prefixo do nome do computador aqui:
echo Informe o Prefixo:
set /p Prefixo=

::INFORMAR TIPO DA MAQUINA

echo Informe o tipo da maquina ( Desktop / Notebook):
set /p tpMaquina=
:: Informe o Dominío a ser adicionado aqui:
set Grupo=TESTE

::Pegar Serial da Bios:
::for /f "tokens=2 Delims==" %%a in ('wmic bios get SerialNumber /value') do for /f %%b in ("%%a") do set "Serial=%%b"

::set "SerialParcial=%Serial:~0,7%"
set "NovoNomePC=%tpMaquina%-%Prefixo%"

set /p "opcao=Eh preciso reiniciar o computador deseja continuar (s - sim / n - nao)? "
IF /i "%opcao%"=="s" call :Renomear

exit

:Renomear
wmic computersystem where name="%Computername%" call joindomainorWorkgroup name="%Grupo%" 1>nul 2>nul
wmic computersystem where name="%ComputerName%" call rename name="%NovoNomePC%" 1>nul 2>nul
shutdown -r -t 60
goto :EOF