import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference cr = FirebaseFirestore.instance.collection('Users');

Future<void> adduser(String uid, String name, String bio, DateTime? dob,
    String sno, int gender, int branch, int year, String ppurl) {
  final user = {
    'name': name,
    'bio': bio,
    'gender': gender,
    'dob': dob,
    'branch': branch,
    'year': year,
    'Profile Picture': ppurl
  };
  return FirebaseFirestore.instance.collection('Users').doc(uid).set(user);
}

void addpost(String post, String? uid) async {
  var a =
      await FirebaseFirestore.instance.collection("PostsUsers").doc(uid).get();
  int? len = a.data()?.length;
  var l = await FirebaseFirestore.instance.collection('Users').doc(uid).get();

  len ??= 0;

  FirebaseFirestore.instance.collection('PostsUsers').doc(uid).set({
    len.toString(): {
      'data': post,
      'time': DateTime.now(),
      'pfc': l.data()!['Profile Picture'],
      'name': l.data()!['name']
    },
  }, SetOptions(merge: true));
}

fetch_post(String? uid) async {
  var a = FirebaseFirestore.instance.collection("PostsUsers").doc(uid).get();

  return a;
}

Future fetchuser(String uid) async {
  return await FirebaseFirestore.instance.collection('Users').doc(uid).get();
}
