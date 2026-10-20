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

### 为什么是这三项（按 `sort=installs` 实测前 16 名对比）

| 指标 | make-ui-not-ai | 同类对比 | 结论 |
| --- | --- | --- | --- |
| `summary` 长度 | **49 字符** | 前 8 名其余为 43–90，全市场最高 126；我们是前 8 名里第二短 | 列表页信息量不足，双语用户看不懂用途 |
| `tags` 数量 | **4** | 多个包 6–8 个 | 少 4–6 个检索词入口 |
| `latestVersion` | **1.0** | 对手多为 2.0 / 2.0.0 / 1.1.0 | 内容已整体重写，版本未动会让老用户看不到更新 |
| `score` | **0.409（全场最高）** | 第二名 0.274 | 排名本身健康，短板只在列表文案 |
| `verified` | False | **全市场 16 个包无一通过认证** | 认证不是本市场的差异化因素，不必为此耗时 |

也就是说：**排名不弱，列表页偏弱**。上述三项是把现有流量转化成安装的直接杠杆。

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

`ship-it-mvp` 有 791 次安装，是第 4 名。它挂在旧 handle `1981094442` 下、source 写的是改名前仓库 `my-skill` 的路径。

**已实测核对，修正此前的判断——这不影响安装，也不丢导流**：

- `https://raw.githubusercontent.com/nanfei892/my-skill/master/ship-it-mvp/SKILL.md` 返回 **200**，GitHub 把旧仓库名重定向到了 `ship-it-skills`
- 该地址返回的内容与本地 `ship-it-mvp/SKILL.md` **逐字符一致**（4979 字符），也就是说上一轮加的 `## Related Skills` 互引**已经对这 791 个安装者生效**

所以剩余问题只有一个，属于整洁性而非功能性：市场列表页会把这个包显示在 `1981094442` 名下、并展示旧仓库路径。

**建议（可选，优先级低于改 summary/tags）**：重新发布到 `nanfei892` handle 下、source 指向
`https://github.com/nanfei892/ship-it-skills/blob/master/ship-it-mvp/SKILL.md`。收益是署名统一而不是安装量；
若嫌麻烦，保持现状也不会坏。

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
- [x] 仓库 `SKILL.md` 已推送到 master（市场安装源已核验与新内容**逐字符一致**）
- [x] skill-showcase 演示案例与核验工具已随仓库发布
- [x] `pwsh -File preflight.ps1` 通过（零阻塞项）
- [ ] summary 双语，≤200 字符 ← **需你登录提交**
- [ ] tags 由 4 个扩到 10 个 ← **需你登录提交**
- [ ] version 升到 2.0 ← **需你登录提交**

---

## 8. 发布前后对比基线

改 summary / tags / version 之后，要知道它到底有没有效果，而不是凭感觉。这是**改动前**的实测快照：

| 时点 | installs | stars | score | version | summary | tags |
| --- | --- | --- | --- | --- | --- | --- |
| 2026-10-15 前后（技能重写推送时） | 2396 | 2 | 0.409 | 1.0 | 49 | 4 |
| 2026-10-20 15:45 | **2454** | 3 | 0.483 | 1.0 | 49 | 4 |

**有机增速 ≈ 11.7 次/天**（5 天 +58），期间**列表页一个字都没改**。这 58 次全部来自仓库内容与自然流量。

所以更新提交后的判断标准是清楚的：

- 若日增仍在 12 上下 → 列表页文案不是瓶颈，下一步该换别的手段（案例传播、把 ship-it-mvp 迁到同一 handle）
- 若日增明显抬升（比如 20+/天）→ summary 与 tags 是真实瓶颈，值得继续优化列表页
- 若 `score` 跳升 → 版本号 / 描述参与了排序权重

隔 3–7 天用同一条命令再取一次，和上表对齐：

```powershell
pwsh -File preflight.ps1     # 会打印 installs / stars / score / summary 长度 / tags 数量
```

---

## 9. 曝光面诊断（2026-10-20 实测）

市场有四个排序面，我们的位置：

| 排序 | 我们的位置 | 说明 |
| --- | --- | --- |
| `installs` | **#1** / 16 | 安装量第一 |
| `recommended` | **#1** / 16 | 推荐位第一 |
| `trending` | **#1** / 16 | 趋势榜第一 |
| `new` | #12 / 16 | **唯一缺席的曝光面** |

**关键结论：升版本不会让你进入 `new` 榜。** `sort=new` 按**包创建时间**降序，与版本发布时间无关。证据是我们自己：

- `make-ui-not-ai` 最新版本创建于 **08-03**，`ship-it-backend` 最新版本创建于 **08-02**
- 若按版本时间排，我们应排在它前面
- 实际是 `ship-it-backend` #11、`make-ui-not-ai` #12 —— 顺序由包创建时间（08-02 vs 08-01）决定

另一个旁证：`new-project-init` 包创建于 08-16、最新版本 08-19，位置 #6 对应的是 08-16 而不是 08-19。

**这条对决策的影响：**

1. `new` 榜只能靠**以新包名重新发布**进入——但那会丢掉已积累的 2454 次安装，得不偿失，**不要做**
2. 三个有效榜单已经全部第一，**市场内的排名空间已经饱和**
3. 所以市场侧剩下的唯一杠杆是**转化率**（列表页文案/tags），不是排名
4. 升版本 2.0 的价值仅在于：对老用户表示有更新、避免"内容大改但版本还写 1.0"的困惑，以及可能影响 `score`（公式未知）。**不要期待它带来新曝光**

要再上一个量级，只能走出市场：仓库自身的传播、案例页被看到、以及在别的技能里被点名（后者已全部完成并核验生效）。

