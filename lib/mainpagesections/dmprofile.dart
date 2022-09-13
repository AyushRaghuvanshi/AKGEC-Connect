import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/cards/Reciever.dart';
import 'package:project/cards/Sender.dart';

import 'package:project/mainpagesections/profilesection.dart';

class dmprofile extends StatefulWidget {
  dmprofile({Key? key, required this.pic, required this.name, required this.id})
      : super(key: key);
  final String pic, name, id;
  @override
  State<dmprofile> createState() => _dmprofileState();
}

class _dmprofileState extends State<dmprofile> {
  late TextEditingController _msg;
  var uid = FirebaseAuth.instance.currentUser!.uid;

  List<String> templist = [];
  List<Widget> msgstream = [];
  bool istream = false;
  int msg = 0;
  String s = "ayush";

  @override
  void initState() {
    msg = 0;
    templist = [widget.id, uid];
    templist.sort();

    s = templist[0] + '-' + templist[1];
    _msg = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _msg.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(s);
    return Scaffold(
      appBar: AppBar(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Image.network(
            widget.pic,
          ),
        ),
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('MsgStream')
                            .doc(s)
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data.data();
                            if (data == null)
                              return Container(
                                height: 630,
                              );
                            msg = data.length;
                            print(data);
                            msgstream = [];

                            for (int i = 0; i < data.length; i++) {
                              if (data[i.toString()] != null) {
                                if (uid == data[i.toString()]['user']) {
                                  msgstream.add(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Sender(msg: data[i.toString()]['msg']),
                                      ],
                                    ),
                                  ));
                                } else {
                                  msgstream.add(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Reciever(
                                          msg: data[i.toString()]['msg'],
                                        ),
                                      ],
                                    ),
                                  ));
                                }
                              }
                            }
                            print(msgstream);
                            return SingleChildScrollView(
                              child: Container(
                                height: 630,
                                child: SingleChildScrollView(
                                    reverse: true,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: msgstream)),
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                  ]),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black))),
                    width: 300,
                    child: TextField(
                      controller: _msg,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration:
                          const InputDecoration(hintText: "Type Your Msg"),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_msg.text == '') {
                        return;
                      }
                      istream = true;
                      FirebaseFirestore.instance
                          .collection('MsgStream')
                          .doc(s)
                          .set({
                        msg.toString(): {
                          'time': DateTime.now().toIso8601String(),
                          'user': uid,
                          'msg': _msg.text
                        }
                      }, SetOptions(merge: true));
                      setState(() {
                        _msg.text = "";
                      });
                    },
                    child: const Icon(Icons.send_rounded))
              ],
            )
          ],
        ),
      ),
    );
  }
}
