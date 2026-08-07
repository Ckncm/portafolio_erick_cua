import 'package:flutter/material.dart';
import '../models/sketch_page_data.dart';

class SketchPage extends StatelessWidget {
  final SketchPageData data;

  const SketchPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2EDE6),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (data.imagePaths.isEmpty) {
      return Center(
        child: Icon(
          Icons.brush_outlined,
          size: 64,
          color: Colors.grey.shade400,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
