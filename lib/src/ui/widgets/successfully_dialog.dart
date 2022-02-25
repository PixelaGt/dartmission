import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/ui/screens/initial_screen.dart';
import 'package:flutter/material.dart';

class SuccessfullyDialog extends StatefulWidget {
  const SuccessfullyDialog({Key? key}) : super(key: key);

  @override
  State createState() => _SuccessfullyDialogState();
}

class _SuccessfullyDialogState extends State<SuccessfullyDialog> {
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
                  child: Assets.images.svg.newMissionBtn.svg(
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
