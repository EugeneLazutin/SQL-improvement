REM This script will create Blogging database and related procedures and views.
REM The file must be in the same folder with SQL-scripts.
REM Do not forget to specify the server name!

@echo off

set server=wsb-137

echo.
echo Creating database...
echo.

sqlcmd /S %server% -E -i"Blogging_create_database.sql" -b
if ERRORLEVEL 1 goto err_handler

echo.
echo Creating stored procedures...
echo.

for %%G in (Blogging_sp*.sql) do (sqlcmd /S %server% -E -i"%%G" -b & if ERRORLEVEL 1 goto err_handler)

echo.
echo Creating views...
echo.

for %%G in (Blogging_view*.sql) do (sqlcmd /S %server% -E -i"%%G" -b & if ERRORLEVEL 1 goto err_handler)

echo.
echo Blogging database created!

pause
EXIT /B 1

:err_handler
echo.
echo Some errors occured while script running.

pause