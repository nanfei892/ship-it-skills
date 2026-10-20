# 发布清单 — 照抄即可

> 依据与论证见 [MARKET-LISTING.md](MARKET-LISTING.md)。这里只有操作步骤。
> 字段与 placeholder 已于 2026-10-20 对照 https://reasonix.io/skills/ 的实际 markup 核对。
> **本文档不含任何自动化发布动作**，需要你登录后在浏览器里提交。

---

## 0. 前提：先确认状态

```powershell
pwsh -File ..\preflight.ps1
```

必须是 `READY: no blocking problems.`。若出现 `FAIL`，先解决再发。

---

## 1. 表单字段（按页面上的真实顺序）

| 字段 | 页面 placeholder | 填什么 |
| --- | --- | --- |
| `kind` | 下拉 | `skill`（保持不变） |
| `name` | `my-package` | `make-ui-not-ai`（**必须保持不变**，改了等于新建一个包，会丢掉 2454 次安装） |
| `version` | `0.1.0` | `2.0` |
| `summary` | `What does it do?` | 见下方 S，**上限 200 字符**（页面 `maxlength=200`） |
| `source` | `https://… SKILL.md …` | 见下方 R（必填） |
| `repoUrl` | `https://github.com/…` | 见下方 P |
| `tags` | `testing, go, review` | 见下方 T（逗号分隔） |
| `private` | 复选框 | **不勾** |

---

## 2. 可直接粘贴的值

**S — summary（中英双语，133 字符）**

```
消灭 AI 模板味的前端设计技能：点名禁用具体俗套 + 精确数值表（过渡、scale(0.96)、同心圆角、焦点环、命中区）+ 独立视觉评审与截图核验。Build UI with product identity, not generic AI templates.
```

**R — source**

```
https://github.com/nanfei892/ship-it-skills/blob/master/make-ui-not-ai/SKILL.md
```

**P — repoUrl**

```
https://github.com/nanfei892/ship-it-skills/
```

**T — tags（10 个，原为 4 个）**

```
frontend, ui-design, design-system, responsive, accessibility, animation, interaction-design, css, visual-review, anti-ai-slop
```

---

## 3. 提交后会发生什么

- 新版本进入**管理员审核**，审核通过前列表页不显示更新（private 包跳过审核，但我们这个不是 private）
- 审核期间 `latestVersion` 仍是 `1.0`，这是正常的，不是失败
- **不要**因为没立刻看到变化就重复提交

---

## 4. 如何确认真的生效

```powershell
pwsh -File ..\preflight.ps1
```

看它的 marketplace 段落，三项都应改变：

| 项 | 提交前 | 期望 |
| --- | --- | --- |
| `latestVersion` | `1.0` | `2.0` |
| `summary` 长度 | 49 | 133 |
| `tags` 数量 | 4 | 10 |

三项里两项还是旧值 → 审核未通过或未提交成功。

---

## 5. 事后怎么判断有没有用

改动前基线（2026-10-20 实测）：**2454 安装 / score 0.483 / 有机增速约 11.7 次/天**。

隔 3–7 天再跑一次 preflight，和基线比：

- 日增仍在 12 上下 → 列表页文案不是瓶颈，别再在这上面花时间
- 日增明显抬升（如 20+/天）→ summary 与 tags 是真实瓶颈
- `score` 跳升 → 版本号 / 描述参与了排序权重

**已知且不要误判的一点**：升到 2.0 **不会**让你出现在市场的 `new` 榜。`sort=new` 按包创建时间排序，与版本无关，这个结论已实测证明（见 MARKET-LISTING.md 第 9 节）。我们目前 `installs` / `recommended` / `trending` 三个榜单都已是第一，市场内的排名空间已经饱和。

---

## 6. 可选项（优先级低于上面）

`ship-it-mvp` 挂在旧 handle `1981094442`、source 写的是旧仓库名 `my-skill`。**实测不影响安装**（GitHub 会重定向，内容与本地逐字符一致，791 个安装者不受影响），只是列表页署名与路径不统一。想统一的话照第 2 节的方式重发一次，`name` 保持 `ship-it-mvp`，`source` 改成：

```
https://github.com/nanfei892/ship-it-skills/blob/master/ship-it-mvp/SKILL.md
```
