import 'package:cloud_firestore/cloud_firestore.dart';

class Accident {
  final String id;
  final String date;
  final String time;
  final String location;

  Accident({
    required this.id,
    required this.date,
    required this.time,
    required this.location,
  });

  // Factory constructor to create an Accident object from Firestore document
  factory Accident.fromFirestore(DocumentSnapshot doc) {
    // Ensure the data is not null
    if (doc.data() == null) {
      throw Exception("Document data is null");
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Ensure required fields are present and handle potential null values
    return Accident(
      id: doc.id,
      date: data['date'] ?? 'Unknown date',
      time: data['time'] ?? 'Unknown time',
      location: data['location'] ?? 'Unknown location',
    );
  }

  // Method to delete accident
  static Future<void> deleteAccident(String id) async {
    await FirebaseFirestore.instance.collection('accidents').doc(id).delete();
  }
}
