import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'sketch_book_page.dart';

@JS('document.documentElement.requestFullscreen')
external JSAny? _requestFullscreenJS();

class FullscreenPrompt extends StatelessWidget {
  const FullscreenPrompt({super.key});

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 768;

  @override
  Widget build(BuildContext context) {
    if (!isMobile(context)) {
      return const SketchBookPage();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF49403E),
      body: Center(
        child: GestureDetector(
          onTap: () => _enterFullscreen(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.fullscreen,
                size: 64,
                color: Colors.white70,
              ),
              const SizedBox(height: 24),
              const Text(
                'Presiona para usar\npantalla completa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Toca para continuar',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enterFullscreen(BuildContext context) {
    if (kIsWeb) {
      try {
        _requestFullscreenJS();
      } catch (_) {}
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SketchBookPage()),
    );
  }
}
