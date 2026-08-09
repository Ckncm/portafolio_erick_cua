import 'package:flutter/material.dart';
import '../models/sketch_page_data.dart';

class SketchSectionPage extends StatelessWidget {
  final SketchPageData data;
  final List<Widget> children;

  const SketchSectionPage({
    super.key,
    required this.data,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = data.isDark;
    final defaultColor = const Color(0xFFD8C2A1);
    final bgColor = isDark ? const Color(0xFF2C2C3A) : (data.pageColor ?? defaultColor);
    final textColor = isDark ? Colors.white70 : const Color(0xFF4A4A4A);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black12,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (data.title != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: Text(
                data.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
