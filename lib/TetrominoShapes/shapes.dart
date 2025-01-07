import 'package:flutter/painting.dart';

/// 游戏面板的尺寸常量
/// 定义游戏区域的行数和列数
// 游戏面板的宽度（列数）
int rowLength = 10;
// 游戏面板的高度（行数）
int columnLength = 15;

/// 方块移动方向的枚举定义
/// 包含左、右、下三个方向
enum Direction {
  left, // 向左移动
  right, // 向右移动
  down // 向下移动
}

/// 俄罗斯方块形状的枚举定义
/// 包含7种标准的俄罗斯方块形状
enum TetrominoShapes {
  L, // L形方块
  J, // J形方块
  I, // I形方块（直线形）
  O, // O形方块（方形）
  S, // S形方块
  Z, // Z形方块
  T // T形方块
}

/// 方块颜色映射表
/// 为每种形状定义对应的显示颜色
Map<TetrominoShapes, Color> tetrominoColor = {
  TetrominoShapes.L: Color(0xFFFFA500), // L形方块 - 橙色
  TetrominoShapes.J: Color(0xff045AFA), // J形方块 - 蓝色
  TetrominoShapes.I: Color.fromARGB(255, 232, 11, 147), // I形方块 - 粉色
  TetrominoShapes.O: Color(0xFFFFff00), // O形方块 - 黄色
  TetrominoShapes.S: Color(0xFF12C800), // S形方块 - 绿色
  TetrominoShapes.Z: Color(0xFFEE0000), // Z形方块 - 红色
  TetrominoShapes.T: Color.fromARGB(255, 144, 26, 190), // T形方块 - 紫色
};

/* 方块形状示意图：
 *   L形：        J形：        I形：        O形：
 *   x            x          x x x x      x x
 *   x            x                       x x
 *   x x          x x
 *
 *   S形：        Z形：        T形：
 *     x x      x x          x x x
 *   x x          x x          x
 */