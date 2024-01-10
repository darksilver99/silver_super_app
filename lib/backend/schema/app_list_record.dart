import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppListRecord extends FirestoreRecord {
  AppListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
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

  // "app_icon" field.
  String? _appIcon;
  String get appIcon => _appIcon ?? '';
  bool hasAppIcon() => _appIcon != null;

  void _initializeFields() {
    _appName = snapshotData['app_name'] as String?;
    _url = snapshotData['url'] as String?;
    _appIcon = snapshotData['app_icon'] as String?;
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
  String? appIcon,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'app_name': appName,
      'url': url,
      'app_icon': appIcon,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppListRecordDocumentEquality implements Equality<AppListRecord> {
  const AppListRecordDocumentEquality();

  @override
  bool equals(AppListRecord? e1, AppListRecord? e2) {
    return e1?.appName == e2?.appName &&
        e1?.url == e2?.url &&
        e1?.appIcon == e2?.appIcon;
  }

  @override
  int hash(AppListRecord? e) =>
      const ListEquality().hash([e?.appName, e?.url, e?.appIcon]);

  @override
  bool isValidKey(Object? o) => o is AppListRecord;
}
