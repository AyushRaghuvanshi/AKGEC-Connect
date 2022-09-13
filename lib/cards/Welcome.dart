import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Users').doc(uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var l = snapshot.data;
            if (l == null || l.data() == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Text(
              'Hello!\n' + l.data()['name'],
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
