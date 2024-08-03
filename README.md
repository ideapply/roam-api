Roam Research API 运行脚本

实现功能：

- 通过 roam_api.sh 脚本将 roam_api_input.md 中的 markdown 格式文本转换成 Roam Research 格式文本并上传到当日的 Dailynotes 页。上传后自动删除 markdown 中文本并在 roam_api_log.txt 中记录。

- 另外，也通过 watch_note.sh 实现自动上传，脚本中使用的 Typora 识别，并在文本保存后自动触发，触发周期设为3分钟。

- roam_api_pull.sh 和 roam_api_pull_many.sh 是拉取脚本，只能拉取十来行，作用不大。
