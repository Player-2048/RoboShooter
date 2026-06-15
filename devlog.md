# 开发日志

> 本文档记录项目每次关键开发节点，方便后续 AI 会话快速了解项目上下文和历史决策。
> 每次重要变更后，AI 应在此追加记录。

---

## 2026-06-15 | 项目整合与技术选型变更

**操作者：** AI (Claude Code)

**变更内容：**
- 技术栈由 Unity + C# 改为 **Godot 4.x + GDScript**
  - 理由：Godot 对初学者更友好，场景文件为纯文本便于 Git 管理和 AI 协作，MIT 许可证免费
- 更新 `.gitignore` 从 Unity 模板替换为 Godot 模板
- 更新 `README.md` 反映新的技术栈和项目结构
- 创建 `devlog.md` 作为 AI 上下文日志
- 整合分散在桌面各处的游戏设计文档和网页原型到本仓库

**整合的设计文档：**
- `docs/design.md` ← `机器人射击游戏设想.md`（核心设计，8 大系统）
- 其余 docx 设计文档保留在桌面，必要时再整理

**整合的网页原型：**
- `prototypes/coin-collector/` ← `游戏开发/HTML+CSS+JavaScript/捡金币.*`
- `prototypes/corridor-shooter/` ← `过道射击游戏.html`
- `prototypes/platform-movement/` ← `简易平台移动.html`
- `prototypes/block-movement/` ← `简易方块移动.html`

**项目当前状态：**
- GitHub 仓库：https://github.com/Player-2048/RoboShooter
- 本地路径：`C:\Users\Admin\Desktop\RoboShooter`
- Git 用户名：Player-2048
- 许可证：MIT

**下一步计划：**
1. 安装 Godot 4.x 引擎
2. 创建 Godot 项目文件（project.godot）
3. 搭建第一人称测试场地：大面积平面 + WASD 移动 + 跳跃
4. 逐步加入武器系统、交互道具

---

## 早期记录（2025年，摘要）

- 创建 GitHub 仓库 RoboShooter
- 添加 MIT 许可证
- 编写初始 README（当时计划使用 Unity）
- 设计文档 `机器人射击游戏设想.md` 编写完成，规划了地图、探图、黑客网络、仓库加工、机器人、血条、枪械、物资搬运共 8 大系统
