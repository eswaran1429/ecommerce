import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double size;

  const AppImage({super.key, required this.url, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (_, __) => const CircularProgressIndicator(strokeWidth: 2),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}