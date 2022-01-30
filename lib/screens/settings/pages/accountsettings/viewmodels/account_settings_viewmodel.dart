import 'package:flutter/cupertino.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';

class AccountSettingsViewModel extends ChangeNotifier {
  final DbService dbService;
  final AppDataService appDataService;

  String _firstname;
  String _lastname;
  bool _editingFirstname = false;
  bool _editingLastname = false;
  bool _submitting = false;

  AccountSettingsViewModel(this.dbService, this.appDataService);

  bool get editingFirstname => _editingFirstname;
  bool get editingLastname => _editingLastname;
  bool get submitting => _submitting;

  void setSubmitting(bool submitting) {
    print(this);
    _submitting = submitting;
    notifyListeners();
  }

  void setEditingFirstname(bool editing) {
    print(this);
    _editingFirstname = editing;
    notifyListeners();
  }

  void setEditingLastname(bool editing) {
    print(this);
    _editingLastname = editing;
    notifyListeners();
  }

  void setFirstname(String firstname) async {
    setEditingFirstname(false);
    setSubmitting(true);
    await dbService.changeFirstname(firstname);
    appDataService.setUser(await dbService.getCurrentUser());
    setSubmitting(false);
  }

  void setLastname(String lastname) async {
    setEditingLastname(false);
    setSubmitting(true);
    await dbService.changeLastname(lastname);
    appDataService.setUser(await dbService.getCurrentUser());
    setSubmitting(false);
  }

  @override
  String toString() => """
    editingFirstname: $editingFirstname,
    editingLastname: $editingLastname,
    submitting: $submitting,
  """;
}
