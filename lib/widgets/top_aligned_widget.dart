import 'package:flutter/cupertino.dart';

class TopAlignedWidget extends StatelessWidget {
  final Widget child;

  TopAlignedWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: 40.0,
          right: 8.0,
          bottom: 8.0,
          left: 8.0,
        ),
        child: child,
      ),
    );
  }
}
