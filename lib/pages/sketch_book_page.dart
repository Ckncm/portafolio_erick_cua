import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _focusNode = FocusNode();

  final List<SketchPageData> _pages = const [
    SketchPageData.empty(),
    SketchPageData.cover(),
    SketchPageData(title: '', imagePath: 'assets/sketches/1.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/2.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/3.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/4.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/5.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/6.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/7.jpg'),
    SketchPageData(title: '', imagePath: 'assets/sketches/8.jpg'),
    SketchPageData.backCover(),
    SketchPageData.empty(),
  ];

  bool _imagesReady = false;

  int get _totalPages => _pages.length;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    final imagePaths = _pages
        .where((p) => p.imagePath != null)
        .map((p) => p.imagePath!)
        .toList();

    await Future.wait(
      imagePaths.map((path) => precacheImage(AssetImage(path), context)),
    );

    if (mounted) {
      setState(() => _imagesReady = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(KeyEvent event) {
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _controller.nextSpread();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _controller.previousSpread();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF49403E),
      body: Focus(
        focusNode: _focusNode,
        onKeyEvent: (node, event) {
          _onKey(event);
          return KeyEventResult.handled;
        },
        autofocus: true,
        child: Center(
          child: _imagesReady
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  child: BookFlip.builder(
                    controller: _controller,
                    pageCount: _totalPages,
                    pageSize: const Size(360, 520),
                    material: BookFlipMaterial.paper,
                    curl: BookFlipCurl.gentle,
                    effects: const BookFlipEffects(
                      gloss: false,
                      grain: false,
                      castShadow: true,
                      spineShadow: true,
                      edge: false,
                      translucency: false,
                    ),
                    fit: BookFit.contain,
                    pageBuilder: (context, index) {
                      return SketchPage(data: _pages[index]);
                    },
                  ),
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white54),
                    SizedBox(height: 16),
                    Text(
                      'Cargando portafolio...',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
