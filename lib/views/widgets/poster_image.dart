import 'package:flutter/material.dart';

class PosterImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;

  const PosterImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  Widget _placeholder() => Container(
        width: width,
        height: height,
        color: Colors.grey.shade900,
        child: const Center(
          child: Icon(Icons.movie_outlined, color: Colors.white38, size: 32),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) return _placeholder();
    return Image.network(
      url!,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade900,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stack) => _placeholder(),
    );
  }
}
