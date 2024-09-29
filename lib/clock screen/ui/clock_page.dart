import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Artboard? _riveArtboard;
  late var file;
  late var artboard;
  late var controller;
  late var _amountInputhr;
  late var _amountInputmin;
  late var _amountInputsec;

  Future<void> _load() async {
    file = await RiveFile.asset('assets/clock_clock.riv');
    artboard = file.mainArtboard;
    controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    artboard.addController(controller!);

    _amountInputhr = controller.findInput<double>('hr');
    _amountInputmin = controller.findInput<double>('min');
    _amountInputsec = controller.findInput<double>('sec');
    _setTime();

    setState(() => _riveArtboard = artboard);
  }

  Future<void> _setTime() async {
    DateTime now = DateTime.now();
    _amountInputhr?.value = now.hour.toDouble();
    _amountInputmin?.value = now.minute.toDouble();
    _amountInputsec?.value = now.second.toDouble();
  }

  @override
  void initState() {
    _load();

    Timer.periodic(const Duration(seconds: 1), (_) => _setTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            height: double.infinity,
            child: _riveArtboard == null
                ? Container()
                : Rive(artboard: _riveArtboard!),
          ),
        ));
  }
}
