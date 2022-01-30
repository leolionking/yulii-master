import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/app_info.dart';
import 'package:yulli/models/credit_transaction.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/device_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/services/file_storage_service.dart';

class AppDataService extends ChangeNotifier {
  final MyLogger _logger = MyLogger('AppDataService');
  final _imagePicker = ImagePicker();
  DbService _dbService;
  DeviceInfo _deviceInfo;
  FileStorageService _fileStorageService;
  User _currentUser;
  CreditTransaction _lastCredits;
  AppInfo _appInfo;
  StreamSubscription _lastCreditsStreamSubscription;
  double _statusBarheight;
  bool _avatarUploading = false;

  User get currentUser => _currentUser;
  CreditTransaction get lastCredits => _lastCredits;
  AppInfo get appInfo => _appInfo;
  double get statusBarHeight => _statusBarheight;
  bool get avatarUploading => _avatarUploading;

  Future<void> init() async {
    await Future.wait([
      fetchLastCredits(notify: false),
      fetchUser(notify: false),
    ]);
    _appInfo = AppInfo(
      appName: await _deviceInfo.appName ?? "Yulii",
      appVersion: await _deviceInfo.appVersion,
    );
    notifyListeners();
    _refreshSubscriptions();
  }

  void setDbService(DbService dbService) {
    _dbService = dbService;
    notifyListeners();
  }

  void setDeviceInfo(DeviceInfo deviceInfo) {
    _deviceInfo = deviceInfo;
    notifyListeners();
  }

  void setFileStorageService(FileStorageService service) {
    _fileStorageService = service;
    notifyListeners();
  }

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void setAvatarUploading(bool uploading) {
    _avatarUploading = uploading;
    notifyListeners();
  }

  void _setLastCredits(CreditTransaction creditTransaction,
      {bool notify = true}) {
    _lastCredits = creditTransaction;
    if (_currentUser != null) {
      _currentUser = _currentUser.copyWith(lastCredits: _lastCredits);
    }
    if (notify) notifyListeners();
  }

  Future<void> fetchLastCredits({bool notify = true}) async {
    _lastCredits = await _dbService.getLastCredits();
    _setLastCredits(_lastCredits, notify: notify);
  }

  Future<void> fetchUser({bool notify = true}) async {
    _currentUser = await _dbService.getCurrentUser();
    if (notify) notifyListeners();
  }

  Future<void> _refreshSubscriptions() async {
    await _lastCreditsStreamSubscription?.cancel();

    final lastCreditsQuery = await _dbService.lastCreditsQuery;

    _lastCreditsStreamSubscription = lastCreditsQuery
        .snapshots()
        .debounce((_) => TimerStream(true, Duration(milliseconds: 200)))
        .listen((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        _setLastCredits(
          CreditTransaction.fromJson(querySnapshot.docs.first.data())
              .copyWith(remoteId: querySnapshot.docs.first.id),
        );
      }
    });
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);

    if (pickedFile != null) {
      _logger.d("picked image : ${pickedFile.path}");

      final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 300,
        maxHeight: 300,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          rotateButtonsHidden: true,
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
        ),
      );

      if (croppedFile != null) {
        setAvatarUploading(true);

        final uploadedFile = await _fileStorageService.upload(croppedFile);

        await Future.wait([
          _dbService.updateAvatarUrl(uploadedFile.downloadUrl),
          _dbService.saveAvatarInPrefs(uploadedFile.downloadUrl),
        ]);

        await fetchUser(notify: false);

        setAvatarUploading(false);
      }
    }
  }

  Future<void> _setAvatar(String avatarUrl, {bool notify = true}) async {
    await Future.wait([
      _dbService.updateAvatarUrl(avatarUrl),
      _dbService.saveAvatarInPrefs(avatarUrl),
    ]);

    await fetchUser(notify: notify);

    _logger.d('setted');
  }

  void deleteAvatar() async {
    await Future.wait([
      _dbService.updateAvatarUrl(null),
      _dbService.deleteAvatarInPrefs(),
    ]);

    await fetchUser(notify: true);
  }

  @override
  void dispose() {
    _lastCreditsStreamSubscription?.cancel();
    super.dispose();
  }
}
