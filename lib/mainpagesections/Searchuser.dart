// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/cards/profilecard.dart';

import '../views/searchbar.dart';

class Searchuser extends StatefulWidget {
  const Searchuser({Key? key}) : super(key: key);

  @override
  State<Searchuser> createState() => _SearchuserState();
}

class _SearchuserState extends State<Searchuser> {
  String query = '';
  List user = [];
  List someuser = [];
  List<Widget> dmcards = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearch(),
        FutureBuilder(
          future: FirebaseFirestore.instance.collection("Users").get(),
          builder: (BuildContext context, AsyncSnapshot snapshots) {
            if (snapshots.hasData) {
              var l = snapshots.data;
              var uid = FirebaseAuth.instance.currentUser!.uid;
              user = (l.docs.map((doc) {
                if (doc.id != uid) {
                  return {
                    'id': doc.id,
                    'profile': doc.data()['Profile Picture'],
                    'name': doc.data()['name']
                  };
                }
              })).toList();

              if (someuser.isEmpty) {
                someuser = user;
              }

              dmcards = [];
              for (int i = 0; i < someuser.length; i++) {
                if (someuser[i] != null) {
                  dmcards.add(profilecard(
                      name: someuser[i]['name'],
                      pic: someuser[i]['profile'],
                      id: someuser[i]['id']));
                }
              }

              return Column(
                children: dmcards,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        )
      ],
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Users',
        onChanged: searchname,
      );

  void searchname(String query) {
    log(query);
    final someuser = [];
    query.toLowerCase();
    for (int i = 0; i < user.length; i++) {
      if (user[i] == null) {
        continue;
      }
      final nameLower = user[i]["name"].toString().toLowerCase();
      if (nameLower.contains(query)) {
        someuser.add(user[i]);
      }
    }
    print(someuser.toString());
    setState(() {
      this.query = query;
      this.someuser = someuser;
    });
  }
}
