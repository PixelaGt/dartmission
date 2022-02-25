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

    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.2),
      // scrollable: false,
      // actionsPadding: const EdgeInsets.only(bottom: 40),
      contentPadding: const EdgeInsets.fromLTRB(48, 12, 48, 48),
      // // insetPadding: isMobile
      // //     ? EdgeInsets.only(top: height * 0.12)
      // //     : const EdgeInsets.symmetric(horizontal: 24),
      // titlePadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed',
              style: Theme.of(context).textTheme.headline2!.apply(
                    color: Colors.orange,
                  ),
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
                    width: 75,
                    height: 75,
                  ),
                ),
                SizedBox(
                  width: screenWidth / 10,
                ),
                Container(
                  color: Colors.black,
                  width: 150,
                  height: 150,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
