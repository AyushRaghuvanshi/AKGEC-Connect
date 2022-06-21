import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/database/sevices.dart';

class Postsection extends StatefulWidget {
  const Postsection({Key? key}) : super(key: key);
  @override
  State<Postsection> createState() => _PostsectionState();
}

late TextEditingController post;

class _PostsectionState extends State<Postsection> {
  @override
  void initState() {
    // TODO: implement initState
    post = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    post.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: 340,
              child: TextField(
                controller: post,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "What do you feel....",
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                onPressed: () {
                  String p = post.text;
                  addpost(p, FirebaseAuth.instance.currentUser?.uid);
                  setState(() {
                    post.text = "";
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      elevation: 20,
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      content: Text("Posted")));
                },
                child: const Text("Post")),
          )
        ],
      ),
    );
  }
}
