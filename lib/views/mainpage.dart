
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/views/popup.dart';

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
        leading:  Image.asset("assets/akgec.png"
),
        title: const Text("AKGEC Connect"),
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
