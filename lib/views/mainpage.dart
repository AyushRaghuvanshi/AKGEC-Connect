import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/cards/nopostyet.dart';
import 'package:project/mainpagesections/firstpage.dart';
import 'package:project/mainpagesections/msgpage.dart';

import 'package:project/mainpagesections/profilesection.dart';
import 'package:project/mainpagesections/postsection.dart';

import 'package:project/views/popup.dart';

import '../mainpagesections/Searchuser.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum MenuAction { logout }

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  var a;

  bool k = false;
  String url =
      "https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg";

  final String? user = FirebaseAuth.instance.currentUser?.uid;
  var future;

  @override
  void initState() {
    future =
        FirebaseFirestore.instance.collection('Users').doc(user).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List sections = [
      const FirstPage(),
      const Postsection(),
      const Searchuser(),
      const MsgPage(),
    ];
    try {
      sections = [
        const FirstPage(),
        const Postsection(),
        const Searchuser(),
        const MsgPage(),
        ProfileSection(
          profilepicture: a["Profile Picture"],
          name: a["name"],
          bio: a["bio"],
          year: a["year"],
        )
      ];
    } catch (e) {}

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
        child: SingleChildScrollView(child: sections[_selectedIndex]),
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
            icon: Icon(Icons.search_rounded, color: Colors.black),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded, color: Colors.black),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: StreamBuilder(
                  stream: future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        a = snapshot.data;
                        return Image.network(
                          a["Profile Picture"],
                          height: 30,
                          width: 30,
                        );
                      }
                    }
                    return Image.network(
                      url,
                      height: 30,
                      width: 30,
                    );
                  },
                )),
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
