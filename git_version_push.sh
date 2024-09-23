#!/bin/bash

# 版本文件
VERSION_FILE="version.txt"

# 检查版本文件是否存在，如果不存在则初始化为 1.0
if [ ! -f "$VERSION_FILE" ]; then
  echo "1.0" > "$VERSION_FILE"
fi

# 读取当前版本
current_version=$(cat "$VERSION_FILE")
echo "当前版本: $current_version"

# 分割版本号
IFS='.' read -r major minor <<< "$current_version"

# 增加版本号
if [ "$minor" -lt 9 ]; then
  minor=$((minor + 1))
else
  minor=0
  major=$((major + 1))
fi

# 新版本号
new_version="$major.$minor"
echo "新的版本: $new_version"

# 更新版本文件
echo "$new_version" > "$VERSION_FILE"

# Git 提交
git add .
git commit -m "更新版本到 $new_version"
git push origin main
