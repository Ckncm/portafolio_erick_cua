import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;
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
    SketchPageData(imagePath: 'assets/sketches/1.webp'),
    SketchPageData(imagePath: 'assets/sketches/2.webp'),
    SketchPageData(imagePath: 'assets/sketches/3.webp'),
    SketchPageData(imagePath: 'assets/sketches/4.webp'),
    SketchPageData(imagePath: 'assets/sketches/5.webp'),
    SketchPageData(imagePath: 'assets/sketches/6.webp'),
    SketchPageData(imagePath: 'assets/sketches/7.webp'),
    SketchPageData(imagePath: 'assets/sketches/8.webp'),
    SketchPageData.empty(),
    SketchPageData(imagePath: 'assets/chats.webp'),
    SketchPageData(imagePath: 'assets/clubs.webp'),
    SketchPageData(imagePath: 'assets/explorar.webp'),
    SketchPageData(imagePath: 'assets/post.webp'),
    SketchPageData.backCover(),
    SketchPageData.empty(),
  ];

  static const _extraAssets = [
    'assets/calet.png',
    'assets/google.webp',
    'assets/apple.webp',
    'assets/instagram.webp',
    'assets/cat.webp',
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
    final allImagePaths = _pages
        .where((p) => p.imagePath != null)
        .map((p) => p.imagePath!)
        .toList();

    await Future.wait([
      ...allImagePaths.map(
        (path) => precacheImage(AssetImage(path), context).catchError((_) {}),
      ),
      ..._extraAssets.map(
        (path) => precacheImage(AssetImage(path), context).catchError((_) {}),
      ),
    ]);

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
      data: const SketchPageData(title: 'Aplicaciones Moviles'),
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

  void _showInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF49403E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    'assets/calet.png',
                    height: 64,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Descarga Calet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Listener(
                        onPointerDown: (PointerDownEvent _) {
                          web.window.open(
                            'https://play.google.com/store/apps/details?id=com.gersonpm.calet&hl=es_BO&pli=1',
                            '_blank',
                          );
                        },
                        child: Image.asset(
                          'assets/google.webp',
                          height: 44,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Listener(
                        onPointerDown: (PointerDownEvent _) {
                          web.window.open(
                            'https://apps.apple.com/us/app/calet/id6761416439',
                            '_blank',
                          );
                        },
                        child: Image.asset(
                          'assets/apple.webp',
                          height: 44,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sígueme en Instagram',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInstagramLink(
                    label: 'Cuenta artística',
                    url:
                        'https://www.instagram.com/nekink_19?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==&igsi=ZDNlZDc0MzIxNw==',
                  ),
                  const SizedBox(height: 10),
                  _buildInstagramLink(
                    label: 'Cuenta artística',
                    url:
                        'https://www.instagram.com/erickcua_19?igsh=MWxoczgzZmN3cml3OA==&igsi=MWxoczgzZmN3cml3OA==',
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white12,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/cat.webp',
                    height: 36,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Desarrollado por: Erick Cuá (ckncm)',
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInstagramLink({required String label, required String url}) {
    return Listener(
      onPointerDown: (PointerDownEvent _) {
        web.window.open(url, '_blank');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/instagram.webp',
            height: 28,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.open_in_new, color: Colors.white38, size: 14),
        ],
      ),
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
            Positioned(
              top: 12,
              right: 16,
              child: GestureDetector(
                onTap: _imagesReady ? () => _showInfoModal(context) : null,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _imagesReady ? Colors.white24 : Colors.white10,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: _imagesReady ? Colors.white : Colors.white24,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
