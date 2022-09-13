import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project/cards/dmcard.dart';

class MsgPage extends StatefulWidget {
  const MsgPage({Key? key}) : super(key: key);

  @override
  State<MsgPage> createState() => _MsgPageState();
}

class _MsgPageState extends State<MsgPage> {
  List users = [];
  List<Widget> dmcards = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Users").get(),
      builder: (BuildContext context, AsyncSnapshot snapshots) {
        if (snapshots.hasData) {
          var l = snapshots.data;
          users = [];
          String uid = FirebaseAuth.instance.currentUser!.uid;
          users = (l.docs.map((doc) {
            if (doc.id != uid) {
              return {
                'id': doc.id,
                'profile': doc.data()['Profile Picture'],
                'name': doc.data()['name']
              };
            }
          })).toList();

          dmcards = [];
          for (int i = 0; i < users.length; i++) {
            if (users[i] != null) {
              dmcards.add(dmcard(
                  name: users[i]['name'],
                  pic: users[i]['profile'],
                  id: users[i]['id']));
            }
          }

          return Column(
            children: dmcards,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
