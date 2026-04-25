# Windsurf 适配指南

## 配置方式

1. 在项目根目录创建 `.windsurfrules` 文件（安装脚本会自动创建）
2. 写入以下内容：

```
请阅读项目根目录的 AGENTS.md 文件，严格按照其中定义的角色和流程工作。
同时阅读 .ai-pm/roles/pm-ux.md 作为产品经理技能库。
当用户使用 /pm-spec、/pm-layout、/pm-critique、/pm-audit 指令时，按照技能库中的对应格式输出。
```

## 使用方式

在 Windsurf 的 AI Chat 中直接输入：

```
/pm-spec 做一个订单管理页面
```

## 注意事项

- Windsurf 会自动读取 `.windsurfrules` 文件
- 如果 AI 没有按照产品经理角色回应，在对话开头加一句："请先阅读项目根目录的 AGENTS.md 文件"
