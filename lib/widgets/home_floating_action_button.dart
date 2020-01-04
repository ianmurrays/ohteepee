import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
          onTap: () => print('camera')
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          label: 'Manual Input',
          onTap: () => _manualInputPressed(context)
        ),
      ],
    );
  }
}
