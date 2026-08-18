import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const PlaceholderImage({
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: const Color(0xFF1A2847),
          child: Center(
            child: Text(
              assetPath,
              style: const TextStyle(
                color: Color(0xFF00D9FF),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
