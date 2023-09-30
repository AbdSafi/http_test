import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_test/model/user.dart';
import 'package:http_test/notify.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://jsonplaceholder.typicode.com/users";

  Future<List<Users>> fetchUsers() async {
    print('==============================');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => Users.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load");
    }
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'notify') {
      String? title = message.notification!.title;
      String? body = message.notification!.body;
      String? img = message.data['img'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FetchNotify(title: title!, body: body!, img: img!)));
    }
  }

  fetchToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("=================================================");
    print("$fcmToken");
  }

  @override
  void initState() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    fetchToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder<List<Users>>(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final List<Users>? myUser = snapshot.data;
                return ListView.builder(
                    itemCount: myUser!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          /* Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(data: snapshot.data![i]),
                            ),
                          );*/
                        },
                        child: ListTile(
                          title: Text("name: ${myUser![i].name}"),
                          subtitle: Text(
                              "email: ${myUser[i].email}  || address: ${myUser[i].address.city}"),
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