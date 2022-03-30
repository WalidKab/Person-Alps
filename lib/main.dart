// import 'package:flutter/material.dart';
// import 'package:personalps/accueil.dart';
// import 'package:personalps/sign_in/sign_in_page.dart';
// import 'package:provider/provider.dart';
// import 'models/user.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => UserManager(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String login = "";
//   String password = "";
//   final _formKey = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text("Login :"),
//               TextFormField(
//                 onChanged: (text){
//                   login = text;
//                 },
//                 // The validator receives the text that the user has entered.
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//               ),
//               const Text("Password :"),
//               TextFormField(
//                 onChanged: (text){
//                   password = text;
//                 },
//                 // The validator receives the text that the user has entered.
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//
//                   if (_formKey.currentState!.validate()) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Accueil()),
//                     );
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //   const SnackBar(content: Text('Processing Data')),
//                     // );
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:personalps/accueil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(

        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Person Alps',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accueil()),
                    );
                    //if (_formKey.currentState!.validate()) {

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );
                    //}
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
