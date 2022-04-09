


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/views/loginview.dart';
import 'package:project/views/registerview.dart';
import 'views/EmailVericationview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomePage(),
      routes: {
        '/login/':(context) => const LoginView(),
        '/register/':(context) => const RegisterView(),
        '/mainpage/':(context) => const MainPage(),
        
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:  Firebase.initializeApp(),
        builder: ((context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
            final user =FirebaseAuth.instance.currentUser;
            if(user==null){
              return const LoginView();
            }
            else{
            if( user.emailVerified){
              return const MainPage();
            }
            else {
              return const EmailVerification();
            }
          }
          default:
              return const CircularProgressIndicator();
        }
      } ))
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
enum MenuAction {logout}
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(onSelected: (value) async {
            switch(value){
              case MenuAction.logout:
                final shouldlogout = await showLogoutPop(context);
                if(shouldlogout){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
                }
                
            }
          },
          itemBuilder: (context){
            return [ PopupMenuItem<MenuAction>(
              
              
              child: Row(
              children: const [
                 
                 Padding(
                  padding:  EdgeInsets.all(0),
                  child:  Text("Logout ",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Icon(Icons.logout_rounded,color: Colors.black),
              ],
            ),
              value: MenuAction.logout,
            )
            ];
          },
          )

        ],
      ),
    );
  }
}

Future<bool> showLogoutPop(BuildContext context){
  return showDialog(context: context, 
  builder: (context){
   return  AlertDialog(
     title: const Text("Log out"),
     content: const Text("Are you sure to Log out?"),
    actions:  [
      TextButton(onPressed: () {
        Navigator.of(context).pop(false);
      }, child: const Text("Cancel")),
      TextButton(onPressed: () {
        Navigator.of(context).pop(true);
      }, child: const Text("Log out"))
    ],

   );
  }
  ).then((value) => value ?? false);
  
}