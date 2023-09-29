import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_test/details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://jsonplaceholder.typicode.com/users";

  Future<List> fetchUsers() async {
    print('==============================');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception("Failed to load");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder<List>(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(data: snapshot.data![i]),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text("name: ${snapshot.data![i]["username"]}"),
                          subtitle: Text(
                              "email: ${snapshot.data![i]["email"]}"),
                          leading: const Icon(Icons.person),
                        ),
                      );
                    });
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Failed to load data"));
              }
            }

            return const Center(child: Text("Failed to load the data"));
          }),
    );
  }
}

/*ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text("name: ${user[i]["username"]}"),
                  subtitle: Text("geo: ${user[i]["address"]["geo"]["lat"]}"),
                  leading: const Icon(Icons.person),
                );
              }),*/