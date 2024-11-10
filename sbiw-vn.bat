@echo off
setlocal enabledelayedexpansion

:: Đặt các giá trị mặc định
set DEFAULT_JAVA_VERSION=17
set DEFAULT_DEPENDENCIES=web
set DEFAULT_BUILD=maven
set DEFAULT_GROUP_ID=com.example
set DEFAULT_ARTIFACT_ID=my-app
set DEFAULT_PROJECT_NAME=my-app

:: Dùng các giá trị mặc định
set JAVA_VERSION=%DEFAULT_JAVA_VERSION%
set DEPENDENCIES=%DEFAULT_DEPENDENCIES%
set BUILD=%DEFAULT_BUILD%
set GROUP_ID=%DEFAULT_GROUP_ID%
set ARTIFACT_ID=%DEFAULT_ARTIFACT_ID%
set PROJECT_NAME=%DEFAULT_PROJECT_NAME%

:: Hiển thị danh sách các dependencies cho người dùng chọn
echo Chọn dependencies (cách nhau bằng dấu phẩy, ví dụ: 1,2,3):
echo 1. web
echo 2. data-jpa
echo 3. security
echo 4. jdbc
echo 5. thymeleaf
echo 6. actuator
echo 7. none
set /p DEPENDENCIES_INPUT=Nhập lựa chọn (mặc định: %DEPENDENCIES%):

:: Nếu người dùng nhập lựa chọn, xử lý các lựa chọn đó
if not "%DEPENDENCIES_INPUT%"=="" (
    set DEPENDENCIES=  :: Reset the dependencies list
    for %%A in (%DEPENDENCIES_INPUT%) do (
        set CHOICE=%%A
        set CHOICE=!CHOICE: =!  :: Remove spaces if any

        :: Check if the choice is valid (1 to 7)
        if "!CHOICE!"=="" (
            echo Invalid choice, skipping...
        ) else (
            if "!CHOICE!"=="1" (
                if "!DEPENDENCIES!" not contains "web" set DEPENDENCIES=!DEPENDENCIES!,web
            ) else if "!CHOICE!"=="2" (
                if "!DEPENDENCIES!" not contains "data-jpa" set DEPENDENCIES=!DEPENDENCIES!,data-jpa
            ) else if "!CHOICE!"=="3" (
                if "!DEPENDENCIES!" not contains "security" set DEPENDENCIES=!DEPENDENCIES!,security
            ) else if "!CHOICE!"=="4" (
                if "!DEPENDENCIES!" not contains "jdbc" set DEPENDENCIES=!DEPENDENCIES!,jdbc
            ) else if "!CHOICE!"=="5" (
                if "!DEPENDENCIES!" not contains "thymeleaf" set DEPENDENCIES=!DEPENDENCIES!,thymeleaf
            ) else if "!CHOICE!"=="6" (
                if "!DEPENDENCIES!" not contains "actuator" set DEPENDENCIES=!DEPENDENCIES!,actuator
            ) else if "!CHOICE!"=="7" (
                echo No dependencies chosen.
                set DEPENDENCIES=%DEFAULT_DEPENDENCIES%
            ) else (
                echo Invalid choice "!CHOICE!". Please choose a number between 1 and 7.
            )
        )
    )

    :: Loại bỏ dấu phẩy ở đầu nếu có
    set DEPENDENCIES=!DEPENDENCIES:~1!
    
    set DEPENDENCIES=!DEPENDENCIES:,= !
    set DEPENDENCIES=!DEPENDENCIES: =,!
)

:: Hỏi người dùng về build tool (Maven hoặc Gradle)
echo.
echo Chọn build tool (default: %BUILD%):
echo 1. Maven
echo 2. Gradle
set /p BUILD_CHOICE=Nhập lựa chọn (1-2, mặc định: 1):
if "%BUILD_CHOICE%"=="" set BUILD_CHOICE=1
if "%BUILD_CHOICE%"=="2" set BUILD=gradle

:: Hỏi người dùng về phiên bản Java
echo.
set /p JAVA_VERSION_INPUT=Nhập Java version (mặc định: %JAVA_VERSION%):
if not "%JAVA_VERSION_INPUT%"=="" set JAVA_VERSION=%JAVA_VERSION_INPUT%

:: Hỏi người dùng về groupId
echo.
set /p GROUP_ID_INPUT=Nhập groupId (mặc định: %GROUP_ID%):
if not "%GROUP_ID_INPUT%"=="" set GROUP_ID=%GROUP_ID_INPUT%

:: Hỏi người dùng về artifactId
echo.
set /p ARTIFACT_ID_INPUT=Nhập artifactId (mặc định: %ARTIFACT_ID%):
if not "%ARTIFACT_ID_INPUT%"=="" set ARTIFACT_ID=%ARTIFACT_ID_INPUT%

:: Hỏi người dùng về project name
echo.
set /p PROJECT_NAME_INPUT=Nhập project name (mặc định: %PROJECT_NAME%):
if not "%PROJECT_NAME_INPUT%"=="" set PROJECT_NAME=%PROJECT_NAME_INPUT%

:: Hiển thị thông tin người dùng đã nhập
echo.
echo Bạn đã chọn các tùy chọn sau:
echo Dependencies: %DEPENDENCIES%
echo Build tool: %BUILD%
echo Java version: %JAVA_VERSION%
echo Group ID: %GROUP_ID%
echo Artifact ID: %ARTIFACT_ID%
echo Project name: %PROJECT_NAME%

:: Chạy lệnh spring init với các tham số người dùng đã nhập
echo.
echo Đang tạo dự án Spring Boot...
spring init --build=%BUILD% --dependencies=%DEPENDENCIES% --java-version=%JAVA_VERSION% --groupId=%GROUP_ID% --artifactId=%ARTIFACT_ID% --name=%PROJECT_NAME%

:: Kiểm tra kết quả lệnh
if %ERRORLEVEL% equ 0 (
    echo.
    echo Dự án %PROJECT_NAME% đã được tạo thành công.
) else (
    echo.
    echo Lỗi: Không thể tạo dự án Spring Boot. Vui lòng kiểm tra lại thông tin hoặc kết nối Internet.
)

endlocal
