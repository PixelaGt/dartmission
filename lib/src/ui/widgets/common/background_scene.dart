import 'package:dartmission/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';

class BackgroundScene extends StatelessWidget {
  const BackgroundScene({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;

    // final height = media.size.height;
    final isMobile = screenWidth <= 760;
    final isTablet = screenWidth > 760 && screenWidth <= 1024;

    return Stack(
      children: [
        Align(
          alignment: Alignment(
            isMobile ? Alignment.center.x : Alignment.bottomLeft.x - 0.45,
            Alignment.bottomLeft.y +
                (isMobile
                    ? 0.45
                    : isTablet
                        ? 0.3
                        : 0.90),
          ),
          child: Assets.images.svg.pinkAndBluePlanet.svg(
            width: isMobile
                ? screenWidth * 0.5
                : isTablet
                    ? screenWidth * 0.3
                    : 500,
            height: isMobile
                ? screenWidth * 0.5
                : isTablet
                    ? screenWidth * 0.3
                    : 500,
          ),
        ),
        Align(
          child: Assets.images.svg.pinkPlanet.svg(
            width: isMobile ? screenWidth : screenWidth * 0.5,
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.topRight.x + 0.07,
            Alignment.topCenter.y + (isMobile ? 0.2 : 0.5),
          ),
          child: Assets.images.svg.orangePlanet.svg(
            width: isMobile ? screenWidth * 0.1 : 100,
            height: isMobile ? screenWidth * 0.1 : 100,
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.center.x - 0.8,
            Alignment.centerLeft.y - (isMobile ? 0.8 : 0.5),
          ),
          child: Assets.images.svg.pinkAndCianPlanet.svg(
            width: isMobile ? screenWidth * 0.2 : 125,
            height: isMobile ? screenWidth * 0.2 : 125,
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.topLeft.x + 0.1,
            Alignment.topLeft.y + 0.1,
          ),
          child: Assets.images.svg.title.svg(
            width: 50,
            height: 50,
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.center.x,
            Alignment.center.y,
          ),
          child: child,
        ),
      ],
    );
  }
}
