import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Question {
  late String id;
  late String interrogation;
  late String reponse1;
  String? reponse2;
  String? reponse3;
  late String reponseJuste;
  bool? questionValide;

  Question({
    required this.id,
    required this.interrogation,
    required this.reponse1,
    this.reponse2,
    this.reponse3,
    required this.reponseJuste,
    this.questionValide,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      interrogation: json['attributes']['Interrogation'],
      reponse1: json['attributes']['Reponse1'],
      reponse2: json['attributes']['Reponse2'],
      reponse3: json['attributes']['Reponse3'],
      reponseJuste: json['attributes']['ReponseJuste'],
      questionValide: json['attributes']['QuestionValide'],
    );
  }
}
//----------------------------CALL API---------------------------------//
Future<List<Question>> fetchQuestion() async {
  final response = await http
      .get(Uri.parse(
      'http://localhost:1337/api/questionnaires'));
      if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
  return jsonResponse.map((job) => Question.fromJson(job)).toList();
} else {
  throw Exception('Failed to load album');
  }
}

class PageQuestions extends StatefulWidget {
  const PageQuestions({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PageQuestions> createState() => _PageQuestions();

}


  class _PageQuestions extends State<PageQuestions>{
  Future<List<Question>>? question;

  @override
  void initState() {
    super.initState();
    question = fetchQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,

        child: FutureBuilder<List<Question>>(
          future: question,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return SizedBox(
                    height: 100,
                    child: Text(
                        snapshot.data![index].interrogation
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}