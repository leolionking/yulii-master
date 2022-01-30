import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/localizations.dart';

class FileUtils {
  final MyLogger _logger = MyLogger('FileUtils');
  final _imagePicker = ImagePicker();

  static const supportedImageExtensions = [
    'png',
    'jpg',
  ];

  static const supportedVideoExtensions = [
    'mp4',
  ];

  Future<File> pickFile({
    bool isVideo = false,
    ImageSource source = ImageSource.camera,
  }) async {
    assert(isVideo != null);
    assert(source != null);

    if (await Permission.camera.request().isGranted) {
      PickedFile pickedFile;

      try {
        if (isVideo) {
          pickedFile = await _imagePicker.getVideo(source: source);
        } else {
          pickedFile = await _imagePicker.getImage(source: source);
        }

        if (pickedFile != null) {
          return File(pickedFile.path);
        }
      } catch (e) {
        _logger.e(e, error: e);
      }
    }

    return null;
  }

  Future<AssetEntity> takePhotoOrVideo(BuildContext context) async {
    final AssetEntity entity = await CameraPicker.pickFromCamera(
      context,
      enableRecording: true,
      textDelegate: _CameraPickerTextDelegate(context),
      resolutionPreset: ResolutionPreset.high,
    );

    return entity;
  }

  Future<File> pickImage() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null) {
      return File(result.files.single.path);
    }
    return null;
  }

  Future<File> pickVideo() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
    );

    if (result != null) {
      return File(result.files.single.path);
    }
    return null;
  }
}

class _CameraPickerTextDelegate implements CameraPickerTextDelegate {
  final BuildContext context;

  @override
  String confirm;

  @override
  String shootingTips;

  _CameraPickerTextDelegate(this.context)
      : assert(context != null),
        confirm = AppLocalization.of(context).labels.confirm,
        shootingTips = AppLocalization.of(context).labels.shootingTips;

  @override
  String loadFailed;
}
