# Cursor 适配指南

## 方式一：Project Rules（推荐）

1. 在项目根目录创建 `.cursor/rules` 文件（安装脚本会自动创建）
2. 写入以下内容：

```
请阅读项目根目录的 AGENTS.md 文件，严格按照其中定义的角色和流程工作。
同时阅读 .ai-pm/roles/pm-ux.md 作为产品经理技能库。
当用户使用 /pm-spec、/pm-layout、/pm-critique、/pm-audit 指令时，按照技能库中的对应格式输出。
```

## 方式二：直接粘贴到 Settings

1. 打开 Cursor → Settings → Rules for AI
2. 将 `AGENTS.md` 的**全部内容**粘贴进去

## 方式三：.cursorrules 文件

在项目根目录创建 `.cursorrules` 文件，将 `AGENTS.md` 内容粘贴进去。

## 使用方式

在 Cursor Chat 或 Composer 中直接输入：

```
/pm-spec 做一个用户管理页面
```

Cursor 会自动加载 Project Rules，AI 会按照产品经理角色回应你。

## 注意事项

- Cursor 的 Project Rules 有字数限制，如果超出，建议用方式一（引用文件路径）
- 如果 AI 没有按照产品经理角色回应，在对话开头加一句："请先阅读 AGENTS.md"
