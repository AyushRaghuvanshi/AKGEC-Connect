import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:project/cards/Postcar.dart';
import 'package:project/cards/nopostyet.dart';
import 'package:collection/collection.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final queue = PriorityQueue<Map>((a, b) {
    if (a['time'].compareTo(b['time']) == 1) {
      return 0;
    }
    return 1;
  });
  List people_you_follow = [];
  var uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            'Activity Feed',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(uid)
                .collection('Followings')
                .doc('Following')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var l = snapshot.data;
                if (l == null || l.data() == null || l.data().length == 0) {
                  return const Center(child: Nopostyet());
                }
                for (int i = 0; i < l.data().length; i++) {
                  people_you_follow.add(l.data()[i.toString()]);
                }
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('PostsUsers')
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var l = snapshot.data;
                        if (l == null) {
                          return const Center(child: Nopostyet());
                        }
                        for (var i in l.docs) {
                          for (var j in people_you_follow) {
                            if (i.id == j) {
                              for (int k = 0; k < i.data().length; k++) {
                                queue.add(i.data()[k.toString()]);
                              }
                            }
                          }
                        }
                        List<Widget> posts = [];
                        for (var i in queue.toList()) {
                          posts.add(Postcard(
                              post: i['data'],
                              profilepicture: i['pfc'],
                              name: i['name']));
                        }
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: posts,
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    });
              }
              return CircularProgressIndicator();
            }),
      ],
    );
  }
}
