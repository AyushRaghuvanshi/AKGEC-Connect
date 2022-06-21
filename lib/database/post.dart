import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> uploadimage(String uid) async {
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  XFile? image;
  var perm = await Permission.photos.status;
  if (perm.isGranted) {
    image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var file = File(image.path);
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/profilepicture/' + uid)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return 'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';
    }
  } else {
    await Permission.photos.request();
    return 'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';
  }
}
