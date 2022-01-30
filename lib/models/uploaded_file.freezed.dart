// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'uploaded_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
UploadedFile _$UploadedFileFromJson(Map<String, dynamic> json) {
  return _UploadedFile.fromJson(json);
}

/// @nodoc
class _$UploadedFileTearOff {
  const _$UploadedFileTearOff();

// ignore: unused_element
  _UploadedFile call(
      {@required
          String filePath,
      @required
          String downloadUrl,
      @JsonKey(
          fromJson: _FileTypeUtils.stringToFileType,
          toJson: _FileTypeUtils.fileTypeToString)
      @nullable
          FileType fileType = FileType.image,
      @nullable
          String authorId}) {
    return _UploadedFile(
      filePath: filePath,
      downloadUrl: downloadUrl,
      fileType: fileType,
      authorId: authorId,
    );
  }

// ignore: unused_element
  UploadedFile fromJson(Map<String, Object> json) {
    return UploadedFile.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $UploadedFile = _$UploadedFileTearOff();

/// @nodoc
mixin _$UploadedFile {
  String get filePath;
  String get downloadUrl;
  @JsonKey(
      fromJson: _FileTypeUtils.stringToFileType,
      toJson: _FileTypeUtils.fileTypeToString)
  @nullable
  FileType get fileType;
  @nullable
  String get authorId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $UploadedFileCopyWith<UploadedFile> get copyWith;
}

/// @nodoc
abstract class $UploadedFileCopyWith<$Res> {
  factory $UploadedFileCopyWith(
          UploadedFile value, $Res Function(UploadedFile) then) =
      _$UploadedFileCopyWithImpl<$Res>;
  $Res call(
      {String filePath,
      String downloadUrl,
      @JsonKey(
          fromJson: _FileTypeUtils.stringToFileType,
          toJson: _FileTypeUtils.fileTypeToString)
      @nullable
          FileType fileType,
      @nullable
          String authorId});
}

/// @nodoc
class _$UploadedFileCopyWithImpl<$Res> implements $UploadedFileCopyWith<$Res> {
  _$UploadedFileCopyWithImpl(this._value, this._then);

  final UploadedFile _value;
  // ignore: unused_field
  final $Res Function(UploadedFile) _then;

  @override
  $Res call({
    Object filePath = freezed,
    Object downloadUrl = freezed,
    Object fileType = freezed,
    Object authorId = freezed,
  }) {
    return _then(_value.copyWith(
      filePath: filePath == freezed ? _value.filePath : filePath as String,
      downloadUrl:
          downloadUrl == freezed ? _value.downloadUrl : downloadUrl as String,
      fileType: fileType == freezed ? _value.fileType : fileType as FileType,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
    ));
  }
}

/// @nodoc
abstract class _$UploadedFileCopyWith<$Res>
    implements $UploadedFileCopyWith<$Res> {
  factory _$UploadedFileCopyWith(
          _UploadedFile value, $Res Function(_UploadedFile) then) =
      __$UploadedFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String filePath,
      String downloadUrl,
      @JsonKey(
          fromJson: _FileTypeUtils.stringToFileType,
          toJson: _FileTypeUtils.fileTypeToString)
      @nullable
          FileType fileType,
      @nullable
          String authorId});
}

/// @nodoc
class __$UploadedFileCopyWithImpl<$Res> extends _$UploadedFileCopyWithImpl<$Res>
    implements _$UploadedFileCopyWith<$Res> {
  __$UploadedFileCopyWithImpl(
      _UploadedFile _value, $Res Function(_UploadedFile) _then)
      : super(_value, (v) => _then(v as _UploadedFile));

  @override
  _UploadedFile get _value => super._value as _UploadedFile;

  @override
  $Res call({
    Object filePath = freezed,
    Object downloadUrl = freezed,
    Object fileType = freezed,
    Object authorId = freezed,
  }) {
    return _then(_UploadedFile(
      filePath: filePath == freezed ? _value.filePath : filePath as String,
      downloadUrl:
          downloadUrl == freezed ? _value.downloadUrl : downloadUrl as String,
      fileType: fileType == freezed ? _value.fileType : fileType as FileType,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UploadedFile with DiagnosticableTreeMixin implements _UploadedFile {
  _$_UploadedFile(
      {@required
          this.filePath,
      @required
          this.downloadUrl,
      @JsonKey(
          fromJson: _FileTypeUtils.stringToFileType,
          toJson: _FileTypeUtils.fileTypeToString)
      @nullable
          this.fileType = FileType.image,
      @nullable
          this.authorId})
      : assert(filePath != null),
        assert(downloadUrl != null);

  factory _$_UploadedFile.fromJson(Map<String, dynamic> json) =>
      _$_$_UploadedFileFromJson(json);

  @override
  final String filePath;
  @override
  final String downloadUrl;
  @override
  @JsonKey(
      fromJson: _FileTypeUtils.stringToFileType,
      toJson: _FileTypeUtils.fileTypeToString)
  @nullable
  final FileType fileType;
  @override
  @nullable
  final String authorId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UploadedFile(filePath: $filePath, downloadUrl: $downloadUrl, fileType: $fileType, authorId: $authorId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UploadedFile'))
      ..add(DiagnosticsProperty('filePath', filePath))
      ..add(DiagnosticsProperty('downloadUrl', downloadUrl))
      ..add(DiagnosticsProperty('fileType', fileType))
      ..add(DiagnosticsProperty('authorId', authorId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UploadedFile &&
            (identical(other.filePath, filePath) ||
                const DeepCollectionEquality()
                    .equals(other.filePath, filePath)) &&
            (identical(other.downloadUrl, downloadUrl) ||
                const DeepCollectionEquality()
                    .equals(other.downloadUrl, downloadUrl)) &&
            (identical(other.fileType, fileType) ||
                const DeepCollectionEquality()
                    .equals(other.fileType, fileType)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(filePath) ^
      const DeepCollectionEquality().hash(downloadUrl) ^
      const DeepCollectionEquality().hash(fileType) ^
      const DeepCollectionEquality().hash(authorId);

  @JsonKey(ignore: true)
  @override
  _$UploadedFileCopyWith<_UploadedFile> get copyWith =>
      __$UploadedFileCopyWithImpl<_UploadedFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UploadedFileToJson(this);
  }
}

abstract class _UploadedFile implements UploadedFile {
  factory _UploadedFile(
      {@required
          String filePath,
      @required
          String downloadUrl,
      @JsonKey(
          fromJson: _FileTypeUtils.stringToFileType,
          toJson: _FileTypeUtils.fileTypeToString)
      @nullable
          FileType fileType,
      @nullable
          String authorId}) = _$_UploadedFile;

  factory _UploadedFile.fromJson(Map<String, dynamic> json) =
      _$_UploadedFile.fromJson;

  @override
  String get filePath;
  @override
  String get downloadUrl;
  @override
  @JsonKey(
      fromJson: _FileTypeUtils.stringToFileType,
      toJson: _FileTypeUtils.fileTypeToString)
  @nullable
  FileType get fileType;
  @override
  @nullable
  String get authorId;
  @override
  @JsonKey(ignore: true)
  _$UploadedFileCopyWith<_UploadedFile> get copyWith;
}
