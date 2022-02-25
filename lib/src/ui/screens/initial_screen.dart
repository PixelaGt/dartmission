import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/level_screen.dart';
import 'package:flutter/material.dart';

class InitialScreenView extends StatefulWidget {
  const InitialScreenView({Key? key}) : super(key: key);

  @override
  State<InitialScreenView> createState() => InitialScreenViewState();
}

class InitialScreenViewState extends State<InitialScreenView> {
  @override
  Widget build(BuildContext context) {
    //final media = MediaQuery.of(context);
    //final width = media.size.width;

    // final height = media.size.height;
    // final isMobile = width <= 600 || false;
    return Stack(
      children: [
        Assets.images.svg.backgroundSpace2.svg(
          fit: BoxFit.fill,
        ),
        Align(
          alignment: Alignment(
            Alignment.topRight.x + 0.3,
            Alignment.topRight.y - 1.5,
          ),
          child: Assets.images.svg.pinkAndBluePlanet.svg(
            width: 500,
            height: 500,
            //
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.topRight.x + 0.07,
            Alignment.topCenter.x,
          ),
          child: Assets.images.svg.orangePlanet.svg(
            width: 150,
            height: 150,
            //
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.bottomRight.x - 0.3,
            Alignment.bottomRight.y - 0.2,
          ),
          child: Assets.images.svg.pinkAndOrangePlanet.svg(
            width: 200,
            height: 200,
            //
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.centerLeft.x + 0.35,
            Alignment.centerLeft.y - 0.2,
          ),
          child: Assets.images.svg.title.svg(
            width: 150,
            height: 150,
            //
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.centerLeft.x + 0.35,
            Alignment.centerLeft.y + 0.08,
          ),
          child: Text(
            'A flutter adventure',
            style: Theme.of(context).textTheme.headline4!.apply(
                  color: Colors.white,
                ),
          ),
        ),
        Align(
          alignment: Alignment(
            Alignment.centerLeft.x + 0.30,
            Alignment.centerLeft.y + 0.35,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const LevelScreen(),
                ),
              );
            },
            child: Assets.images.svg.startBtn.svg(
              width: 75,
              height: 75,
              //
            ),
          ),
        ),
      ],
    );
  }
}
