import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//-------------------------UNSPLASH IMAGE---------------------------------//
class Ressources {
  late int id;
  late String title;
  String? image;
  late String lien;
  late String description;
  String? createdAt; //Optional

  Ressources({
    required this.id,
    required this.title,
    this.image,
    required this.lien,
    required this.description,
    this.createdAt,
  });

  factory Ressources.fromJson(Map<String, dynamic> json) {
    return Ressources(
      id: json['id'],
      title: json['attributes']['title'],
      image: json['attributes']['image'],
      lien: json['attributes']['lien'],
      description: json['attributes']['description'],
      createdAt: json['attributes']['createdAt'],
    );
  }
}


//----------------------------CALL API---------------------------------//
Future<List<Ressources>> fetchRessources() async {
  final response = await http
      .get(Uri.parse(
      'https://personalps.herokuapp.com/api/ressources'));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    List listData = jsonResponse['data'];
    return listData.map((job) => Ressources.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}



class RessourcePage extends StatefulWidget {
  const RessourcePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RessourcePage> createState() => _RessourcePageState();

}


class _RessourcePageState extends State<RessourcePage> {

  Future<List<Ressources>>? ressources;

  @override
  void initState() {
    super.initState();
    ressources = fetchRessources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Ressources>>(
            future: ressources,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          ),
                        itemBuilder: (BuildContext context, int i) {
                          return Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey)
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  Flex(
                                        direction: Axis.vertical,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [ 
                                            Text(
                                              snapshot.data![i].title,
                                            ),
                                            Image.network(
                                                snapshot.data![i].image!,
                                                fit: BoxFit.cover,
                                            ),
                                            Text(
                                              snapshot.data![i].description,
                                            ),
                                            Text(
                                              snapshot.data![i].lien,
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Color.fromARGB(255, 3, 163, 163)),
                                            ),]
                                      ),
                                    ),
                                  ),
                              );
                        }
                    )
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Text('no data');
              }
            }
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
