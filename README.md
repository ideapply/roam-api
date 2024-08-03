# Roam Research API Script

实现功能：

- 通过 `roam_api.sh` 脚本将 `roam_api_input.md` 中的 markdown 格式文本转换成 Roam Research 格式文本并上传到当日的 Dailynotes 页。上传后自动删除 markdown 中文本并在 `roam_api_log.txt` 中记录。
- 另外，也通过 `watch_note.sh` 实现自动上传，脚本中使用 Typora 识别，并在文本保存后自动触发，触发周期设为3分钟。
- `roam_api_pull.sh` 和 `roam_api_pull_many.sh` 是拉取脚本，只能拉取十来行，作用不大。

## Prerequisites

- A Roam Research API token
- A Roam Research graph name
- `curl` installed on your system
- `inotify-tools` installed on your system (for `watch_note.sh`)

## Setup

1. Clone the repository:
    ```sh
    git clone https://github.com/ideapply/roam-research-api-script.git
    cd roam-research-api-script
    ```

2. Create a file named `roam_api.env` in the root directory of the project with the following content:
    ```sh
    roamToken="your-roam-api-token"
    graphName="your-roam-graph-name"
    ```

3. Make sure the scripts have execute permissions:
    ```sh
    chmod +x roam_api.sh
    chmod +x watch_note.sh
    chmod +x roam_api_pull.sh
    chmod +x roam_api_pull_many.sh
    ```

## Usage

### 上传脚本

1. **手动上传**:
    ```sh
    ./roam_api.sh
    ```

    该脚本会将 `roam_api_input.md` 中的 markdown 格式文本转换成 Roam Research 格式文本并上传到当日的 Dailynotes 页。上传后自动删除 markdown 中文本并在 `roam_api_log.txt` 中记录。

2. **自动上传**:
    ```sh
    ./watch_note.sh
    ```

    `watch_note.sh` 脚本会每3分钟检查一次 `roam_api_input.md` 文件是否被 Typora 编辑。如果文件未被编辑且内容不为空，将自动运行 `roam_api.sh` 脚本上传内容。

### 拉取脚本

1. **单次拉取**:
    ```sh
    ./roam_api_pull.sh
    ```

    该脚本将拉取 Roam Research 中的十来行内容。

2. **多次拉取**:
    ```sh
    ./roam_api_pull_many.sh
    ```

    该脚本同样用于拉取 Roam Research 中的内容，但作用有限。

## Script Details

- `roam_api.sh`: 将 `roam_api_input.md` 中的 markdown 格式文本转换成 Roam Research 格式文本并上传到当日的 Dailynotes 页。上传后自动删除 markdown 中文本并在 `roam_api_log.txt` 中记录。
- `watch_note.sh`: 自动检查 `roam_api_input.md` 文件是否被 Typora 编辑，每3分钟触发一次。如果文件未被编辑且内容不为空，自动运行 `roam_api.sh` 脚本上传内容。
- `roam_api_pull.sh`: 拉取 Roam Research 中的十来行内容。
- `roam_api_pull_many.sh`: 同样用于拉取 Roam Research 中的内容，但作用有限。

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
