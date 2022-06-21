import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Data {
  String? message;
  int? label;
  int? correction;
  DateTime? created_at;

  Data(this.message, this.label);

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'label': label,
      'correction': correction,
      'created_at': created_at
    };
  }

  Data.fromSnapshot(snapshot)
      : message = snapshot.data()['message'],
        label = snapshot.data()['label'],
        correction = snapshot.data()['correction'],
        created_at = snapshot.data()['created_at'].toDate();

  Map<String, dynamic> toJson() => {
        'message': message,
        'label': label,
        'correction': correction,
        'created_at': created_at
      };
}
