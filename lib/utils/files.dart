import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(File image, String path) async {
  final storage = FirebaseStorage.instance;

  final ref = storage.ref().child(path);
  await ref.putFile(image);
  return await ref.getDownloadURL();
}
