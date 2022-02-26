import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class FailedDialog extends StatefulWidget {
  const FailedDialog({
    Key? key,
    required this.onRestart,
  }) : super(key: key);

  final VoidCallback onRestart;

  @override
  State createState() => _FailedDialogState();
}

class _FailedDialogState extends State<FailedDialog> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    _controller = SimpleAnimation('floating');
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
              'Failed!',
              style: isMobile
                  ? Theme.of(context).textTheme.headline3!.apply(
                        color: Colors.orange,
                      )
                  : Theme.of(context).textTheme.headline2!.apply(
                        color: Colors.orange,
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
                    widget.onRestart.call();
                  },
                  child: Assets.images.svg.restartBtn.svg(
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
                  animations: const ['floating'],
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
