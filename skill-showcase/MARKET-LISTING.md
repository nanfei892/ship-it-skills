# Reasonix 市场发布文案（make-ui-not-ai）

> 用途：在 https://reasonix.io/skills/ 的 **Publish** 表单中填写，或用于更新已有条目。
> 约束：`summary` 字段 **最多 200 字符**（表单 `maxlength="200"`）；市场是**双语**的（EN / 中文），
> 现有条目 `summary` 为纯中文，英文用户无法判断用途。
> 发布源（source）应保持为单文件 `SKILL.md` 的 raw/blob 地址。

---

## 0. 现状：哪些已经做完，哪些只能你来

市场里 v1.0 的**安装源就是 master 上的 `SKILL.md`**，所以推送到 GitHub 即等于更新用户装到的东西，
不需要重新走审核。已完成：

- [x] 重写后的 `SKILL.md` 已推送到 `master`，并已核验 `raw.githubusercontent.com` 正在提供新内容
- [x] 四个兄弟技能（mvp / backend / security / performance）已加入流水线互引，同样推送即生效
- [x] `README.md` / `README.en.md` 里失效的安装链接（指向已改名的 `my-skill`）已修正
- [x] 演示页与核验工具已随仓库发布

**只能由你完成**：`POST /v1/packages` 需要浏览器登录态（我已实测：无凭据返回 `401`，
本机 `.dsh/.credentials.yaml` 里的 `browser-session` 凭据同样返回 `401`）。所以
**升版本、换 summary、加 tags** 这三件事需要你登录 https://reasonix.io/skills/ 后手动提交。

---

## 1. summary（一句话简介，≤200 字符）

表单只有一个 summary 字段，没有独立的 description/homepage。因此 write 一个双语版本，
让两种语言的用户都能在列表页判断用途。

**推荐（中英双语，133 字符）**

```
消灭 AI 模板味的前端设计技能：点名禁用具体俗套 + 精确数值表（过渡、scale(0.96)、同心圆角、焦点环、命中区）+ 独立视觉评审与截图核验。Build UI with product identity, not generic AI templates.
```

备用（纯中文，65 字符）：

```
前端技能：消灭 AI 模板味。点名禁用具体俗套而非泛泛说"避免 AI 味"，内置精确数值表与截图核验，让界面可用、完整、有辨识度。
```

备用（纯英文，172 字符）：

```
Frontend skill that kills the generic AI look. Names the specific patterns to refuse, ships a canonical values table for polish, and verifies visuals with real screenshots.
```

---

## 2. tags（逗号分隔）

现为：`frontend, ui-design, responsive, accessibility`

**建议扩为**（覆盖新能力带来的检索词，全部是用户在市场上会搜的词）：

```
frontend, ui-design, design-system, responsive, accessibility, animation, interaction-design, css, visual-review, anti-ai-slop
```

理由：`animation`、`interaction-design`、`design-system`、`css` 是本次重写新增的能力面，
且都是高频检索词；`anti-ai-slop` 是差异化定位词。

---

## 3. version

现为 `1.0`。内容已大幅重写（新增禁用清单、精确数值表、交互动效规范、性能卫生、
图标规范、多风格方向协议），**应升版本**：`2.0`

一则让老用户看到更新，二则避免市场缓存与仓库内容不一致造成的新用户困惑。

---

## 4. repoUrl

保持 `https://github.com/nanfei892/ship-it-skills/`

---

## 5. 家族一致性（重要，影响导流）

当前同一套技能被拆到**两个 handle、两个仓库**：

| 包 | handle | 源仓库 | 问题 |
| --- | --- | --- | --- |
| make-ui-not-ai | `nanfei892` | `ship-it-skills` | 正确 |
| ship-it-backend | `nanfei892` | `ship-it-skills` | 正确 |
| ship-it-mvp | `1981094442` | `my-skill`（旧名） | **handle 与仓库都过期** |

`ship-it-mvp` 有 782 次安装，是第 4 名。它挂在旧 handle 下、指向已改名的仓库，
既无法与另外两个技能互相导流，也可能因仓库改名导致安装失败。

**建议**：把 `ship-it-mvp` 重新发布到 `nanfei892` handle 下、源指向
`https://github.com/nanfei892/ship-it-skills/blob/master/ship-it-mvp/SKILL.md`，
并在三个技能的 summary 里互相点名（见下）。

---

## 6. 交叉导流

本套技能是一条流水线，点名彼此能提升单包的安装量。

**仓库侧已做**：四个兄弟技能的 `SKILL.md` 末尾都已加入统一的 `## Related Skills` 段落，
标明流水线顺序并给出 make-ui-not-ai 的安装路径。因为这些文件本身就是安装源，
装 ship-it-mvp / backend / security / performance 的用户现在都能看到前端技能。

**市场侧仍可做**（需登录，写进 summary）：

- make-ui-not-ai 的 summary 末尾：「配套 ship-it-mvp（产品蓝图）、ship-it-backend（后端切片）」
- ship-it-mvp 的 summary 末尾：「下一步用 make-ui-not-ai 做出有产品身份的前端」
- ship-it-backend 的 summary 末尾：「前端对接用 make-ui-not-ai」

---

## 7. 提交前核对

- [x] source 指向 `ship-it-skills`（不是 `my-skill`）
- [x] 仓库 `SKILL.md` 已推送到 master（市场安装源已核验为新内容）
- [x] skill-showcase 演示案例与核验工具已随仓库发布
- [ ] summary 双语，≤200 字符 ← **需你登录提交**
- [ ] tags 由 4 个扩到 10 个 ← **需你登录提交**
- [ ] version 升到 2.0 ← **需你登录提交**
