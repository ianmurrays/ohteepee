import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Code'),
      ),
      body: Center(child: Text('Camera')),
    );
  }
}
