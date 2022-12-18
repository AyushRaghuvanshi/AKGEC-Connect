import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/cards/Postcar.dart';
import 'package:project/cards/nopostyet.dart';
import 'package:project/database/following_system.dart';
import 'package:project/views/mainpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

var post_lists;
bool isfollowed = false;
String follow = "Follow", pfc = "";
var l, a;
List<Widget> posts = [];

class _ProfilePageState extends State<ProfilePage> {
  void create_list(var l) {
    posts = [];
    for (int i = 0; i < l.data().length; i++) {
      String post = l.data()[i.toString()]['data'];
      posts.add(Postcard(
        profilepicture: pfc,
        name: a.data()["name"],
        post: post,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var uid = widget.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset("assets/akgec.png"),
        title: const Text("AKGEC Connect"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                a = snapshot.data;
                if (a == null) {
                  return CircularProgressIndicator();
                }
                if (a.data() == null) {
                  return CircularProgressIndicator();
                }
                pfc = a.data()['Profile Picture'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 30, bottom: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(200))),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(200)),
                                    child: Image.network(
                                      a.data()['Profile Picture'],
                                      height: 125,
                                      width: 125,
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a.data()['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    a.data()['bio'],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    a.data()['year'].toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.black,
                                          onSurface: Colors.grey,
                                        ),
                                        onPressed: () {
                                          if (isfollowed == false) {
                                            create_followings(uid);
                                            setState(() {
                                              follow = "Following";
                                              isfollowed = true;
                                            });
                                          }
                                        },
                                        child: Text(follow),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        width: 350,
                        height: 2,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: const SizedBox(height: 2),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20, left: 30, right: 20),
                      child: Text("Posts", style: TextStyle(fontSize: 30)),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('PostsUsers')
                            .doc(uid)
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            l = snapshot.data;
                            if (l.data() == null || l == null) {
                              return Nopostyet();
                            } else {
                              create_list(l);
                            }
                            return Container(
                              height: 390,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: posts,
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })
                  ],
                );
              }

              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
