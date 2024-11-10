#!/bin/bash

# Set default values for the project
DEFAULT_JAVA_VERSION="17"
DEFAULT_DEPENDENCIES="web"
DEFAULT_BUILD="maven"
DEFAULT_GROUP_ID="com.example"
DEFAULT_ARTIFACT_ID="my-app"
DEFAULT_PROJECT_NAME="my-app"

# Use the default values initially
java_version="$DEFAULT_JAVA_VERSION"
dependencies="$DEFAULT_DEPENDENCIES"
build="$DEFAULT_BUILD"
group_id="$DEFAULT_GROUP_ID"
artifact_id="$DEFAULT_ARTIFACT_ID"
project_name="$DEFAULT_PROJECT_NAME"

# Show a list of dependencies for the user to select from
echo "Choose dependencies (separate with commas, e.g., 1,2,3):"
echo "1. web"
echo "2. data-jpa"
echo "3. security"
echo "4. jdbc"
echo "5. thymeleaf"
echo "6. actuator"
echo "7. none"
read -p "Enter your choice (default: $dependencies): " dependencies_input

# If the user enters something, process it
if [ -n "$dependencies_input" ]; then
  dependencies=""
  for choice in $(echo $dependencies_input | tr "," "\n"); do
    case $choice in
      1) dependencies="$dependencies,web" ;;
      2) dependencies="$dependencies,data-jpa" ;;
      3) dependencies="$dependencies,security" ;;
      4) dependencies="$dependencies,jdbc" ;;
      5) dependencies="$dependencies,thymeleaf" ;;
      6) dependencies="$dependencies,actuator" ;;
      7) dependencies="$dependencies" ;;  # "none"
      *) echo "Invalid choice: $choice" ;;
    esac
  done
  # Remove the leading comma if exists
  dependencies=$(echo $dependencies | sed 's/^,//')
fi

# Remove duplicates from the dependencies list (by converting it into an array and back to a string)
IFS=',' read -r -a dep_array <<< "$dependencies"
unique_dependencies=$(echo "${dep_array[@]}" | tr ' ' '\n' | sort -u | tr '\n' ',' | sed 's/,$//')

# Ask for build tool choice (Maven or Gradle)
echo ""
echo "Choose build tool (default: $build):"
echo "1. Maven"
echo "2. Gradle"
read -p "Enter your choice (1-2, default: 1): " build_choice
if [ -z "$build_choice" ]; then build_choice=1; fi
if [ "$build_choice" == "2" ]; then build="gradle"; fi

# Ask for Java version
echo ""
read -p "Enter Java version (default: $java_version): " java_version_input
if [ -n "$java_version_input" ]; then java_version="$java_version_input"; fi

# Ask for groupId
echo ""
read -p "Enter groupId (default: $group_id): " group_id_input
if [ -n "$group_id_input" ]; then group_id="$group_id_input"; fi

# Ask for artifactId
echo ""
read -p "Enter artifactId (default: $artifact_id): " artifact_id_input
if [ -n "$artifact_id_input" ]; then artifact_id="$artifact_id_input"; fi

# Ask for project name
echo ""
read -p "Enter project name (default: $project_name): " project_name_input
if [ -n "$project_name_input" ]; then project_name="$project_name_input"; fi

# Show the user's selected options
echo ""
echo "You have selected the following options:"
echo "Dependencies: $unique_dependencies"
echo "Build tool: $build"
echo "Java version: $java_version"
echo "Group ID: $group_id"
echo "Artifact ID: $artifact_id"
echo "Project name: $project_name"

# Run the spring init command with the chosen parameters
echo ""
echo "Creating your Spring Boot project..."
spring init --build=$build --dependencies=$unique_dependencies --java-version=$java_version --groupId=$group_id --artifactId=$artifact_id --name=$project_name

# Check if the project creation was successful
if [ $? -eq 0 ]; then
  echo ""
  echo "Your project $project_name has been created successfully."
else
  echo ""
  echo "Error: Unable to create the Spring Boot project. Please check the information or your internet connection."
fi
