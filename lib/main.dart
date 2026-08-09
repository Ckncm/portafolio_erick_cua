import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      500 * 1024 * 1024; // 500 MB
  PaintingBinding.instance.imageCache.maximumSize = 200;
  runApp(const MyApp());
}
