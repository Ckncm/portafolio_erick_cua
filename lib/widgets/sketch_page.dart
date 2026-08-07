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
    return Container(
      color: const Color(0xFF49403E),
    );
  }

  Widget _buildCover() {
    return Container(
      color: const Color(0xFF2C2C3A),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories,
              size: 72,
              color: Colors.white70,
            ),
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
              'Erick Cua',
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
            Icon(
              Icons.brush_outlined,
              size: 48,
              color: Colors.white54,
            ),
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
    final bgColor = isDark ? const Color(0xFF2C2C3A) : (data.pageColor ?? defaultColor);
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
    if (data.imagePaths.isEmpty) {
      return Center(
        child: Icon(
          Icons.brush_outlined,
          size: 64,
          color: iconColor,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: data.imagePaths.length == 1
          ? _buildSingleImage(data.imagePaths[0])
          : _buildDualImages(),
    );
  }

  Widget _buildSingleImage(String path) {
    return Center(
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            path,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildDualImages() {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                data.imagePaths[0],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                data.imagePaths[1],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
