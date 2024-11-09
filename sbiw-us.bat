@echo off
setlocal enabledelayedexpansion

:: Set default values
set DEFAULT_JAVA_VERSION=17
set DEFAULT_DEPENDENCIES=web
set DEFAULT_BUILD=maven
set DEFAULT_GROUP_ID=com.example
set DEFAULT_ARTIFACT_ID=my-app
set DEFAULT_PROJECT_NAME=my-app

:: Use default values
set JAVA_VERSION=%DEFAULT_JAVA_VERSION%
set DEPENDENCIES=%DEFAULT_DEPENDENCIES%
set BUILD=%DEFAULT_BUILD%
set GROUP_ID=%DEFAULT_GROUP_ID%
set ARTIFACT_ID=%DEFAULT_ARTIFACT_ID%
set PROJECT_NAME=%DEFAULT_PROJECT_NAME%

:: Show list of available dependencies to the user
echo Choose dependencies (separate with commas, e.g., 1,2,3):
echo 1. web
echo 2. data-jpa
echo 3. security
echo 4. jdbc
echo 5. thymeleaf
echo 6. actuator
echo 7. none
set /p DEPENDENCIES_INPUT=Enter your choice (default: %DEPENDENCIES%):

:: If the user enters something, process the choices
if not "%DEPENDENCIES_INPUT%"=="" (
    set DEPENDENCIES=
    for %%A in (%DEPENDENCIES_INPUT%) do (
        if %%A==1 set DEPENDENCIES=!DEPENDENCIES!,web
        if %%A==2 set DEPENDENCIES=!DEPENDENCIES!,data-jpa
        if %%A==3 set DEPENDENCIES=!DEPENDENCIES!,security
        if %%A==4 set DEPENDENCIES=!DEPENDENCIES!,jdbc
        if %%A==5 set DEPENDENCIES=!DEPENDENCIES!,thymeleaf
        if %%A==6 set DEPENDENCIES=!DEPENDENCIES!,actuator
        if %%A==7 set DEPENDENCIES=!DEPENDENCIES!
    )
    :: Remove leading comma if exists
    set DEPENDENCIES=!DEPENDENCIES:~1!
)

:: Ask user for build tool (Maven or Gradle)
echo.
echo Choose build tool (default: %BUILD%):
echo 1. Maven
echo 2. Gradle
set /p BUILD_CHOICE=Enter your choice (1-2, default: 1):
if "%BUILD_CHOICE%"=="" set BUILD_CHOICE=1
if "%BUILD_CHOICE%"=="2" set BUILD=gradle

:: Ask user for Java version
echo.
set /p JAVA_VERSION_INPUT=Enter Java version (default: %JAVA_VERSION%):
if not "%JAVA_VERSION_INPUT%"=="" set JAVA_VERSION=%JAVA_VERSION_INPUT%

:: Ask user for groupId
echo.
set /p GROUP_ID_INPUT=Enter groupId (default: %GROUP_ID%):
if not "%GROUP_ID_INPUT%"=="" set GROUP_ID=%GROUP_ID_INPUT%

:: Ask user for artifactId
echo.
set /p ARTIFACT_ID_INPUT=Enter artifactId (default: %ARTIFACT_ID%):
if not "%ARTIFACT_ID_INPUT%"=="" set ARTIFACT_ID=%ARTIFACT_ID_INPUT%

:: Ask user for project name
echo.
set /p PROJECT_NAME_INPUT=Enter project name (default: %PROJECT_NAME%):
if not "%PROJECT_NAME_INPUT%"=="" set PROJECT_NAME=%PROJECT_NAME_INPUT%

:: Show the chosen options to the user
echo.
echo You have chosen the following options:
echo Dependencies: %DEPENDENCIES%
echo Build tool: %BUILD%
echo Java version: %JAVA_VERSION%
echo Group ID: %GROUP_ID%
echo Artifact ID: %ARTIFACT_ID%
echo Project name: %PROJECT_NAME%

:: Run the spring init command with the chosen parameters
echo.
echo Creating your Spring Boot project...
spring init --build=%BUILD% --dependencies=%DEPENDENCIES% --java-version=%JAVA_VERSION% --groupId=%GROUP_ID% --artifactId=%ARTIFACT_ID% --name=%PROJECT_NAME%

:: Check the result of the command
if %ERRORLEVEL% equ 0 (
    echo.
    echo Your project "%PROJECT_NAME%" has been created successfully.
) else (
    echo.
    echo Error: Unable to create the Spring Boot project. Please check the information or your internet connection.
)

endlocal
