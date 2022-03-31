import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

class Question {
  late int id;
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
      'https://personalps.herokuapp.com/api/questions'));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List listData = jsonResponse['data'];
    return listData.map((job) => Question.fromJson(job)).toList();
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
        appBar:  AppBar(
          title: const Text('Questionnaire'),
        ),
        body:
        FutureBuilder<List<Question>>(
          future: question,
          builder: (context, snapshot){
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(padding: const EdgeInsets.all(30),
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                              'Ce questionnaire à pour objectif de définir votre niveau dans plusieurs savoir être. Soyez le plus honnête et sincère possible. Sinon l’intérêt est faible.'),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            height: 1,
                            thickness: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ...snapshot.data!.map((element) {
                            return QuestionWidget(question: element,);
                          }).toList(),
                          const Text('Question 1/10',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                          const SizedBox(height: 20,),
                          LinearPercentIndicator(
                            lineHeight: 15,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue),
                            ),
                            onPressed: () {},
                            child: Text('suivant'),
                          )
                        ]
                    ),

                  ),
                );
              }else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
           },
        ),
        );


  }
}

class QuestionWidget extends StatefulWidget {

  const QuestionWidget({required this.question, Key? key}) : super(key: key);
  final Question question;
  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {

  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text( 'Question ${widget.question.id}' , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
        const SizedBox(
          height: 15,
        ),
        Text(widget.question.interrogation),
        const SizedBox(
          height: 15,
        ),
        RadioListTile(title: Text(widget.question.reponse1),value: 1, groupValue: val, onChanged:(value){
          setState(() {
            val= value.hashCode;
          });
        } ),
        RadioListTile(title: Text(widget.question.reponse2!),value: 2, groupValue: val, onChanged:(value){
          setState(() {
            val= value.hashCode;
          });
        } ),
        RadioListTile(title: Text(widget.question.reponse3!),value: 3, groupValue: val, onChanged:(value){
          setState(() {
            val= value.hashCode;
          });
        } ),
        RadioListTile(title: Text(widget.question.reponseJuste),value: 4, groupValue: val, onChanged:(value){
          setState(() {
            val= value.hashCode;
          });
        } ),
        const SizedBox(
          height: 30,
        ),],
    );
  }
}