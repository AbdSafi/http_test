import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://jsonplaceholder.typicode.com/users";

  List lstUser = [];

  getData() async {
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    lstUser.addAll(data);
    print('==============================');
    print(lstUser[0]);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemBuilder: (context, i) {
        return ListTile(
          title: Text("title"),
          subtitle: Text("subtitle"),
          leading: Icon(Icons.person),
        );
      }),
    );
  }
}
