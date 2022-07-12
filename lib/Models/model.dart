import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Model {
  String? id;
  double? size;
  DateTime? date;

  Model(this.size, this.date);

  Model.fromSnapshot(snapshot)
      : id = snapshot.id,
        size = snapshot.data()['size'],
        date = snapshot.data()['date'].toDate();

  Map<String, dynamic> toJson() => {'id': id, 'size': size, 'date': date};
}
