import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserManager extends ChangeNotifier {
  bool isConnected = false;

  User? user;

  UserManager() {
    test_token();
  }

  disconnect() {
    isConnected = false;
    notifyListeners();
  }

  test_token() async {
    var prefs = await SharedPreferences.getInstance();
    var tokenReturn = prefs.getString('token');
    if (tokenReturn != null) {
      isConnected = true;
      notifyListeners();
    } else {
      isConnected = false;
      notifyListeners();
    }
  }

  logging(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();

    var response = await http.post(
        Uri.parse('https://personalps.herokuapp.com/api/auth/local'),
        body: {"identifier": login, "password": password});
    if (response.statusCode == 200) {
      isConnected = true;
      await prefs.setString('token', "COUCOU");
      notifyListeners();
    } else {
      isConnected = false;
      notifyListeners();
    }
  }
}

class User {
  String login;
  //String password;
  String email;
  String token;

  User({
    required this.login,
    required this.email,
    required this.token,
    //password
  });

  /*  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['user']['username'],  
      //password: json['user']['password'],
      email: json['user']['email'],
      token: json['jwt'],
    );
  } */
}
