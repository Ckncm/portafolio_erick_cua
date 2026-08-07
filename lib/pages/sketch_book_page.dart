import 'package:flutter/material.dart';
import 'package:book_page_flip/book_page_flip.dart';
import '../models/sketch_page_data.dart';
import '../widgets/sketch_page.dart';

class SketchBookPage extends StatefulWidget {
  const SketchBookPage({super.key});

  @override
  State<SketchBookPage> createState() => _SketchBookPageState();
}

class _SketchBookPageState extends State<SketchBookPage> {
  final _controller = BookFlipController();

  final List<SketchPageData> _pages = const [
    SketchPageData(imagePaths: [], pageNumber: 1),
    SketchPageData(imagePaths: [], pageNumber: 2),
    SketchPageData(imagePaths: [], pageNumber: 3),
    SketchPageData(imagePaths: [], pageNumber: 4),
    SketchPageData(imagePaths: [], pageNumber: 5),
    SketchPageData(imagePaths: [], pageNumber: 6),
  ];

  int get _totalPages => _pages.length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BookFlip.builder(
                  controller: _controller,
                  pageCount: _totalPages,
                  pageSize: const Size(360, 520),
                  material: BookFlipMaterial.paper,
                  curl: BookFlipCurl.gentle,
                  effects: BookFlipEffects.all,
                  fit: BookFit.contain,
                  pageBuilder: (context, index) {
                    return SketchPage(data: _pages[index]);
                  },
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final isFirst = _controller.currentPage <= 0;
          final isLast = _controller.currentPage >= _totalPages - 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: !isFirst
                    ? () => _controller.previousSpread()
                    : null,
                icon: const Icon(Icons.chevron_left),
                color: Colors.white,
                disabledColor: Colors.white24,
                iconSize: 32,
              ),
              const SizedBox(width: 32),
              IconButton(
                onPressed: !isLast
                    ? () => _controller.nextSpread()
                    : null,
                icon: const Icon(Icons.chevron_right),
                color: Colors.white,
                disabledColor: Colors.white24,
                iconSize: 32,
              ),
            ],
          );
        },
      ),
    );
  }
}
