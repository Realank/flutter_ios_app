import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

class ImagePage extends StatelessWidget {
  final Uint8List image;
  ImagePage(this.image);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: CupertinoColors.lightBackgroundGray,
            child: Image.memory(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
