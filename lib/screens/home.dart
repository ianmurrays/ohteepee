import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ohteepee/widgets/home_floating_action_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oh Tee Pee'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => print('settings'),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => print('edit'),
          )
        ],
      ),
      floatingActionButton: HomeFloatingActionButton(),
      body: ListView(
        children: <Widget>[
          _randomTile(),
          _randomTile(),
          _randomTile(),
          _randomTile(),
          _randomTile(),
          _randomTile(),
        ],
      ),
    );
  }

  Widget _randomTile() {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle
        ),
        child: Center(
          child: Text(
            'G',
            style: TextStyle(fontSize: 25, color: Colors.white)
          )
        ),
      ),
      title: Text('Google'),
      subtitle: Text('email@gmail.com'),
      trailing: TOTPNumber(),
    );
  }
}

class TOTPNumber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TOTPNumberState();
  }
}

class TOTPNumberState extends State<TOTPNumber> {
  int _value = 0;
  String _calculatedValue = '000000';
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 5), _timerCallback);
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(this._calculatedValue, style: TextStyle(fontSize: 35));
  }

  void _timerCallback(Timer timer) {
    print('timer!!');
    setState(() {
      _value = Random().nextInt(1000000);

      _calculatedValue = _value.toString().padLeft(6, '0');
    });
  }
}
