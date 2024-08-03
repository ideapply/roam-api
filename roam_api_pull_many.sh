#!/bin/bash

# 指定包含密钥的文件路径
secretsFile="/Users/lukesky/RR/roam_api.env"

# 从密钥文件中读取环境变量(roamToken和graphName)
source "$secretsFile"

# 设置Authorization Token，将YOUR_TOKEN替换为用户自行设置的Token
token="$roamToken"

# 指定输出文件路径
outputFile="/Users/lukesky/RR/api_response.edn"

# 发送POST请求到Roam Research API
response=$(curl -X POST "https://api.roamresearch.com/api/graph/$graphName/pull-many" --location-trusted \
-H "accept: application/json" \
-H "Authorization: Bearer $token" \
-H "Content-Type: application/json" \
-d "{\"eids\": \"[[:block/uid \\\"cZre2kzOf\\\"]]\", \"selector\": \"[:block/uid :node/title :block/string {:block/children [:block/uid :block/string]} {:block/refs [:node/title :block/string :block/uid]}]\"}")

# 将响应内容格式化为 EDN 格式，并写入文件
echo "{:response $response}" > "$outputFile"


# 输出API响应结果
# echo "$response"
