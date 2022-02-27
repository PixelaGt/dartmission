import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/initial_screen.dart';
import 'package:dartmission/src/ui/themes/color.dart';
import 'package:dartmission/src/ui/widgets/common/space_button.dart';
import 'package:dartmission/src/ui/widgets/common/spaceman.dart';
import 'package:flutter/material.dart';

class FailedDialog extends StatelessWidget {
  const FailedDialog({
    Key? key,
    required this.onRestart,
  }) : super(key: key);

  final VoidCallback onRestart;

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
                SpaceButton(
                  image: Assets.images.svg.exitBtn,
                  height: isMobile ? 40 : 75,
                  width: isMobile ? 24 : 75,
                  color: aqua,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const InitialScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: isMobile ? screenWidth / 30 : screenWidth / 30,
                ),
                SpaceButton(
                  image: Assets.images.svg.restartBtn,
                  color: orange,
                  height: isMobile ? 40 : 75,
                  width: isMobile ? 24 : 75,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRestart.call();
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment(
                Alignment.centerRight.x - 0.25,
                Alignment.center.y,
              ),
              child: const Spaceman(
                animation: 'floating',
                height: 150,
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
