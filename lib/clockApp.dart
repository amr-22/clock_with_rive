import 'package:clock_with_rive/clock%20screen/ui/clock_page.dart';
import 'package:flutter/material.dart';

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClockPage(),
    );
  }
}
