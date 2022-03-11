import 'package:dartmission/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SpaceButton extends StatelessWidget {
  const SpaceButton({
    Key? key,
    required this.image,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  final SvgGenImage image;
  final VoidCallback onPressed;

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final currentColor = color ?? Theme.of(context).colorScheme.primary;
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final isMobile = screenWidth <= 960 || false;

    return Stack(
      children: [
        image.svg(
          height: height ?? (isMobile ? 48 : 75),
          width: width,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: currentColor,
              hoverColor: currentColor.withOpacity(0.3),
              onTap: onPressed,
            ),
          ),
        )
      ],
    );
  }
}
