import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as md;

class LatexElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final String texContent = element.textContent;
    
    // 根据标签类型处理行内公式或块级公式
    final bool isInline = element.attributes['mode'] == 'inline';
    
    return Math.tex(
      texContent,
      textStyle: preferredStyle,
      mathStyle: isInline ? MathStyle.text : MathStyle.display,
      textScaleFactor: 1.2,
    );
  }
} 