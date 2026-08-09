import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portafolio_erick_cua/widgets/sketch_section_page.dart';
import 'package:book_page_flip/book_page_flip.dart';
import 'package:url_launcher/url_launcher.dart';
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
    SketchPageData.empty(), // 0: exterior izq (oculto al inicio)
    SketchPageData.cover(), // 1: portada
    SketchPageData.empty(), // 2: sección "Dibujos a Mano"
    SketchPageData(imagePath: 'assets/sketches/1.jpg'), // 3
    SketchPageData(imagePath: 'assets/sketches/2.jpg'), // 4
    SketchPageData(imagePath: 'assets/sketches/3.jpg'), // 5
    SketchPageData(imagePath: 'assets/sketches/4.jpg'), // 6
    SketchPageData(imagePath: 'assets/sketches/5.jpg'), // 7
    SketchPageData(imagePath: 'assets/sketches/6.jpg'), // 8
    SketchPageData(imagePath: 'assets/sketches/7.jpg'), // 9
    SketchPageData(imagePath: 'assets/sketches/8.jpg'), // 10
    SketchPageData.empty(), // 11: sección "Calet"
    SketchPageData(imagePath: 'assets/chats.jpg'), // 12
    SketchPageData(imagePath: 'assets/clubs.jpg'), // 13
    SketchPageData(imagePath: 'assets/explorar.jpg'), // 14
    SketchPageData(imagePath: 'assets/post.jpg'), // 15
    SketchPageData.backCover(), // 17: contra-portada
    SketchPageData.empty(), // 18: exterior der (oculto al final)
  ];

  // Assets extra que no están en _pages pero hay que precachear
  static const _extraAssets = [
    'assets/calet.png',
    'assets/google.webp',
    'assets/apple.webp',
  ];

  bool _imagesReady = false;

  int get _totalPages => _pages.length;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    final imagePaths = [
      ..._pages.where((p) => p.imagePath != null).map((p) => p.imagePath!),
      ..._extraAssets,
    ];

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
                      // Índice 2: sección "Dibujos a Mano"
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
                      // Índice 11: sección "Calet"
                      if (index == 11) {
                        return SketchSectionPage(
                          data: const SketchPageData(),
                          children: [
                            Image.asset(
                              'assets/calet.png',
                              height: 120,
                              filterQuality: FilterQuality.high,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => launchUrl(
                                    Uri.parse(
                                      'https://play.google.com/store/apps/details?id=com.gersonpm.calet&hl=es_BO&pli=1',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  ),
                                  child: Image.asset(
                                    'assets/google.webp',
                                    height: 40,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                GestureDetector(
                                  onTap: () => launchUrl(
                                    Uri.parse(
                                      'https://apps.apple.com/us/app/calet/id6761416439',
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  ),
                                  child: Image.asset(
                                    'assets/apple.webp',
                                    height: 40,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
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
