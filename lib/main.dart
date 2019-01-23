import 'package:flutter/cupertino.dart';
import 'SecondPage.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'ImagePage.dart';

void main() => runApp(new MyApp());

final globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(title: 'Flutter Demo', home: AppStructure());
  }
}

class AppStructure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text('Flutter Demo'),
            trailing: CupertinoButton(
              child: Icon(CupertinoIcons.right_chevron),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => SecondPage(), title: 'second page'),
                );
              },
              padding: EdgeInsets.zero,
            )),
        child: PageContent());
  }
}

class PageContent extends StatefulWidget {
  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  Duration duration;
  String selectedSegmentControl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    duration = Duration();
    selectedSegmentControl = 'first';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(PageContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void popUpActionSheet(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text('action sheet'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    print('action sheet action1');
                    Navigator.of(context).pop();
                  },
                  child: Text('action sheet action1')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    print('action sheet action2');
                    Navigator.of(context).pop();
                  },
                  child: Text('action sheet action2'))
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  print('cancel');
                  Navigator.of(context).pop();
                },
                child: Text('cancel')),
          );
        });
  }

  captureImage() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => ImagePage(pngBytes), title: 'image page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text(duration.toString()),
          Container(
            height: 180.0,
            color: CupertinoColors.activeGreen,
            padding: EdgeInsets.all(10.0),
            child: CupertinoTimerPicker(onTimerDurationChanged: (duration) {
              print(duration);
              this.duration = duration;
              setState(() {});
            }),
          ),
          SizedBox(
            width: double.infinity,
            child: CupertinoSegmentedControl(
                groupValue: selectedSegmentControl,
                children: {'first': Text('first'), 'second': Text('second')},
                onValueChanged: (value) {
                  print('changed to $value');
                  selectedSegmentControl = value;
                  setState(() {});
                }),
          ),
          CupertinoButton(
              child: Text('show Alert'),
              onPressed: () {
                popUpActionSheet(context);
              }),
          CupertinoButton(
              child: Text('Capture'),
              onPressed: () {
                captureImage();
              }),
          Container(
            color: CupertinoColors.destructiveRed,
            child: EditableText(
                controller: TextEditingController(text: 'input:'),
                focusNode: FocusNode(),
                style: TextStyle(),
                cursorColor: CupertinoColors.activeBlue),
          ),
          Expanded(
            child: RepaintBoundary(
              key: globalKey,
              child: ListView.builder(itemBuilder: (context, index) {
                if (index < 40) {
                  return Text('cell $index');
                } else {
                  return null;
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
