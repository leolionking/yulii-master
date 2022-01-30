import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:yulli/abstracts/disposable.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/uploaded_file.dart';

class FileStorageService implements Disposable {
  final MyLogger _logger = MyLogger('FileStorageService');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = Uuid();

  Future<UploadedFile> upload(File file) async {
    _logger.d('uploading...');
    final fileExt = _getFileExtension(file.path);
    final filePath = "images/${_uuid.v1()}$fileExt";

    final UploadTask uploadTask =
        _storage.ref().child(filePath).putFile(file);

    try {
      final snapshot = await uploadTask.whenComplete(() {});
      String location =
          await snapshot.ref.getDownloadURL();

      _logger.d('uploaded $location');

      return UploadedFile(
        filePath: filePath,
        downloadUrl: location,
      );
    } catch (e) {
      throw e;
    }
  }

  String _getFileExtension(String path) {
    final lastPointIndex = path.lastIndexOf('.');

    return lastPointIndex != -1 ? path.substring(lastPointIndex) : ".jpg";
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
