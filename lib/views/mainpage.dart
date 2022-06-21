import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/mainpagesections/firstpage.dart';
import 'package:project/mainpagesections/msgpage.dart';

import 'package:project/mainpagesections/profilesection.dart';
import 'package:project/mainpagesections/postsection.dart';

import 'package:project/views/popup.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum MenuAction { logout }
var a;

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool k = false;

  final String? user = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List sections = [
      const FirstPage(),
      const Postsection(),
      const MsgPage(),
      const ProfileSection()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset("assets/akgec.png"),
        title: const Text("AKGEC Connect"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldlogout = await showLogoutPop(context);
                  if (shouldlogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (route) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Logout ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.logout_rounded, color: Colors.black),
                    ],
                  ),
                  value: MenuAction.logout,
                )
              ];
            },
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  a = snapshot.data;

                  k = true;

                  return sections[_selectedIndex];
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, color: Colors.black),
            label: 'Posts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded, color: Colors.black),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: ConditionalBuilder(
              condition: k,
              builder: (context) => ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Image.network(
                    a['Profile Picture'],
                    height: 30,
                    width: 30,
                  )),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
