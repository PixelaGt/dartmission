import 'package:dartmission/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Spaceman extends StatefulWidget {
  const Spaceman({
    Key? key,
    required this.animation,
    this.height,
    this.width,
  }) : super(key: key);

  final String animation;
  final double? width;
  final double? height;

  @override
  State<Spaceman> createState() => _SpacemanState();
}

class _SpacemanState extends State<Spaceman> {
  late RiveAnimationController _controller;

  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation(widget.animation);
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
    artboard = riveFile.mainArtboard
      ..clip = false
      ..addController(_controller);
    setState(() => _artboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? MediaQuery.of(context).size.width * 0.15,
      width: widget.width ?? MediaQuery.of(context).size.width * 0.20,
      child: _artboard == null
          ? Container()
          : Rive(
              artboard: _artboard!,
              antialiasing: false,
              alignment: Alignment.center,
            ),
    );
  }
}
