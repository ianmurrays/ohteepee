import 'package:flutter/material.dart';
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
      children: <SpeedDialChild>[
        SpeedDialChild(
          child: Icon(Icons.camera_alt),
          label: 'Scan QR',
          labelStyle: TextStyle(color: Colors.white),
          labelBackgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () => _openModal(context, Camera())
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          label: 'Manual Input',
          labelStyle: TextStyle(color: Colors.white),
          labelBackgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () => _openModal(context, Manual())
        ),
      ],
    );
  }

  void _openModal(BuildContext context, Widget page) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: true
    );

    Navigator.of(context).push(route);
  }
}
