<#
检测福袋自动撤回的脚本，使用 CQHTTP PowerShell SDK。

要求：

- 酷Q Pro
- 机器人有管理员权限

使用方法：

0. 安装 酷Q 和 CQHTTP 插件（https://cqhttp.cc/），使用默认配置，仅修改 post_url 为 http://127.0.0.1:8080
1. Install-Module -Name CQHttp -Scope CurrentUser  # 安装 CQHttp 模块
2. 修改 $groups 为要应用的群号（一行一个，或用逗号分隔）
3. .\AntiFudai.ps1  # 运行脚本
#>

$groups = @(
    672076603
    615346135
)

Invoke-CQHttpBot -EventCallbacks @(, @("message.group.normal", {
            param ($Bot, $Ctx)

            if (($Ctx.raw_message -eq "收到福袋，请使用新版手机QQ查看") -and ($groups -contains $Ctx.group_id))
            {
                & $Bot.CallAction -Action "delete_msg" -Params $Ctx  # 撤回福袋
                # & $Bot.Send -Context $Ctx -Message "检测到福袋，已撤回"  # 提示已撤回
                # & $Bot.CallAction -Action "set_group_ban" -Params $Ctx  # 禁言 30 分钟
            }
        }))
