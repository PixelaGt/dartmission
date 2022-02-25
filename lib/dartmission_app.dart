import 'package:dartmission/src/ui/screens/initial_screen.dart';
import 'package:dartmission/src/ui/themes/theme.dart';
import 'package:flutter/material.dart';

class DartmissionApp extends StatelessWidget {
  const DartmissionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: dartMissionTheme,
      //  debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(child: InitialScreenView()),
      ),
    );
  }
}
