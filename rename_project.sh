#!/bin/bash

# 检查是否提供了项目名称
if [ $# -eq 0 ]; then
    echo "错误: 请提供新的项目名称"
    echo "用法: ./rename_project.sh your_project_name"
    exit 1
fi

# 获取当前项目名称
CURRENT_NAME=$(grep "name:" pubspec.yaml | head -n 1 | awk '{print $2}')
NEW_NAME=$1

echo "将项目名称从 $CURRENT_NAME 更改为 $NEW_NAME"

# 修改pubspec.yaml中的名称
sed -i "s/name: $CURRENT_NAME/name: $NEW_NAME/" pubspec.yaml

# 更新导入语句
find . -type f -name "*.dart" -exec sed -i "s/import 'package:$CURRENT_NAME/import 'package:$NEW_NAME/g" {} \;

# 更新Android包名
if [ -d "android" ]; then
  # 找到主应用包路径
  ANDROID_PACKAGE_PATH=$(grep -r "applicationId" android/app/build.gradle | awk '{print $2}' | sed 's/"//g')
  
  if [ ! -z "$ANDROID_PACKAGE_PATH" ]; then
    # 获取新的包名 (将下划线替换为点)
    NEW_PACKAGE=$(echo $NEW_NAME | sed 's/_/\./g')
    
    # 更新build.gradle中的包名
    sed -i "s/$ANDROID_PACKAGE_PATH/$NEW_PACKAGE/g" android/app/build.gradle
    
    echo "已更新Android包名为 $NEW_PACKAGE"
  fi
fi

# 更新iOS包名
if [ -d "ios" ]; then
  # 找到info.plist并更新CFBundleIdentifier (如果存在)
  if [ -f "ios/Runner/Info.plist" ]; then
    # 新的包名 (将下划线替换为横杠)
    NEW_IOS_BUNDLE=$(echo $NEW_NAME | sed 's/_/-/g')
    
    # 尝试更新CFBundleIdentifier
    if grep -q "CFBundleIdentifier" ios/Runner/Info.plist; then
      OLD_BUNDLE=$(grep -A 1 "CFBundleIdentifier" ios/Runner/Info.plist | tail -n 1 | sed 's/.*>\(.*\)<.*/\1/')
      sed -i "s/$OLD_BUNDLE/com.example.$NEW_IOS_BUNDLE/g" ios/Runner/Info.plist
      echo "已更新iOS包名为 com.example.$NEW_IOS_BUNDLE"
    fi
  fi
fi

echo "项目重命名完成！"
echo "请运行 'flutter pub get' 更新依赖。" 