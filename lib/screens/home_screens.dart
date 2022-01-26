import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_authentification/models/User.dart';
import 'package:flutter_authentification/screens/login_screen.dart';
import 'package:flutter_authentification/services/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreeState createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage();

  void initState() {
    super.initState();
    readtoken();
  }

  void readtoken() async {
    try {
      // String value = await storage.read(key: "token");
      var allValues = await storage.read(key: "token");
      print("from home_screen : " + allValues.toString());
      Provider.of<Auth>(context, listen: false).trytoken(allValues.toString());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("not signed In or im i "),
      ),
      body: const Center(
        child: Text("home Screen"),
      ),
      drawer: Drawer(
        child: Consumer<Auth>(builder: (context, auth, child) {
          if (auth.authenticated) {
            return ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(auth.user.avatar),
                        radius: 30,
                      ),
                      SizedBox(height: 10),
                      Text(
                        auth.user.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        auth.user.email,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.blue[300]),
                ),
                ListTile(
                  title: const Text("logOut"),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logout();

                    Navigator.pop(context);
                  },
                )
              ],
            );
          } else {
            return ListView(
              children: [
                ListTile(
                    title: const Text("login"),
                    leading: const Icon(Icons.login),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    }),
              ],
            );
          }
        }),
      ),
    );
  }
}
