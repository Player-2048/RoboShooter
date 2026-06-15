# RoboShooter

一款远程操控机器人对战的第一人称射击游戏。

## 当前状态

**极早期开发阶段** — 正在搭建测试场地原型，实现基础移动、射击等核心交互。

## 核心玩法设想

- 玩家远程操控各类**机器人**进行战斗，而非人类角色
- **未来科幻风格**的电磁武器、火药武器系统
- 独特的**机器人血量/能源/算力**三维生存机制
- 矿场主题地图，含黑客网络、仓库加工、物资搬运等深度玩法

> 详细设计文档见 [docs/design.md](docs/design.md)

## 技术栈

| 类别 | 选用 |
|------|------|
| 游戏引擎 | [Godot 4.x](https://godotengine.org/) |
| 脚本语言 | GDScript |
| 版本控制 | Git & GitHub |
| 许可证 | MIT |

## 项目结构

```
RoboShooter/
├── README.md           # 项目说明（你在这）
├── LICENSE             # MIT 许可证
├── devlog.md           # 开发日志（AI 上下文）
├── docs/               # 设计文档
│   └── design.md       # 游戏系统设计
├── prototypes/         # 早期网页原型
│   ├── coin-collector/
│   ├── corridor-shooter/
│   ├── platform-movement/
│   └── block-movement/
├── project.godot       # Godot 项目文件（待创建）
├── scenes/             # 游戏场景（待创建）
├── scripts/            # GDScript 脚本（待创建）
└── assets/             # 游戏资源（待创建）
```

## 开发路线

- [x] 项目初始化、许可证、README
- [x] 游戏设计文档整理
- [x] 网页原型整合
- [ ] 搭建 Godot 项目框架
- [ ] 测试场地：平面空间 + 第一人称移动
- [ ] 射击系统：武器生成与弹道
- [ ] 交互道具系统
- [ ] 机器人技能系统
- [ ] 地图设计与场景搭建

## 如何参与

本项目由个人学习开发，采用 MIT 协议开源，欢迎任何形式的交流与建议。

- 提 **Issue** 反馈问题或建议
- 提 **Pull Request** 贡献代码
