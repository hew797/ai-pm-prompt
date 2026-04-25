# Claude Code 适配指南

## 配置方式

Claude Code 会自动读取项目根目录的 `CLAUDE.md` 文件。

安装脚本会自动创建 `CLAUDE.md`，内容为：

```
请阅读并严格执行 AGENTS.md 中定义的角色和流程。
同时阅读 .ai-pm/roles/pm-ux.md 作为产品经理技能库。
当用户使用 /pm-spec、/pm-layout、/pm-critique、/pm-audit 指令时，按照技能库中的对应格式输出。
```

如果你已有 `CLAUDE.md`，请手动将上述内容追加到文件末尾。

## 使用方式

在 Claude Code 中直接输入：

```
/pm-spec 做一个用户管理页面
```

## 注意事项

- Claude Code 的 `CLAUDE.md` 支持引用其他文件
- 如果内容过长，可以只在 CLAUDE.md 中写引用路径，让 Claude 按需读取
