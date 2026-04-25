#!/bin/bash
# AI 产品经理提示词系统 — 一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/hew797/ai-pm-prompt/main/install.sh | bash -s -- /你的项目路径

set -e

# ===== 颜色定义 =====
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# ===== 参数检查 =====
TARGET_DIR="${1:-.}"

if [ "$TARGET_DIR" = "." ]; then
    TARGET_DIR=$(pwd)
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}❌ 目录不存在: $TARGET_DIR${NC}"
    echo "用法: install.sh /你的项目路径"
    exit 1
fi

echo ""
echo -e "${BLUE}🧠 AI 产品经理提示词系统 — 安装中...${NC}"
echo -e "   目标目录: ${GREEN}$TARGET_DIR${NC}"
echo ""

# ===== 下载源文件 =====
REPO_URL="https://raw.githubusercontent.com/hew797/ai-pm-prompt/main"
TEMP_DIR=$(mktemp -d)

echo -e "${YELLOW}📥 下载核心文件...${NC}"

curl -fsSL "$REPO_URL/AGENTS.md" -o "$TEMP_DIR/AGENTS.md"
curl -fsSL "$REPO_URL/roles/pm-ux.md" -o "$TEMP_DIR/pm-ux.md"
curl -fsSL "$REPO_URL/templates/prd-template.md" -o "$TEMP_DIR/prd-template.md"

# ===== 备份已有文件 =====
if [ -f "$TARGET_DIR/AGENTS.md" ]; then
    echo -e "${YELLOW}⚠️  检测到已有 AGENTS.md，备份为 AGENTS.md.bak${NC}"
    cp "$TARGET_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md.bak"
fi

# ===== 安装文件 =====
echo -e "${YELLOW}📂 安装文件...${NC}"

# 核心文件
cp "$TEMP_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"

# 技能库目录
mkdir -p "$TARGET_DIR/.ai-pm/roles"
mkdir -p "$TARGET_DIR/.ai-pm/templates"

cp "$TEMP_DIR/pm-ux.md" "$TARGET_DIR/.ai-pm/roles/pm-ux.md"
cp "$TEMP_DIR/prd-template.md" "$TARGET_DIR/.ai-pm/templates/prd-template.md"

# ===== 自动适配 AI 工具 =====
echo -e "${YELLOW}🔧 检测并适配 AI 工具...${NC}"

ADAPTED=0

# Gemini CLI — AGENTS.md 在根目录即可自动生效
echo -e "   ${GREEN}✅ Gemini CLI${NC} — AGENTS.md 已就位，自动生效"
ADAPTED=$((ADAPTED + 1))

# Cursor — 写入 .cursor/rules
if [ -d "$TARGET_DIR/.cursor" ] || command -v cursor &> /dev/null; then
    mkdir -p "$TARGET_DIR/.cursor"
    CURSOR_RULES="$TARGET_DIR/.cursor/rules"
    if [ ! -f "$CURSOR_RULES" ]; then
        cat > "$CURSOR_RULES" << 'CURSOR_EOF'
请阅读项目根目录的 AGENTS.md 文件，严格按照其中定义的角色和流程工作。
同时阅读 .ai-pm/roles/pm-ux.md 作为产品经理技能库。
当用户使用 /pm-spec、/pm-layout、/pm-critique、/pm-audit 指令时，按照技能库中的对应格式输出。
CURSOR_EOF
        echo -e "   ${GREEN}✅ Cursor${NC} — 已创建 .cursor/rules"
        ADAPTED=$((ADAPTED + 1))
    else
        echo -e "   ${YELLOW}⚠️  Cursor${NC} — .cursor/rules 已存在，请手动添加 AGENTS.md 引用"
    fi
fi

# Windsurf — 写入 .windsurfrules
if [ -d "$TARGET_DIR/.windsurf" ] || [ -f "$TARGET_DIR/.windsurfrules" ]; then
    if [ ! -f "$TARGET_DIR/.windsurfrules" ]; then
        cat > "$TARGET_DIR/.windsurfrules" << 'WINDSURF_EOF'
请阅读项目根目录的 AGENTS.md 文件，严格按照其中定义的角色和流程工作。
同时阅读 .ai-pm/roles/pm-ux.md 作为产品经理技能库。
当用户使用 /pm-spec、/pm-layout、/pm-critique、/pm-audit 指令时，按照技能库中的对应格式输出。
WINDSURF_EOF
        echo -e "   ${GREEN}✅ Windsurf${NC} — 已创建 .windsurfrules"
        ADAPTED=$((ADAPTED + 1))
    else
        echo -e "   ${YELLOW}⚠️  Windsurf${NC} — .windsurfrules 已存在，请手动添加 AGENTS.md 引用"
    fi
fi

# Claude Code — 写入 CLAUDE.md
if command -v claude &> /dev/null || [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    if [ ! -f "$TARGET_DIR/CLAUDE.md" ]; then
        cat > "$TARGET_DIR/CLAUDE.md" << 'CLAUDE_EOF'
请阅读并严格执行 AGENTS.md 中定义的角色和流程。
同时阅读 .ai-pm/roles/pm-ux.md 作为产品经理技能库。
当用户使用 /pm-spec、/pm-layout、/pm-critique、/pm-audit 指令时，按照技能库中的对应格式输出。
CLAUDE_EOF
        echo -e "   ${GREEN}✅ Claude Code${NC} — 已创建 CLAUDE.md"
        ADAPTED=$((ADAPTED + 1))
    else
        echo -e "   ${YELLOW}⚠️  Claude Code${NC} — CLAUDE.md 已存在，请手动添加 AGENTS.md 引用"
    fi
fi

# ===== 清理临时文件 =====
rm -rf "$TEMP_DIR"

# ===== 完成 =====
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 安装完成！${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "已安装的文件："
echo -e "   ${BLUE}AGENTS.md${NC}                    ← AI 行为准则"
echo -e "   ${BLUE}.ai-pm/roles/pm-ux.md${NC}        ← PM + UX 技能库"
echo -e "   ${BLUE}.ai-pm/templates/prd-template.md${NC} ← PRD 模板"
echo ""
echo "快速开始："
echo -e "   1. 打开你的 AI 工具（Gemini/Cursor/Windsurf/Claude）"
echo -e "   2. 对 AI 说：${YELLOW}/pm-spec 做一个用户管理页面${NC}"
echo -e "   3. 看 AI 产品经理怎么帮你分析需求 🚀"
echo ""
echo -e "更多用法: ${BLUE}https://github.com/hew797/ai-pm-prompt${NC}"
echo -e "进群交流: ${BLUE}README.md 底部扫码${NC}"
echo ""
