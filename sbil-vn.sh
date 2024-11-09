#!/bin/bash

# Đặt tất cả các giá trị mặc định ở đầu script để dễ dàng thay đổi
DEFAULT_JAVA_VERSION="17"   # Phiên bản Java mặc định là 17 (có thể thay đổi tại đây)
DEFAULT_DEPENDENCIES="web"  # Dependencies mặc định
DEFAULT_BUILD="maven"       # Build tool mặc định
DEFAULT_GROUP_ID="com.example"
DEFAULT_ARTIFACT_ID="my-app"
DEFAULT_PROJECT_NAME="my-app"

# Dùng các giá trị mặc định từ trên
java_version="$DEFAULT_JAVA_VERSION"
dependencies="$DEFAULT_DEPENDENCIES"
build="$DEFAULT_BUILD"
group_id="$DEFAULT_GROUP_ID"
artifact_id="$DEFAULT_ARTIFACT_ID"
project_name="$DEFAULT_PROJECT_NAME"

# Hiển thị danh sách các dependencies cho người dùng chọn
echo "Chọn dependencies (cách nhau bằng dấu phẩy, ví dụ: 1,2,3):"
echo "1. web"
echo "2. data-jpa"
echo "3. security"
echo "4. jdbc"
echo "5. thymeleaf"
echo "6. actuator"
echo "7. none"
read -p "Nhập lựa chọn (mặc định: $dependencies): " dependencies_input

# Nếu người dùng nhập vào, xử lý các số và tạo chuỗi dependencies
if [ -n "$dependencies_input" ]; then
  dependencies=""
  # Duyệt qua từng lựa chọn người dùng nhập, chuyển các số thành tên dependency
  for choice in $(echo $dependencies_input | tr "," "\n"); do
    case $choice in
      1) dependencies="$dependencies,web" ;;
      2) dependencies="$dependencies,data-jpa" ;;
      3) dependencies="$dependencies,security" ;;
      4) dependencies="$dependencies,jdbc" ;;
      5) dependencies="$dependencies,thymeleaf" ;;
      6) dependencies="$dependencies,actuator" ;;
      7) dependencies="$dependencies" ;;  # "none" (không thêm dependencies)
      *) echo "Lựa chọn không hợp lệ: $choice";;
    esac
  done
  # Loại bỏ dấu phẩy thừa đầu chuỗi (nếu có)
  dependencies=$(echo $dependencies | sed 's/^,//')
fi

# Hỏi người dùng về build tool (Maven hoặc Gradle)
echo ""
echo "Chọn build tool (default: $build):"
echo "1. Maven"
echo "2. Gradle"
read -p "Nhập lựa chọn (1-2, mặc định: 1): " build_choice
if [ -z "$build_choice" ]; then build_choice=1; fi
if [ "$build_choice" == "2" ]; then build="gradle"; fi

# Hỏi người dùng về phiên bản Java (mặc định là 17)
echo ""
read -p "Nhập Java version (mặc định: $java_version): " java_version_input
if [ -n "$java_version_input" ]; then java_version="$java_version_input"; fi

# Hỏi người dùng về groupId
echo ""
read -p "Nhập groupId (mặc định: $group_id): " group_id_input
if [ -n "$group_id_input" ]; then group_id="$group_id_input"; fi

# Hỏi người dùng về artifactId
echo ""
read -p "Nhập artifactId (mặc định: $artifact_id): " artifact_id_input
if [ -n "$artifact_id_input" ]; then artifact_id="$artifact_id_input"; fi

# Hỏi người dùng về project name
echo ""
read -p "Nhập project name (mặc định: $project_name): " project_name_input
if [ -n "$project_name_input" ]; then project_name="$project_name_input"; fi

# Hiển thị thông tin người dùng đã nhập
echo ""
echo "Bạn đã chọn các tùy chọn sau:"
echo "Dependencies: $dependencies"
echo "Build tool: $build"
echo "Java version: $java_version"
echo "Group ID: $group_id"
echo "Artifact ID: $artifact_id"
echo "Project name: $project_name"

# Chạy lệnh spring init với các tham số người dùng đã nhập
echo ""
echo "Đang tạo dự án Spring Boot..."
spring init --build=$build --dependencies=$dependencies --java-version=$java_version --groupId=$group_id --artifactId=$artifact_id --name=$project_name

# Kiểm tra mã thoát của lệnh `spring init`
if [ $? -eq 0 ]; then
  echo ""
  echo "Dự án $project_name đã được tạo thành công."
else
  echo ""
  echo "Lỗi: Không thể tạo dự án Spring Boot. Vui lòng kiểm tra lại thông tin hoặc kết nối Internet."
fi
