import 'package:dartmission/src/ui/screens/level_screen.dart';
import 'package:dartmission/src/ui/themes/theme.dart';
import 'package:flutter/material.dart';

class DartmissionApp extends StatefulWidget {
  const DartmissionApp({Key? key}) : super(key: key);

  @override
  State<DartmissionApp> createState() => _DartmissionAppState();
}

class _DartmissionAppState extends State<DartmissionApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: dartMissionTheme,
      //  debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Color(0xFF331076),
        body: SafeArea(child: LevelScreen()),
      ),
    );
  }
}
