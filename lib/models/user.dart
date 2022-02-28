import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserManager extends ChangeNotifier {

  bool isConnected = false;

  User? user;

  logging(String login, String password) async {

    var response = await http.post(
        Uri.parse('http://localhost:1337/api/auth/local'), body: {'identifier': login, 'password': password});

    print(response.body);
  }
}


class User {

  User({
    required this.login,
    required this.password
  });

  String login;
  String password;

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     login: json['user']['login'],
  //     password: json['user']['password'],
  //   );
  // }
}