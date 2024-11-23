
# Set default values
$DEFAULT_JAVA_VERSION = "17"
$DEFAULT_DEPENDENCIES = "web"
$DEFAULT_BUILD = "maven"
$DEFAULT_GROUP_ID = "com.example"
$DEFAULT_ARTIFACT_ID = "my-app"
$DEFAULT_PROJECT_NAME = "my-app"

# Use default values
$JAVA_VERSION = $DEFAULT_JAVA_VERSION
$DEPENDENCIES = $DEFAULT_DEPENDENCIES
$BUILD = $DEFAULT_BUILD
$GROUP_ID = $DEFAULT_GROUP_ID
$ARTIFACT_ID = $DEFAULT_ARTIFACT_ID
$PROJECT_NAME = $DEFAULT_PROJECT_NAME

# Debugging: In all variables before proceeding
Write-Host "DEBUG: JAVA_VERSION=$JAVA_VERSION"
Write-Host "DEBUG: DEPENDENCIES=$DEPENDENCIES"
Write-Host "DEBUG: BUILD=$BUILD"
Write-Host "DEBUG: GROUP_ID=$GROUP_ID"
Write-Host "DEBUG: ARTIFACT_ID=$ARTIFACT_ID"
Write-Host "DEBUG: PROJECT_NAME=$PROJECT_NAME"

# Show list of available dependencies to the user
Write-Host "Chọn dependencies (cách nhau bằng dấu phẩy, ví dụ: 1,2,3):"
Write-Host "1. web"
Write-Host "2. data-jpa"
Write-Host "3. security"
Write-Host "4. jdbc"
Write-Host "5. thymeleaf"
Write-Host "6. actuator"
Write-Host "7. none"

# Ask user for dependencies choice
$DEPENDENCIES_INPUT = Read-Host -Prompt "Enter your choice (default: $DEPENDENCIES)"

# If the user enters something, process the choices
if ($DEPENDENCIES_INPUT) {
    $DEPENDENCIES = ""  # Reset the dependencies list
    $choices = $DEPENDENCIES_INPUT -split ","
    foreach ($choice in $choices) {
        $choice = $choice.Trim()  # Remove spaces if any

        # Check if the choice is valid (1 to 7)
        switch ($choice) {
            "1" { if (-not $DEPENDENCIES.Contains("web")) { $DEPENDENCIES += ",web" } }
            "2" { if (-not $DEPENDENCIES.Contains("data-jpa")) { $DEPENDENCIES += ",data-jpa" } }
            "3" { if (-not $DEPENDENCIES.Contains("security")) { $DEPENDENCIES += ",security" } }
            "4" { if (-not $DEPENDENCIES.Contains("jdbc")) { $DEPENDENCIES += ",jdbc" } }
            "5" { if (-not $DEPENDENCIES.Contains("thymeleaf")) { $DEPENDENCIES += ",thymeleaf" } }
            "6" { if (-not $DEPENDENCIES.Contains("actuator")) { $DEPENDENCIES += ",actuator" } }
            "7" { Write-Host "No dependencies chosen."; $DEPENDENCIES = $DEFAULT_DEPENDENCIES }
            default { Write-Host "Invalid choice '$choice'. Please choose a number between 1 and 7." }
        }
    }
    # Remove leading comma if exists
    $DEPENDENCIES = $DEPENDENCIES.TrimStart(',')
} else {
    Write-Host "No dependencies chosen, using default: $DEPENDENCIES"
}

# Ask user for build tool (Maven or Gradle)
Write-Host ""
Write-Host "Chọn build tool (default: $BUILD):"
Write-Host "1. Maven"
Write-Host "2. Gradle"
$BUILD_CHOICE = Read-Host -Prompt "Nhập lựa chọn của bạn (1-2, default: 1)"
if (-not $BUILD_CHOICE) { $BUILD_CHOICE = "1" }
if ($BUILD_CHOICE -eq "2") { $BUILD = "gradle" }

# Ask user for Java version
Write-Host ""
$JAVA_VERSION_INPUT = Read-Host -Prompt "Nhập Java version (default: $JAVA_VERSION)"
if ($JAVA_VERSION_INPUT) { $JAVA_VERSION = $JAVA_VERSION_INPUT } else { $JAVA_VERSION = $DEFAULT_JAVA_VERSION }

# Ask user for groupId
Write-Host ""
$GROUP_ID_INPUT = Read-Host -Prompt "Nhập groupId (default: $GROUP_ID)"
if ($GROUP_ID_INPUT) { $GROUP_ID = $GROUP_ID_INPUT } else { $GROUP_ID = $DEFAULT_GROUP_ID }

# Ask user for artifactId
Write-Host ""
$ARTIFACT_ID_INPUT = Read-Host -Prompt "Nhập artifactId (default: $ARTIFACT_ID)"
if ($ARTIFACT_ID_INPUT) { $ARTIFACT_ID = $ARTIFACT_ID_INPUT } else { $ARTIFACT_ID = $DEFAULT_ARTIFACT_ID }

# Ask user for project name
Write-Host ""
$PROJECT_NAME_INPUT = Read-Host -Prompt "Nhập project name (default: $PROJECT_NAME)"
if ($PROJECT_NAME_INPUT) { $PROJECT_NAME = $PROJECT_NAME_INPUT } else { $PROJECT_NAME = $DEFAULT_PROJECT_NAME }

# Show the chosen options to the user
Write-Host ""
Write-Host "Bạn đã chọn các tùy chọn sau:"
Write-Host "Dependencies: $DEPENDENCIES"
Write-Host "Build tool: $BUILD"
Write-Host "Java version: $JAVA_VERSION"
Write-Host "Group ID: $GROUP_ID"
Write-Host "Artifact ID: $ARTIFACT_ID"
Write-Host "Project name: $PROJECT_NAME"

# Debug: Show the full command before running it
Write-Host ""
Write-Host "Running: spring init --build=$BUILD --dependencies=$DEPENDENCIES --java-version=$JAVA_VERSION --groupId=$GROUP_ID --artifactId=$ARTIFACT_ID --name=$PROJECT_NAME"

# Run the spring init command with the chosen parameters
spring init --build=$BUILD --dependencies=$DEPENDENCIES --java-version=$JAVA_VERSION --groupId=$GROUP_ID --artifactId=$ARTIFACT_ID --name=$PROJECT_NAME

# Add final pause
Read-Host -Prompt "Press Enter to exit..."
