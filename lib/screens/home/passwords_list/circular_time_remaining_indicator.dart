import 'package:flutter/material.dart';

class CircularTimeRemainingIndicator extends StatelessWidget {
  final int second;
  final int period;

  CircularTimeRemainingIndicator({
    @required this.second,
    @required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0),
      children: [
        CircularProgressIndicator(
          value: 1 - second % period / period,
        ),
        Text((period - second % period).toString()),
      ],
    );
  }
}
