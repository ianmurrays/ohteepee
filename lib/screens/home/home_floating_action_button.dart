import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../add_password.dart';
import '../camera.dart';

class HomeFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.remove,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      animationSpeed: 150,
      overlayOpacity: 0.95,
      children: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.camera_alt),
          label: 'Scan QR',
          labelStyle: const TextStyle(color: Colors.white),
          labelBackgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          onTap: () => _openCamera(
            context,
          ),
        ),
        SpeedDialChild(
            child: const Icon(Icons.edit),
            label: 'Manual Input',
            labelStyle: const TextStyle(color: Colors.white),
            labelBackgroundColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onTap: () => _openManual(context)),
      ],
    );
  }

  void _openCamera(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Navigator.of(context).pushNamed(Camera.route).then((value) {
      SystemChrome.setEnabledSystemUIOverlays([
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ]);
    });
  }

  void _openManual(BuildContext context) {
    Navigator.of(context).pushNamed(AddPassword.route);
  }
}
