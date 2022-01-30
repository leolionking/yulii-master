import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'uploaded_file.freezed.dart';
part 'uploaded_file.g.dart';

enum FileType {
  image,
  video,
}

class _FileTypeUtils {
  static String fileTypeToString(FileType fileType) {
    switch (fileType) {
      case FileType.image:
        return "image";
      case FileType.video:
        return "video";
    }
    return null;
  }

  static FileType stringToFileType(String value) {
    switch (value) {
      case "image":
        return FileType.image;
      case "video":
        return FileType.video;
    }
    return null;
  }
}

@freezed
abstract class UploadedFile with _$UploadedFile {
  factory UploadedFile({
    @required
        String filePath,
    @required
        String downloadUrl,
    @JsonKey(
      fromJson: _FileTypeUtils.stringToFileType,
      toJson: _FileTypeUtils.fileTypeToString,
    )
    @Default(FileType.image)
    @nullable
        FileType fileType,
    @nullable
        String authorId,
  }) = _UploadedFile;

  factory UploadedFile.fromJson(Map<String, dynamic> json) =>
      _$UploadedFileFromJson(json);
}
