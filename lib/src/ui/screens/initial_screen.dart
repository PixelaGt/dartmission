import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/level_screen.dart';
import 'package:dartmission/src/ui/widgets/failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class InitialScreenView extends StatefulWidget {
  const InitialScreenView({Key? key}) : super(key: key);

  @override
  State<InitialScreenView> createState() => InitialScreenViewState();
}

class InitialScreenViewState extends State<InitialScreenView> {
  // Controller for playback
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('floating');
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;

    // final height = media.size.height;
    final isMobile = width <= 960 || false;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/jpg/background_space.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(
              Alignment.topRight.x + ( isMobile ? 0 : 0.3 ),
              Alignment.topRight.y - ( isMobile ? 0 : 1.5 ) ,
            ),
            child: Assets.images.svg.pinkAndBluePlanet.svg(
              width: isMobile ? width * 0.4 : 500,
              height: isMobile ? width * 0.4 : 500,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.topRight.x + ( isMobile ? 0 : 0.07),
              Alignment.topCenter.x,
            ),
            child: Assets.images.svg.orangePlanet.svg(
              width: isMobile ? width * 0.2 : 150,
              height: isMobile ? width * 0.2 : 150,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              isMobile ? Alignment.center.x : (Alignment.bottomRight.x -  0.3),
              Alignment.bottomRight.y - (isMobile ? 0.05 : 0.2),
            ),
            child: Assets.images.svg.pinkAndOrangePlanet.svg(
              width: isMobile ? width * 0.18 : 200,
              height: isMobile ? width * 0.18 : 200,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.centerLeft.x + (isMobile ? 0.2 : 0.35),
              Alignment.centerLeft.y - (isMobile ? 0.1 : 0.2),
            ),
            child: Assets.images.svg.title.svg(
              width: isMobile ? width * 0.6 : 450,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.centerLeft.x + (isMobile ? 0.2 : 0.35),
              Alignment.centerLeft.y + 0.08,
            ),
            child: Text(
              'A flutter adventure',
              style: isMobile ? 
                Theme.of(context).textTheme.headline5!.apply(
                  color: Colors.white,
                ) :
                Theme.of(context).textTheme.headline4!.apply(
                  color: Colors.white,
                ),
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.centerLeft.x + (isMobile ? 0.1 : 0.30),
              Alignment.centerLeft.y + (isMobile ? 0.28 : 0.35),
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
                height: isMobile ? 48 : 75,
                //
              ),
            ),
          ),
        ],
      ),
    );
  }
}
