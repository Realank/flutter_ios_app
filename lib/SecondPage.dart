import 'package:flutter/cupertino.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: ListView.builder(itemBuilder: (context, index) {
          return Text('cell $index');
        }));
  }
}
