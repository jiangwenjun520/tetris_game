# Tetris Game

A classic implementation of the popular Tetris game built using Flutter and Dart.
This version stays true to the original gameplay mechanics while offering a visually appealing user interface.

## 项目概述

这是一个使用Flutter框架开发的经典俄罗斯方块游戏，完美复刻了原版游戏的核心玩法，并加入了现代化的UI设计。

### 主要功能

- 经典的俄罗斯方块游戏玩法
- 随机生成不同形状的方块
- 方块旋转和移动控制
- 行消除计分系统
- 三种难度级别（Easy/Normal/Hard）
  - Easy: 较慢的下落速度，适合新手
  - Normal: 标准下落速度，适合熟练玩家
  - Hard: 快速下落，高分倍率，适合挑战
- 游戏时间记录
- 美观的用户界面
  - 简洁的顶部状态栏
  - 实时显示分数和时间
  - 下一个方块预览
  - 难度选择菜单

### 技术架构

项目采用Flutter框架开发，使用了以下主要技术：

- **Flutter & Dart**: 用于构建跨平台用户界面
- **状态管理**: 使用Flutter原生状态管理
- **文件结构**:
  - `lib/Screens/`: 包含所有游戏界面
  - `lib/TetrominoShapes/`: 定义所有方块形状
  - `lib/logic/`: 游戏核心逻辑
  - `lib/widgets/`: 可重用的UI组件
  - `lib/config/`: 游戏配置
  - `lib/models/`: 数据模型
  - `lib/main.dart`: 应用入口

### 游戏规则

1. 使用方向键或屏幕按钮控制方块移动和旋转
2. 完成一整行方块可消除该行并得分
3. 方块堆积到顶部时游戏结束
4. 不同难度等级有不同的下落速度和分数倍率
5. 游戏会记录每局用时

### 安装和运行

1. 确保已安装Flutter开发环境
2. 克隆项目到本地
3. 运行 `flutter pub get` 安装依赖
4. 使用 `flutter run` 启动游戏

### 游戏截图

![游戏主界面](https://github.com/SHahdAyman20/Tetris-Game/assets/121692567/d5ccab78-44b3-4177-b23e-5e26b20ca24c)

![游戏画面1](https://github.com/SHahdAyman20/Tetris-Game/assets/121692567/7eddf137-db6b-4338-90f3-eb2520cb219d)

![游戏画面2](https://github.com/SHahdAyman20/Tetris-Game/assets/121692567/95cfc077-a1c6-406a-9172-8399aed32713)

### 未来计划

- [x] 添加不同难度级别
- [x] 优化界面布局
- [ ] 添加音效和背景音乐
- [ ] 实现高分排行榜
- [ ] 支持自定义主题
- [ ] 添加多人对战模式

### 贡献指南

欢迎提交Issue和Pull Request来帮助改进游戏。请确保在提交代码前：

1. 代码符合项目规范
2. 添加必要的注释
3. 更新相关文档
4. 测试功能正常

### 许可证

本项目采用 MIT 许可证
