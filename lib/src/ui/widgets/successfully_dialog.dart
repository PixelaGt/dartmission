import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SuccessfullyDialog extends StatefulWidget {
  const SuccessfullyDialog({
    Key? key,
    required this.onContinue,
  }) : super(key: key);

  final VoidCallback onContinue;

  @override
  State createState() => _SuccessfullyDialogState();
}

class _SuccessfullyDialogState extends State<SuccessfullyDialog> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    _controller = SimpleAnimation('win');
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isMobile = screenWidth <= 960 || false;

    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.2),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Great!',
              style: isMobile
                  ? Theme.of(context).textTheme.headline3!.apply(
                        color: Colors.white,
                      )
                  : Theme.of(context).textTheme.headline2!.apply(
                        color: Colors.white,
                      ),
            ),
            Text(
              'You have successfully \nCompleted the mission!',
              style: Theme.of(context).textTheme.headline5!.apply(
                    color: Colors.white,
                  ),
            ),
            SizedBox(
              height: isMobile ? screenHeight / 30 : screenHeight / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const InitialScreenView(),
                      ),
                    );
                  },
                  child: Assets.images.svg.exitBtn.svg(
                    height: isMobile ? 40 : 75,
                    width: isMobile ? 24 : 75,
                  ),
                ),
                SizedBox(
                  width: isMobile ? screenWidth / 30 : screenWidth / 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onContinue.call();
                  },
                  child: Assets.images.svg.newMissionBtn.svg(
                    height: isMobile ? 40 : 75,
                    width: isMobile ? 24 : 75,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(
                Alignment.centerRight.x - 0.25,
                Alignment.center.y,
              ),
              child: SizedBox(
                height: 150,
                width: 150,
                child: RiveAnimation.asset(
                  Assets.rive.pixman.path,
                  antialiasing: false,
                  alignment: Alignment.center,
                  animations: const ['win'],
                  controllers: [_controller],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
