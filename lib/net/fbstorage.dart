import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:istart/net/database.dart';

String ProfileImageUrl = '';
String CoverImageUrl = '';

class FbaseStorage {
  Future uploadProfileImage(XFile image) async {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(image.path).pathSegments.last}")
        .putFile(File(image.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        ProfileImageUrl = value;
        print(value);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future uploadCoverImage(XFile image) async {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Users/${Uri.file(image.path).pathSegments.last}")
        .putFile(File(image.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CoverImageUrl = value;
        print(value);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future uploadPostimage(XFile Postimage, String datetime, String text) async {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Posts/${Uri.file(Postimage.path).pathSegments.last}")
        .putFile(File(Postimage.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        DatabaseService()
            .CreatePost(datetime: datetime, text: text, postimage: value);
      }).catchError((error) {});
    }).catchError((error) {});
  }
}
