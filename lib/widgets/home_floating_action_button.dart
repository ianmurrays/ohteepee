import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../screens/camera.dart';
import '../screens/manual.dart';

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
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => Camera(), fullscreenDialog: true);

    SystemChrome.setEnabledSystemUIOverlays([]);
    Navigator.of(context).push(route).then((value) {
      SystemChrome.setEnabledSystemUIOverlays([
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ]);
    });
  }

  void _openManual(BuildContext context) {
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => Manual(), fullscreenDialog: true);

    Navigator.of(context).push(route);
  }
}
