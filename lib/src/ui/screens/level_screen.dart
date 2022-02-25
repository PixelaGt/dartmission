import 'package:dartmission/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //       child: Container(
    //     color: Colors.black,
    //   )),
    // );
    return Stack(
      children: [
        Assets.images.svg.backgroundSpace2.svg(
          fit: BoxFit.fill,
        ),
        Align(
          alignment: Alignment(
            Alignment.bottomLeft.x - 0.45,
            Alignment.bottomLeft.y + 0.90,
          ),
          child: Assets.images.svg.pinkAndBluePlanet.svg(
            width: 500,
            height: 500,
            //
          ),
        ),
        Align(
          child: Assets.images.svg.pinkPlanet.svg(),
        ),
        Align(
          alignment: Alignment(
            Alignment.topRight.x + 0.07,
            Alignment.topCenter.y + 0.5,
          ),
          child: Assets.images.svg.orangePlanet.svg(
            width: 100,
            height: 100,
            //
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.center.x - 0.8,
            Alignment.centerLeft.y - 0.5,
          ),
          child: Assets.images.svg.pinkAndCianPlanet.svg(
            width: 125,
            height: 125,
            //
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
            //
          ),
        ),
      ],
    );
  }
}
