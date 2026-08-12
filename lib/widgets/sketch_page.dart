import 'package:flutter/material.dart';
import '../models/sketch_page_data.dart';

class SketchPage extends StatelessWidget {
  final SketchPageData data;

  const SketchPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return _buildEmpty();
    if (data.isCover) return _buildCover();
    if (data.isBackCover) return _buildBackCover();
    return _buildPage();
  }

  Widget _buildEmpty() {
    return Container(color: const Color(0xFF49403E));
  }

  Widget _buildCover() {
    return Container(
      color: const Color(0xFF2C2C3A),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories, size: 72, color: Colors.white70),
            SizedBox(height: 24),
            Text(
              'Portafolio',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Erick Natanael Cuá Morales',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCover() {
    return Container(
      color: const Color(0xFF2C2C3A),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.brush_outlined, size: 48, color: Colors.white54),
            SizedBox(height: 16),
            Text(
              'Gracias por ver',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    final isDark = data.isDark;
    final defaultColor = const Color(0xFFD8C2A1);
    final bgColor = isDark
        ? const Color(0xFF2C2C3A)
        : (data.pageColor ?? defaultColor);
    final textColor = isDark ? Colors.white70 : const Color(0xFF4A4A4A);
    final iconColor = isDark ? Colors.transparent : Colors.grey.shade400;

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
          if (data.title != null) _buildTitle(textColor),
          Expanded(child: _buildImages(iconColor)),
        ],
      ),
    );
  }

  Widget _buildTitle(Color textColor) {
    return Container(
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
    );
  }

  Widget _buildImages(Color iconColor) {
    if (data.imagePath == null) {
      return Center(
        child: Icon(Icons.brush_outlined, size: 64, color: iconColor),
      );
    }

    const cornerSize = 20.0;
    const cornerWidth = 2.0;
    final cornerColor = data.isDark ? Colors.white54 : Colors.black87;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                data.imagePath!,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                gaplessPlayback: true,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _buildCorner(
                cornerSize,
                cornerWidth,
                cornerColor,
                top: true,
                left: true,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _buildCorner(
                cornerSize,
                cornerWidth,
                cornerColor,
                top: true,
                right: true,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: _buildCorner(
                cornerSize,
                cornerWidth,
                cornerColor,
                bottom: true,
                left: true,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildCorner(
                cornerSize,
                cornerWidth,
                cornerColor,
                bottom: true,
                right: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(
    double size,
    double width,
    Color color, {
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: top ? BorderSide(color: color, width: width) : BorderSide.none,
            bottom: bottom
                ? BorderSide(color: color, width: width)
                : BorderSide.none,
            left: left
                ? BorderSide(color: color, width: width)
                : BorderSide.none,
            right: right
                ? BorderSide(color: color, width: width)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
