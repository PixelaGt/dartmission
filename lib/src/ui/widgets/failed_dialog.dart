import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/initial_screen.dart';
import 'package:flutter/material.dart';

class FailedDialog extends StatefulWidget {
  const FailedDialog({Key? key}) : super(key: key);

  @override
  State createState() => _FailedDialogState();
}

class _FailedDialogState extends State<FailedDialog> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isMobile = screenWidth <= 960 || false;

    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.2),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const InitialScreenView(),
                      ),
                    );
                  },
                  child: Assets.images.svg.exitBtn.svg(
                    height: isMobile ? 30 : 75,
                    width: isMobile ? 24 : 75,
                  ),
                ),
                SizedBox(
                  width: isMobile ? screenWidth / 30 : screenWidth / 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Assets.images.svg.restartBtn.svg(
                    height: isMobile ? 30 : 75,
                    width: isMobile ? 24 : 75,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
