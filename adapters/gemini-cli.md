# Gemini CLI 适配指南

## 自动生效

Gemini CLI 会自动读取项目根目录的 `AGENTS.md` 文件作为系统指令，**无需任何额外配置**。

安装完成后，直接在项目目录下启动 Gemini：

```bash
cd /你的项目路径
gemini
```

## 使用方式

在对话中直接使用指令：

```
/pm-spec 做一个订单管理页面
```

```
/pm-critique 用户列表页
```

```
/pm-layout 数据看板
```

## 如果你的项目已有 AGENTS.md

安装脚本会自动备份原文件为 `AGENTS.md.bak`。

如果你想合并两个文件的内容，可以手动编辑：将 `ai-pm-prompt` 的 AGENTS.md 内容追加到你原有的 AGENTS.md 末尾。

## 高级用法：配合 .gemini/agents/ 使用

如果你的项目使用了 Gemini CLI 的多 Agent 架构：

1. 将 `pm-ux.md` 复制到 `.gemini/agents/` 目录下
2. 在 GEMINI.md 中添加 PM Agent 的引用

```bash
cp .ai-pm/roles/pm-ux.md .gemini/agents/pm-ux.md
```
