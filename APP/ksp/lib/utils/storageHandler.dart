import 'dart:io';
import 'dart:math' as Math;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  Future<String> uploadFile(File file) async {
    int rand = new Math.Random().nextInt(10000);
    String fileType = basename(file.path).split('.')[1];
    final StorageReference reference =
        FirebaseStorage.instance.ref().child("files/$rand.$fileType");
    final StorageUploadTask uploadTask = reference.putFile(file);
    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadUrl;
  }
}
