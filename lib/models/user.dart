import 'dart:convert';

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
      var data = json.decode(response.body);
      await prefs.setString('user', response.body);
      user = User.fromJson(data);
      await prefs.setString('token', data['jwt']);
      notifyListeners();
    } else {
      isConnected = false;
      notifyListeners();
    }
  }
}

class User {
  String login;
  String email;
  String token;
  //String promotion;
  //String expedition;

  User({
    required this.login,
    required this.email,
    required this.token,
    //required this.promotion,
    //required this.expedition,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['user']['username'],
      email: json['user']['email'],
      //promotion: json['user']['promotion'],
      //expedition: json['user']['expedition'],
      token: json['jwt'],
    );
  }
}
