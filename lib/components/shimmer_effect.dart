import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 扫光效果组件
/// 给子组件添加扫光动画效果
class ShimmerEffect extends StatelessWidget {
  /// 子组件
  final Widget child;
  
  /// 基础颜色
  final Color baseColor;
  
  /// 高亮颜色
  final Color highlightColor;
  
  /// 方向，默认从左到右
  final ShimmerDirection direction;
  
  /// 循环周期，默认1500毫秒
  final Duration period;
  
  /// 是否启用
  final bool enabled;

  /// 扫光效果组件
  /// 
  /// [child] 要添加扫光效果的子组件
  /// [baseColor] 基础颜色，默认为透明蓝色
  /// [highlightColor] 高亮颜色，默认为白色半透明
  /// [direction] 方向，默认从左到右
  /// [period] 循环周期，默认1500毫秒
  /// [enabled] 是否启用，默认启用
  const ShimmerEffect({
    super.key,
    required this.child,
    this.baseColor = const Color(0x550175C2),
    this.highlightColor = const Color(0x77FFFFFF),
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 3000),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      direction: direction,
      period: period,
      child: child,
    );
  }
}

/// 文本扫光效果组件
class ShimmerText extends StatelessWidget {
  /// 文本内容
  final String text;
  
  /// 文字样式
  final TextStyle? style;
  
  /// 文本对齐方式
  final TextAlign? textAlign;
  
  /// 基础颜色
  final Color baseColor;
  
  /// 高亮颜色
  final Color highlightColor;
  
  /// 方向，默认从左到右
  final ShimmerDirection direction;
  
  /// 循环周期，默认1500毫秒
  final Duration period;
  
  /// 文本扫光效果组件
  /// 
  /// [text] 文本内容
  /// [style] 文字样式
  /// [textAlign] 文本对齐方式
  /// [baseColor] 基础颜色
  /// [highlightColor] 高亮颜色
  /// [direction] 方向，默认从左到右
  /// [period] 循环周期，默认1500毫秒
  const ShimmerText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.baseColor = const Color(0xFF0175C2),
    this.highlightColor = const Color(0xAAFFFFFF),
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 3000),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        direction: direction,
        period: period,
        child: Text(
          text,
          style: style,
          textAlign: textAlign,
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    );
  }
}

/// 扫光按钮组件
class ShimmerButton extends StatelessWidget {
  /// 子组件
  final Widget child;
  
  /// 点击回调
  final VoidCallback onPressed;
  
  /// 按钮样式
  final ButtonStyle? style;
  
  /// 基础颜色
  final Color baseColor;
  
  /// 高亮颜色
  final Color highlightColor;
  
  /// 方向，默认从左到右
  final ShimmerDirection direction;
  
  /// 循环周期，默认1500毫秒
  final Duration period;

  /// 扫光按钮组件
  /// 
  /// [child] 按钮内容
  /// [onPressed] 点击回调
  /// [style] 按钮样式
  /// [baseColor] 基础颜色
  /// [highlightColor] 高亮颜色
  /// [direction] 方向，默认从左到右
  /// [period] 循环周期，默认1500毫秒
  const ShimmerButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.style,
    this.baseColor = const Color(0xFF0175C2),
    this.highlightColor = const Color(0xAAFFFFFF),
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 3000),
  });

  @override
  Widget build(BuildContext context) {
    // 为了获取样式中定义的圆角，我们使用默认值
    final BorderRadius borderRadius = BorderRadius.circular(16);
    
    return Stack(
      children: [
        // 底层按钮（处理圆角、阴影等）
        ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: const SizedBox.shrink(),
        ),
        
        // 扫光层，使用ClipRRect确保内容不溢出
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius,
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                direction: direction,
                period: period,
                child: Container(
                  color: baseColor,
                ),
              ),
            ),
          ),
        ),
        
        // 内容层（处理点击和显示内容）
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onPressed,
              borderRadius: borderRadius,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 