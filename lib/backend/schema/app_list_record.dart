import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class AppListRecord extends FirestoreRecord {
  AppListRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "app_name" field.
  String? _appName;
  String get appName => _appName ?? '';
  bool hasAppName() => _appName != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  void _initializeFields() {
    _appName = snapshotData['app_name'] as String?;
    _url = snapshotData['url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('app_list');

  static Stream<AppListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppListRecord.fromSnapshot(s));

  static Future<AppListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppListRecord.fromSnapshot(s));

  static AppListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAppListRecordData({
  String? appName,
  String? url,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'app_name': appName,
      'url': url,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppListRecordDocumentEquality implements Equality<AppListRecord> {
  const AppListRecordDocumentEquality();

  @override
  bool equals(AppListRecord? e1, AppListRecord? e2) {
    return e1?.appName == e2?.appName && e1?.url == e2?.url;
  }

  @override
  int hash(AppListRecord? e) => const ListEquality().hash([e?.appName, e?.url]);

  @override
  bool isValidKey(Object? o) => o is AppListRecord;
}
