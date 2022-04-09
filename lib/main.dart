
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:project/views/loginview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomePage(),
    ));
      

}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text("home page")),
      body: FutureBuilder(
        future:  Firebase.initializeApp(
        ),
        builder: ((context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
            print(FirebaseAuth.instance.currentUser);
            return const Center(child: Text("done"));
        
          default:
              return const Center(child: Text("Loading..."));
        }
      } ))
    );
  }
}