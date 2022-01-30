import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yulli/models/credit_transaction.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/notification.dart' as _notification;
import 'package:yulli/models/uploaded_file.dart';

class ModelUtils {
  static DateTime firebaseTimestampToDateTime(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }

  static CreditTransactionType creditTransactionTypeValueToEnum(String value) {
    switch (value) {
      case CreditTransactionTypeValue.increase:
        return CreditTransactionType.increase;
      case CreditTransactionTypeValue.decrease:
        return CreditTransactionType.decrease;
      default:
        return CreditTransactionType.idle;
    }
  }

  static String creditTransactionTypeToValue(
      CreditTransactionType creditTransactionType) {
    switch (creditTransactionType) {
      case CreditTransactionType.decrease:
        return CreditTransactionTypeValue.decrease;
      case CreditTransactionType.increase:
        return CreditTransactionTypeValue.increase;
      default:
        return null;
    }
  }

  static GoalType goalTypeValueToEnum(String value) {
    switch (value) {
      case GoalTypeValue.classic:
        return GoalType.classic;
      case GoalTypeValue.pro:
        return GoalType.pro;
    }
    return null;
  }

  static String goalTypeToValue(GoalType goalType) {
    switch (goalType) {
      case GoalType.classic:
        return GoalTypeValue.classic;
      case GoalType.pro:
        return GoalTypeValue.pro;
    }
    return null;
  }

  static Status statusValueToEnum(String status) {
    switch (status) {
      case StatusValue.opened:
        return Status.opened;
      case StatusValue.pending:
        return Status.pending;
      case StatusValue.done:
        return Status.done;
      case StatusValue.closed:
        return Status.closed;
      case StatusValue.declined:
        return Status.declined;
    }
    return null;
  }

  static String statusEnumToValue(Status status) {
    switch (status) {
      case Status.pending:
        return StatusValue.pending;
      case Status.opened:
        return StatusValue.opened;
      case Status.done:
        return StatusValue.done;
      case Status.closed:
        return StatusValue.closed;
      case Status.declined:
        return StatusValue.declined;
    }
    return null;
  }

  static DateTime utcStringToDatetime(String utcString) {
    return DateTime.parse(utcString);
  }

  static int dateTimeToMilliseconds(DateTime dateTime) {
    if (dateTime == null) return null;
    return dateTime.toUtc().millisecondsSinceEpoch;
  }

  static DateTime millisecondsToDateTime(int milliseconds) {
    if (milliseconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  static UploadedFile mapToUploadedFile(Map<String, dynamic> map) =>
      map != null ? UploadedFile.fromJson(map) : null;

  static Map<String, dynamic> uploadedFileToJson(UploadedFile uploadedFile) =>
      uploadedFile?.toJson() ?? null;

  static List<UploadedFile> mapToUploadedFilesList(List<dynamic> maps) =>
      List<UploadedFile>.from(
          maps?.map((e) => UploadedFile.fromJson(e as Map<String, dynamic>)) ??
              []);

  static List<Map<String, dynamic>> uploadedFilesListToJson(
          List<UploadedFile> files) =>
      files?.map((file) => file.toJson())?.toList() ?? [];
}
