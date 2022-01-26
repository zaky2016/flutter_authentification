import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentification/models/User.dart';
import 'package:flutter_authentification/services/routs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  bool _isLogedin = false;
  late User _user;
  late String _token;
  // ignore: prefer_const_constructors
  final storage = new FlutterSecureStorage();

  bool get authenticated => _isLogedin;
  User get user => _user;

  void login(Map cerdantials) async {
    // ignore: avoid_print
    print(cerdantials);

    try {
      Dio.Response response =
          await win().post('/sanctum/token', data: cerdantials);
      // ignore: avoid_print
      print(response.data.toString());

      String token = response.data.toString();
      trytoken(token);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void trytoken(String token) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await win().get(
          '/user',
          options: Dio.Options(headers: {"Authorization": "Bearer $token"}),
        );
        _isLogedin = true;
        _user = User.fromJson(response.data);
        _token = token;
        savetoken(token);
        notifyListeners();
        // ignore: avoid_print
        print(_user);
      } catch (e) {
        print(e);
      }
    }
  }

  void savetoken(String token) async {
    await storage.write(key: "token", value: token);
    print("token saved form auth : " + token);
  }

  void logout() async {
    _isLogedin = false;
    try {
      Dio.Response response = await win().get('/user/revoke',
        options: Dio.Options(headers: {"Authorization": "Bearer $_token"}),
      );
      print(response.data.toString());
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void cleanup() async {
    this._user.email = " ";
    this._isLogedin = false;
    this._token = "";
    await storage.delete(key: 'token');
  }
}
