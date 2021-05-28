import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  final List<Color>? colors;
  const ShimmerLoading(
      {Key? key, required this.isLoading, required this.child, this.colors})
      : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  late LinearGradient _shimmerGradient;
  @override
  void initState() {
    _shimmerGradient = LinearGradient(
      colors: widget.colors ??
          [
            Color(0xFFEBEBF4),
            Color(0xFFF4F4F4),
            Color(0xFFEBEBF4),
          ],
      stops: [
        0.1,
        0.3,
        0.4,
      ],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: IgnorePointer(ignoring: widget.isLoading, child: widget.child),
    );
  }
}
