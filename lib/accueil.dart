import '/view/ressources.dart';
import 'package:flutter/material.dart';
import 'package:personalps/pageQuestions.dart';
import 'package:personalps/view/ressources.dart';
import 'package:personalps/view/competence.dart';

class Accueil extends StatefulWidget {
  const Accueil({
    Key? key,
  }) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    RessourcePage(title: "Ressources"),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    SkillsPage(),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ressources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
