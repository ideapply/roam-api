#!/bin/bash

# 指定包含 noteString 内容的文件路径
noteFile="/Users/lukesky/RR/roam_api_input.md"
# 指定日志文件的路径
logFile="/Users/lukesky/RR/roam_api_log.txt"
# 指定包含密钥的文件路径
secretsFile="/Users/lukesky/RR/roam_api.env"
# 指定要运行的脚本文件路径
scriptFile="/Users/lukesky/RR/roam_api.sh"

# 从密钥文件中读取环境变量
source "$secretsFile"

# 函数：检查文件是否被 Typora 编辑
is_file_open_in_typora() {
    if pgrep -x "Typora" > /dev/null && lsof -c "Typora" | grep "$noteFile" > /dev/null; then
        return 0
    else
        return 1
    fi
}

# 函数：检查文件内容是否为空
is_file_empty() {
    if [ ! -s "$noteFile" ]; then
        return 0
    else
        return 1
    fi
}

# 定时检查文件状态
while true; do
    # 检查文件是否被 Typora 打开
    if ! is_file_open_in_typora; then
        # 检查文件内容是否为空
        if ! is_file_empty; then
            # 运行脚本
            "$scriptFile"
        fi
    fi
    
    # 等待3分钟
    sleep 180
done