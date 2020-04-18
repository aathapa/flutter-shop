import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({@required this.child, @required this.value});

  final Widget child;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(
                minHeight: 16,
                minWidth: 16,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ))
      ],
    );
  }
}
