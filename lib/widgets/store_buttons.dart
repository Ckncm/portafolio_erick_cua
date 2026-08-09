import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class StoreButtons extends StatelessWidget {
  const StoreButtons({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();

    return SizedBox(
      height: 50,
      child: Row(
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
    );
  }
}
