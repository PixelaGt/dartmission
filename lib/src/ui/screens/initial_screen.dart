import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/level_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class InitialScreenView extends StatefulWidget {
  const InitialScreenView({Key? key}) : super(key: key);

  @override
  State<InitialScreenView> createState() => InitialScreenViewState();
}

class InitialScreenViewState extends State<InitialScreenView> {
  // Controller for playback
  late RiveAnimationController _controller;
  late Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    _loadAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadAnimation() async {
    final animationBytes = await rootBundle.load(Assets.rive.pixman.path);
    final riveFile = RiveFile.import(animationBytes);
    var artboard = riveFile.mainArtboard;
    _controller = SimpleAnimation('floating');
    artboard = riveFile.mainArtboard
      ..clip = false
      ..addController(_controller);
    setState(() => _artboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;

    // final height = media.size.height;
    final isMobile = screenWidth <= 960 || false;
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
              Alignment.topRight.x + (isMobile ? 0 : 0.3),
              Alignment.topRight.y - (isMobile ? 0 : 1.5),
            ),
            child: Assets.images.svg.pinkAndBluePlanet.svg(
              width: isMobile ? screenWidth * 0.4 : 500,
              height: isMobile ? screenWidth * 0.4 : 500,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.topRight.x + (isMobile ? 0 : 0.07),
              Alignment.topCenter.x,
            ),
            child: Assets.images.svg.orangePlanet.svg(
              width: isMobile ? screenWidth * 0.2 : 150,
              height: isMobile ? screenWidth * 0.2 : 150,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              isMobile ? Alignment.center.x : (Alignment.bottomRight.x - 0.3),
              Alignment.bottomRight.y - (isMobile ? 0.05 : 0.2),
            ),
            child: Assets.images.svg.pinkAndOrangePlanet.svg(
              width: isMobile ? screenWidth * 0.18 : 200,
              height: isMobile ? screenWidth * 0.18 : 200,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.centerLeft.x + (isMobile ? 0.2 : 0.35),
              Alignment.centerLeft.y - (isMobile ? 0.1 : 0.2),
            ),
            child: Assets.images.svg.title.svg(
              width: isMobile ? screenWidth * 0.6 : 450,
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
              style: isMobile
                  ? Theme.of(context).textTheme.headline5!.apply(
                        color: Colors.white,
                      )
                  : Theme.of(context).textTheme.headline4!.apply(
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
              ),
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.centerRight.x - 0.25,
              Alignment.center.y,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.20,
              child: _artboard == null
                  ? Container()
                  : Rive(
                      artboard: _artboard!,
                      antialiasing: false,
                      alignment: Alignment.center,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
