import 'package:flutter/material.dart';

class TestImage extends StatefulWidget {
  const TestImage({Key? key}) : super(key: key);

  @override
  _TestImageState createState() => _TestImageState();
}
//
class _TestImageState extends State<TestImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Image.asset("assets/images/3.png"),
      ),
    );
  }
}
