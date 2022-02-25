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

    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.2),
      // scrollable: false,
      // actionsPadding: const EdgeInsets.only(bottom: 40),
      contentPadding: const EdgeInsets.fromLTRB(48, 12, 48, 48),

      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Greate!',
              style: Theme.of(context).textTheme.headline2!.apply(
                    color: Colors.white,
                  ),
            ),
            Text(
              'You have successfully \nCompleted the mission!',
              style: Theme.of(context).textTheme.headline5!.apply(
                    color: Colors.white,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: 150,
                  height: 150,
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
