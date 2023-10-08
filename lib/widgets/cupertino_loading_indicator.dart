import 'package:flutter/cupertino.dart';

class CupertinoLoadingIndictor extends StatelessWidget {
  final String? text;

  CupertinoLoadingIndictor({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          color: CupertinoColors.secondaryLabel,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(),
        SizedBox(width: 8.0),
        Text(
          text ?? '',
          style: style,
        ),
      ],
    );
  }
}
