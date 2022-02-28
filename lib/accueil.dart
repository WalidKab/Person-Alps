
import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {

  Accueil({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("COUCOU"),
      ),
    );
  }
}