import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/cards/Postcar.dart';
import 'package:project/cards/nopostyet.dart';
import 'package:project/views/mainpage.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

var post_lists;
var user = FirebaseAuth.instance.currentUser;
var uid = user?.uid;
var l;
List<Widget> posts = [];

class _ProfileSectionState extends State<ProfileSection> {
  void create_list(var l) {
    posts = [];
    for (int i = 0; i < l.data().length; i++) {
      posts.add(Postcard(i: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 30, bottom: 30),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(200))),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(200)),
                        child: Image.network(
                          a['Profile Picture'],
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
                    Text(a['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        a['bio'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        a['year'].toString(),
                        style: const TextStyle(fontSize: 15),
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
          padding: EdgeInsets.only(top: 20.0, bottom: 20, left: 30, right: 20),
          child: Text("Posts", style: TextStyle(fontSize: 30)),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('PostsUsers')
                .doc(uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                l = snapshot.data;
                if (l.data() == null) {
                  return Nopostyet();
                }
                create_list(l);
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
}
