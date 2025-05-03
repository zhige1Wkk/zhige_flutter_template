import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zhige_flutter_tempate/components/code_wrapper.dart';
import 'package:zhige_flutter_tempate/components/latex.dart';

class MarkdownRenderer extends StatelessWidget {
  final String data;
  final bool selectable;
  final ScrollController? controller;
  final EdgeInsets padding;

  const MarkdownRenderer({
    super.key,
    required this.data,
    this.selectable = true,
    this.controller,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: data,
      selectable: selectable,
      controller: controller,
      padding: padding,
      onTapLink: (text, href, title) {
        if (href != null) {
          _launchUrl(href);
        }
      },
      builders: {
        'code': CodeElementBuilder(),
        'math': LatexElementBuilder(),
      },
      styleSheet: MarkdownStyleSheet(
        h1: Theme.of(context).textTheme.headlineLarge,
        h2: Theme.of(context).textTheme.headlineMedium,
        h3: Theme.of(context).textTheme.headlineSmall,
        h4: Theme.of(context).textTheme.titleLarge,
        h5: Theme.of(context).textTheme.titleMedium,
        h6: Theme.of(context).textTheme.titleSmall,
        p: Theme.of(context).textTheme.bodyMedium,
        a: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
        code: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        ),
        codeblockDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(4.0),
        ),
        blockquoteDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4.0),
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 4.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}