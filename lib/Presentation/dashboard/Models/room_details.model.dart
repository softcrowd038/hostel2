import 'dart:convert';

List<RoomDetails> roomDetailsFromJson(String str) => List<RoomDetails>.from(
    json.decode(str).map((x) => RoomDetails.fromJson(x)));

String roomDetailsToJson(List<RoomDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomDetails {
  final int id;
  final int roomNumber;
  final int seater;
  final String fees;
  final DateTime entryDate;
  final String image;
  final String description;

  RoomDetails({
    required this.id,
    required this.roomNumber,
    required this.seater,
    required this.fees,
    required this.entryDate,
    required this.image,
    required this.description,
  });

  factory RoomDetails.fromJson(Map<String, dynamic> json) => RoomDetails(
        id: json["id"],
        roomNumber: json["Room_Number"],
        seater: json["Seater"],
        fees: json["Fees"],
        entryDate: DateTime.parse(json["Entry_Date"]),
        image: json["Image"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Room_Number": roomNumber,
        "Seater": seater,
        "Fees": fees,
        "Entry_Date": entryDate.toIso8601String(),
        "Image": image,
        "Description": description,
      };
}
