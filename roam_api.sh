#!/bin/bash

# 指定包含 noteString 内容的文件路径
noteFile="/Users/lukesky/RR/roam_api_input.md"
# 指定日志文件的路径
logFile="/Users/lukesky/RR/roam_api_log.txt"

# 指定包含密钥的文件路径
secretsFile="/Users/lukesky/RR/roam_api.env"

# 从密钥文件中读取环境变量(roamToken和graphName)
source "$secretsFile"

# 从文件中读取 noteString 内容，并处理换行符
noteString=$(<"$noteFile")

# 检查 noteString 是否为空
if [ -z "$noteString" ]; then
    echo "Note file is empty. Exiting."
    exit 0
fi

noteString=${noteString//$'\n'/\\n}

# 将 Markdown 语法转换为 Roam Research 语法
# 转换标题（#）
noteString=$(echo "$noteString" | sed -E 's/^# (.*)$/\* \1/')
noteString=$(echo "$noteString" | sed -E 's/^## (.*)$/\*\* \1/')
noteString=$(echo "$noteString" | sed -E 's/^### (.*)$/\*\*\* \1/')
# 转换粗体（**）
noteString=$(echo "$noteString" | sed -E 's/\*\*(.*)\*\*/**\1**/')
# 转换斜体（*）
noteString=$(echo "$noteString" | sed -E 's/\*(.*)\*/_\1_/')
# 转换链接 [text](url)
noteString=$(echo "$noteString" | sed -E 's/\[(.*)\]\((.*)\)/[\1](\2)/')
# 转换todo - [ ] 和 done - [x]
noteString=$(echo "$noteString" | sed -E 's/- \[ \]/{{[[TODO]]}}/')
noteString=$(echo "$noteString" | sed -E 's/- \[x\]/{{[[DONE]]}}/')

# 获取输入的速记文本
string="$noteString"

# 设置当前日期
date=$(date +"%m-%d-%Y")

# 设置Authorization Token，将YOUR_TOKEN替换为用户自行设置的Token
token="$roamToken"

# 发送POST请求到Roam Research API
response=$(curl --location --request POST "https://api.roamresearch.com/api/graph/$graphName/write" --location-trusted \
--header 'accept: application/json' \
--header "Authorization: Bearer $token" \
--header 'Content-Type: application/json' \
--data-raw '{
    "action": "create-block",
    "location": {
        "parent-uid": "'"$date"'",
        "order": "last"
    },
    "block": {
        "string": "'"$string"'"
    }
}')

# 输出API响应结果
echo "$response"

# 将内容记录到日志文件
echo -e "[$(date)]\n$noteString\n" >> "$logFile"

# 清空输入文件
> "$noteFile"