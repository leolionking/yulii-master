// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UploadedFile _$_$_UploadedFileFromJson(Map<String, dynamic> json) {
  return _$_UploadedFile(
    filePath: json['filePath'] as String,
    downloadUrl: json['downloadUrl'] as String,
    fileType: _FileTypeUtils.stringToFileType(json['fileType'] as String),
    authorId: json['authorId'] as String,
  );
}

Map<String, dynamic> _$_$_UploadedFileToJson(_$_UploadedFile instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'downloadUrl': instance.downloadUrl,
      'fileType': _FileTypeUtils.fileTypeToString(instance.fileType),
      'authorId': instance.authorId,
    };
