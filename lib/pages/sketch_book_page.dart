import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:portafolio_erick_cua/widgets/sketch_section_page.dart';
import 'package:portafolio_erick_cua/widgets/store_buttons.dart';
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
    SketchPageData.empty(),
    SketchPageData(imagePath: 'assets/sketches/1.jpg'),
    SketchPageData(imagePath: 'assets/sketches/2.jpg'),
    SketchPageData(imagePath: 'assets/sketches/3.jpg'),
    SketchPageData(imagePath: 'assets/sketches/4.jpg'),
    SketchPageData(imagePath: 'assets/sketches/5.jpg'),
    SketchPageData(imagePath: 'assets/sketches/6.jpg'),
    SketchPageData(imagePath: 'assets/sketches/7.jpg'),
    SketchPageData(imagePath: 'assets/sketches/8.jpg'),
    SketchPageData.empty(),
    SketchPageData(imagePath: 'assets/chats.jpg'),
    SketchPageData(imagePath: 'assets/clubs.jpg'),
    SketchPageData(imagePath: 'assets/explorar.jpg'),
    SketchPageData(imagePath: 'assets/post.jpg'),
    SketchPageData.backCover(),
    SketchPageData.empty(),
  ];

  static const _extraAssets = [
    'assets/calet.png',
    'assets/google.webp',
    'assets/apple.webp',
  ];

  bool _imagesReady = false;

  int get _totalPages => _pages.length;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _precacheImages();
    });
  }

  Future<void> _precacheImages() async {
    final allPaths = [
      ..._pages.where((p) => p.imagePath != null).map((p) => p.imagePath!),
      ..._extraAssets,
    ];
    await Future.wait(
      allPaths.map(
        (path) => precacheImage(AssetImage(path), context).catchError((_) {}),
      ),
    );
    if (mounted) setState(() => _imagesReady = true);
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

  Widget _buildCaletSection() {
    return SketchSectionPage(
      data: const SketchPageData(),
      children: [
        Image.asset(
          'assets/calet.png',
          height: 120,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(height: 8),
        const Text(
          'Calet',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 24),
        if (kIsWeb) const StoreButtons(),
      ],
    );
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
        child: Stack(
          children: [
            Center(
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
                          if (index == 2) {
                            return SketchSectionPage(
                              data: const SketchPageData(),
                              children: const [
                                Text(
                                  'Dibujos a Mano',
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                Icon(Icons.brush, size: 48),
                              ],
                            );
                          }
                          if (index == 11) return _buildCaletSection();
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
            const Positioned(
              top: 2,
              left: 0,
              right: 0,
              child: Text(
                'Desliza o presiona ← → para cambiar de página',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
