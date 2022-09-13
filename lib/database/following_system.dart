import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/mainpagesections/profilepage.dart';


check_if_following(String id) async {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var a = await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection('Followings')
      .doc('Following')
      .get();

  bool flag = true;

  if (a.data() == null) {
    isfollowed = false;
    return;
  }
  int? len = a.data()?.length;

  int i;

  for (i = 0; i < len!; i++) {
    if (a.data()![i.toString()] == id) {
      print("here");
      isfollowed = true;
      follow = "Following";
      print(follow);
      flag = false;
      break;
    }
  }

  if (flag) {
    isfollowed = false;
    follow = "Follow";
  }
}

create_followings(String id) async {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var a = await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection('Followings')
      .doc('Following')
      .get();
  int? len = a.data()?.length;

  len ??= 0;

  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Followings')
      .doc('Following')
      .set({
    len.toString(): id,
  }, SetOptions(merge: true));
}
