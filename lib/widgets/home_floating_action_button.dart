import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ohteepee/screens/camera.dart';
import 'package:ohteepee/screens/manual.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Icon(Icons.add),
      children: <SpeedDialChild>[
        SpeedDialChild(
          child: Icon(Icons.camera_alt),
          label: 'Scan QR',
          onTap: () => _openModal(context, Camera())
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          label: 'Manual Input',
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
