import 'dart:ui';

class SketchPageData {
  final List<String> imagePaths;
  final String? title;
  final bool isCover;
  final bool isBackCover;
  final bool isDark;
  final bool isEmpty;
  final Color? pageColor;

  const SketchPageData({
    required this.imagePaths,
    this.title,
    this.isCover = false,
    this.isBackCover = false,
    this.isDark = false,
    this.isEmpty = false,
    this.pageColor,
  });

  const SketchPageData.cover()
      : imagePaths = const [],
        title = null,
        isCover = true,
        isBackCover = false,
        isDark = false,
        isEmpty = false,
        pageColor = null;

  const SketchPageData.backCover()
      : imagePaths = const [],
        title = null,
        isCover = false,
        isBackCover = true,
        isDark = false,
        isEmpty = false,
        pageColor = null;

  const SketchPageData.empty()
      : imagePaths = const [],
        title = null,
        isCover = false,
        isBackCover = false,
        isDark = false,
        isEmpty = true,
        pageColor = null;
}
