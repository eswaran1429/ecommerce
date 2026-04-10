import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

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

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
