import 'package:flutter/material.dart';

class FetchNotify extends StatefulWidget {
  const FetchNotify(
      {super.key, required this.title, required this.body, required this.img});

  final String title;
  final String body;
  final String img;

  @override
  State<FetchNotify> createState() => _FetchNotifyState();
}

//
class _FetchNotifyState extends State<FetchNotify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Text(widget.body),
            SizedBox(
              height: 10,
            ),
            Image.network(
              widget.img,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
