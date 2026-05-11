---
title: Tavily Skills 完全指南：为 AI Agent 赋予强大的网络搜索与研究能力
description: Tavily Skills五大核心技能详解：网页搜索、内容提取、站点爬取、URL发现和深度研究，附安装配置教程
keywords:
  - Tavily
  - AI Agent
  - 网页搜索
  - 内容提取
  - 站点爬取
tags:
  - AI
  - Agent
  - Tavily
  - 搜索
  - 工具
categories:
  - AI 开发
abbrlink: 11c95aa
date: 2026-05-10 10:12:11
---

# Tavily Skills 完全指南：为 AI Agent 赋予强大的网络搜索与研究能力

## 什么是 Tavily Skills？

[Tavily Skills](https://github.com/tavily-ai/skills) 是一套专为 AI Agent 设计的技能集合，基于 Tavily CLI（`tvly`）构建，提供**网页搜索、内容提取、站点爬取、URL 发现和深度研究**五大核心能力。与普通的搜索 API 不同，Tavily 返回的结果经过 LLM 优化，直接适用于 AI Agent 的上下文窗口。

<!-- more -->

## 核心能力一览

| 技能 | 用途 | 典型场景 |
|------|------|----------|
| `tavily-search` | 网页搜索 | 查找文章、获取新闻、发现信息源 |
| `tavily-extract` | 内容提取 | 从指定 URL 提取干净的 Markdown 文本 |
| `tavily-crawl` | 站点爬取 | 批量下载文档站、离线保存网页 |
| `tavily-map` | URL 发现 | 探索网站结构、找到特定页面 |
| `tavily-research` | 深度研究 | 多源综合分析、带引用的研究报告 |
| `tavily-dynamic-search` | 动态搜索 | 上下文隔离的编程式搜索，节省 token |

## 安装指南

### 第一步：安装 Tavily CLI

```bash
# 方式一：官方安装脚本
curl -fsSL https://cli.tavily.com/install.sh | bash

# 方式二：通过 pip（推荐使用虚拟环境）
python3 -m venv ~/.hermes/tools/tavily-cli-venv
~/.hermes/tools/tavily-cli-venv/bin/pip install tavily-cli

# 方式三：通过 uv
uv tool install tavily-cli
```

### 第二步：认证

```bash
# 使用 API Key 认证
tvly login --api-key tvly-YOUR_KEY

# 或者通过环境变量
export TAVILY_API_KEY=tvly-YOUR_KEY

# 或者 OAuth 浏览器认证
tvly login
```

### 第三步：验证安装

```bash
tvly --status
# 应输出：Authenticated via API key
```

### 第四步（可选）：安装 Agent Skills

如果你使用 Claude Code、Cursor 等支持 Agent Skills 的工具：

```bash
npx skills add https://github.com/tavily-ai/skills
```

## 推荐工作流

Tavily 官方推荐的渐进式工作流，从简单到复杂：

```
Search → Extract → Map → Crawl → Research
搜索     提取      映射    爬取     研究
```

### 1. Search — 搜索（起点）

当你没有具体 URL，需要查找信息时使用。

```bash
# 基础搜索
tvly search "量子计算最新进展" --json

# 高级搜索，获取更多结果
tvly search "AI agent frameworks" --depth advanced --max-results 10 --json

# 最近一周的新闻
tvly search "ChatGPT 更新" --time-range week --topic news --json

# 限定域名搜索
tvly search "Python 教程" --include-domains docs.python.org,realpython.com --json

# 包含 AI 生成的答案
tvly search "什么是 RAG" --include-answer advanced --json

# 包含完整页面内容（省去后续 extract 步骤）
tvly search "React hooks 教程" --include-raw-content --max-results 3 --json
```

**搜索深度对比：**

| 深度 | 速度 | 相关性 | 适用场景 |
|------|------|--------|----------|
| `ultra-fast` | 最快 | 较低 | 实时聊天、自动补全 |
| `fast` | 快 | 良好 | 需要快速结果 |
| `basic` | 中等 | 高 | **通用场景（默认）** |
| `advanced` | 较慢 | 最高 | 精确查找特定事实 |

### 2. Extract — 内容提取

当你有了具体 URL，想获取页面内容时使用。

```bash
# 提取单个页面
tvly extract "https://example.com/article" --json

# 批量提取（最多 20 个 URL）
tvly extract "https://example.com/page1" "https://example.com/page2" --json

# 查询聚焦提取（只返回相关片段）
tvly extract "https://docs.example.com" --query "认证 API" --chunks-per-source 3 --json

# 处理 JavaScript 渲染的页面
tvly extract "https://spa-app.example.com" --extract-depth advanced --json

# 保存到文件
tvly extract "https://example.com/article" -o article.md
```

**提取深度：**
- `basic`（默认）：简单页面，速度快，优先尝试
- `advanced`：JS 渲染的 SPA、动态内容、复杂表格

### 3. Map — URL 发现

探索网站结构，不提取内容，比爬取更快。

```bash
# 发现所有 URL
tvly map "https://docs.example.com" --json

# 自然语言过滤
tvly map "https://docs.example.com" --instructions "找到 API 文档和指南" --json

# 路径过滤
tvly map "https://example.com" --select-paths "/blog/.*" --limit 500 --json

# 深度探索
tvly map "https://example.com" --max-depth 3 --limit 200 --json
```

**Map + Extract 模式**（推荐）：先用 map 找到目标页面，再用 extract 提取具体内容，比直接 crawl 更高效：

```bash
# 第一步：找到认证文档的 URL
tvly map "https://docs.example.com" --instructions "authentication" --json

# 第二步：提取该页面
tvly extract "https://docs.example.com/api/authentication" --json
```

### 4. Crawl — 站点爬取

批量提取网站内容，适合下载整个文档站。

```bash
# 基础爬取
tvly crawl "https://docs.example.com" --json

# 保存每个页面为 Markdown 文件
tvly crawl "https://docs.example.com" --output-dir ./docs/

# 深度爬取并限制数量
tvly crawl "https://docs.example.com" --max-depth 2 --limit 50 --json

# 路径过滤
tvly crawl "https://example.com" \
  --select-paths "/api/.*,/guides/.*" \
  --exclude-paths "/blog/.*" \
  --json

# 语义聚焦（Agent 场景推荐，避免上下文爆炸）
tvly crawl "https://docs.example.com" \
  --instructions "Find authentication docs" \
  --chunks-per-source 3 \
  --json
```

**两种使用模式：**
- **Agent 场景**：用 `--instructions` + `--chunks-per-source`，只返回相关片段
- **数据收集**：用 `--output-dir`，保存完整页面为 Markdown 文件

### 5. Research — 深度研究

AI 驱动的多源综合分析，自动带引用，耗时 30-120 秒。

```bash
# 基础研究
tvly research "AI 代码助手的竞争格局"

# Pro 模型，更全面的分析
tvly research "电动汽车市场分析" --model pro

# 实时流式输出
tvly research "AI Agent 框架对比" --stream

# 保存报告
tvly research "金融科技趋势 2025" --model pro -o fintech-report.md

# 异步模式
tvly research "量子计算突破" --no-wait --json    # 返回 request_id
tvly research status <request_id> --json           # 检查状态
tvly research poll <request_id> --json -o result.json  # 等待完成
```

**模型选择：**

| 模型 | 适用场景 | 耗时 |
|------|----------|------|
| `mini` | 单一主题、定向研究 | ~30s |
| `pro` | 多角度综合分析、对比 | ~60-120s |
| `auto` | API 根据复杂度自动选择 | 不定 |

## 高级技巧：Dynamic Search（动态搜索）

这是一个非常巧妙的技能，核心思想是**不让原始搜索结果污染 LLM 的上下文窗口**。

一次典型的 `tvly search --include-raw-content` 可能返回 8 个结果 × 30-50K 字符 = **约 30 万字符**的原始页面内容。如果这些全部进入上下文，LLM 会浪费大量 token 在导航栏、Cookie 横幅和模板内容上。

Dynamic Search 的解决方案：**通过 Python 脚本处理搜索结果，只有 `print()` 的内容进入上下文**，通常只有 1-3K 字符的纯信号，减少 100-200 倍。

```bash
# 错误做法 — 原始结果淹没上下文
tvly search "quantum computing 2025" --json

# 正确做法 — 只有 print() 输出进入上下文
tvly search "quantum computing 2025" --json 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
for r in data['results']:
    print(f'[{r[\"score\"]:.2f}] {r[\"title\"]}')
    print(f'  {r[\"url\"]}')
"
```

## Python SDK 集成

除了 CLI，Tavily 还提供 Python SDK：

```bash
pip install tavily-python
```

```python
from tavily import TavilyClient

client = TavilyClient()  # 自动读取 TAVILY_API_KEY 环境变量

# 搜索
response = client.search(
    query="quantum computing breakthroughs",
    max_results=10,
    search_depth="advanced"
)

# 提取
response = client.extract(
    urls=["https://docs.example.com"],
    extract_depth="advanced"
)

# 爬取
response = client.crawl(
    url="https://docs.example.com",
    instructions="Find API documentation"
)

# 研究
response = client.research(
    query="AI agent frameworks comparison",
    model="pro"
)
```

## 实用 Tips

1. **搜索查询保持在 400 字符以内** — 像搜索引擎查询那样写，不要写成 prompt
2. **复杂查询拆分为子查询**，分别搜索效果更好
3. **用 `--include-raw-content`** 在搜索时就获取完整内容，省去单独 extract 的步骤
4. **用 `--include-domains`** 限定可信来源
5. **用 `--time-range`** 获取最新信息
6. **爬取前先用 map** 了解网站结构
7. **始终设置 `--limit`** 防止爬取失控
8. **Agent 场景优先使用 `--instructions` + `--chunks-per-source`**，避免上下文爆炸

## 总结

Tavily Skills 提供了一套完整的网络信息获取工具链，从快速搜索到深度研究，覆盖了 AI Agent 在网络交互中的所有常见需求。其核心优势在于：

- **LLM 优化的输出格式**：结果直接适用于 AI 消费
- **渐进式工作流**：从简单到复杂，按需升级
- **上下文友好**：Dynamic Search 技术大幅减少 token 消耗
- **灵活的集成方式**：CLI、SDK、Agent Skills 多种接入方式

无论你是在构建 AI Agent、RAG 系统还是自动化研究工具，Tavily Skills 都是一个值得纳入工具箱的选择。

> GitHub 仓库：https://github.com/tavily-ai/skills
> 官方文档：https://tavily.com
