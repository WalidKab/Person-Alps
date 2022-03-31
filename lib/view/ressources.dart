import 'package:flutter/material.dart';
import 'package:personalps/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ressources extends StatelessWidget {
  const Ressources({required this.items});

  final List<String> items;
  static const title = 'Long List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
          leading: GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('token');
              context.read<UserManager>().disconnect();
            },
            child: Icon(Icons.logout),
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}
