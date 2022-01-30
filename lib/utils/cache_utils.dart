import 'package:cloud_firestore/cloud_firestore.dart';

class CacheUtils {
  static Future<QuerySnapshot> queryForCacheFirst(Query query,
      {bool Function(QuerySnapshot) orFromServer}) async {
    try {
      final results = await query.get(GetOptions(source: Source.cache));

      if (orFromServer != null) {
        if (orFromServer(results)) {
          throw new Exception();
        }
      }

      return results;
    } on Exception {
      return query.get(GetOptions(source: Source.server));
    }
  }

  static Future<DocumentSnapshot> getDocumentFromCacheFirst(
      DocumentReference ref) async {
    try {
      final doc = await ref.get(GetOptions(source: Source.cache));

      return doc;
    } on Exception {
      return ref.get(GetOptions(source: Source.server));
    }
  }
}
