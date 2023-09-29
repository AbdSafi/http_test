import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
///
class _MyHomePageState extends State<MyHomePage> {
  String url = "https://jsonplaceholder.typicode.com/users";

  bool loading = false;
  List user = [];

  requestAPI() async {
    print('==============================');
    loading = true;
    setState(() {});
    var request = await http.get(Uri.parse(url));
    var response = jsonDecode(request.body);
    user.addAll(response);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    requestAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text("name: ${user[i]["username"]}"),
                  subtitle: Text("geo: ${user[i]["address"]["geo"]["lat"]}"),
                  leading: const Icon(Icons.person),
                );
              }),
    );
  }
}
