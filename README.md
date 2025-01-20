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
  - Easy: 1500ms下落间隔，1倍分数，适合新手
  - Normal: 1200ms下落间隔，2倍分数，适合熟练玩家
  - Hard: 800ms下落间隔，3倍分数，适合挑战
- 游戏时间记录
- 美观的用户界面
  - 简洁的顶部状态栏
  - 实时显示分数和时间
  - 下一个方块预览
  - 难度选择菜单
  - 优雅的背景设计
  - 方块圆角和阴影效果

### 技术架构

项目采用Flutter框架开发，使用了以下主要技术：

- **Flutter & Dart**: 用于构建跨平台用户界面
- **状态管理**: 使用Flutter原生状态管理
- **文件结构**:
  - `lib/Screens/`: 包含所有游戏界面
    - `home_page.dart`: 主页面
    - `game_board.dart`: 游戏面板
    - `difficulty_menu.dart`: 难度选择菜单
  - `lib/TetrominoShapes/`: 定义所有方块形状
    - `shapes.dart`: 方块形状枚举
    - `pieces.dart`: 方块类定义
  - `lib/widgets/`: 可重用的UI组件
    - `game_grid.dart`: 游戏网格
    - `pixel.dart`: 单个方块组件
  - `lib/config/`: 游戏配置
    - `game_config.dart`: 游戏参数配置
  - `lib/main.dart`: 应用入口

### 技术细节

#### 游戏配置
- 游戏面板尺寸: 10列 x 15行
- 方块样式:
  - L形: 橙色 (#FFA500)
  - J形: 蓝色 (#045AFA)
  - I形: 粉色 (#E80B93)
  - O形: 黄色 (#FFFF00)
  - S形: 绿色 (#12C800)
  - Z形: 红色 (#EE0000)
  - T形: 紫色 (#901ABE)
- UI配置:
  - 方块圆角: 4.0
  - 方块边距: 1.0
  - 默认字体大小: 20.0
  - 标题字体大小: 30.0
  - 按钮字体大小: 40.0

### 最新优化（2024-03-21）

#### 1. 核心算法优化
- **旋转系统重构**
  - 使用预计算的旋转状态矩阵，减少运行时计算
  - 统一管理所有方块的旋转逻辑
  - 优化旋转中心点选择算法
  - 添加边界检查，防止数组越界

- **碰撞检测优化**
  - 实现专门的旋转碰撞检测方法
  - 优化边界检查算法
  - 添加投影位置计算功能
  - 实现高效的碰撞预测系统

- **移动系统优化**
  - 使用增量更新替代循环遍历
  - 统一处理不同方向的移动逻辑
  - 优化移动边界检测

#### 2. 性能优化
- **数据结构优化**
  - 使用Map存储方块旋转状态
  - 优化List操作，减少内存分配
  - 使用const优化静态数据

- **计算优化**
  - 减少不必要的对象创建
  - 优化循环和条件判断
  - 使用switch表达式简化逻辑判断

- **类型安全**
  - 添加明确的类型声明
  - 优化空值检查
  - 规范化类型转换

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

### 开发者指南

#### 代码规范
1. 使用有意义的变量和函数名
2. 为所有类和公共方法添加文档注释
3. 遵循Flutter的代码格式化规则
4. 使用const构造函数优化性能
5. 适当抽象和封装代码

#### 性能优化
1. 使用const widget减少重建
2. 合理使用StatelessWidget和StatefulWidget
3. 避免不必要的setState调用
4. 优化图片资源大小
5. 使用适当的数据结构

### 未来计划

- [x] 添加不同难度级别
- [x] 优化界面布局
- [x] 优化核心游戏算法
- [ ] 添加音效和背景音乐
- [ ] 实现高分排行榜
- [ ] 支持自定义主题
- [ ] 添加多人对战模式
- [ ] 添加游戏教程
- [ ] 支持手势控制
- [ ] 添加暂停功能
- [ ] 支持存档功能

### 贡献指南

欢迎提交Issue和Pull Request来帮助改进游戏。请确保在提交代码前：

1. 代码符合项目规范
2. 添加必要的注释
3. 更新相关文档
4. 测试功能正常
5. 遵循Git提交规范

### 许可证

本项目采用 MIT 许可证
