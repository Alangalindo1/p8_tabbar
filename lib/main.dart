import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyappState();
}

//today  Topic: Flutter Image
class _MyappState extends State<MyApp> {
  File file = File('Users/luisintegan/Dowloads/image/icon.png');
  Uint8List? imageByteData;

  void _getImage() async {
    Uint8List data = (await rootBundle.load('avatar.png')).buffer.asUint16List()
        as Uint8List;
    setState(() {
      print(data);
      imageByteData = data;
      @override
      void initState() {
        super.initState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fluter imagen",
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Image")),
        body: Container(
          child: Image.memory(imageByteData!, //imagen
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
              frameBuilder: (context, child, frame, loaded) {
            if (loaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }, errorBuilder: (context, exception, stackTrace) {
            return Center(
              child: Text("Somethimg Wrong"),
            );
          }),
        ),
      ),
    );
  }
}
