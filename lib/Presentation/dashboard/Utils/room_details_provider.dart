import 'dart:convert';
import 'package:accident/Presentation/dashboard/Models/room_details.model.dart';
import 'package:accident/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomDetailsProvider extends ChangeNotifier {
  Future<RoomDetails?> fetchRoomDetails(int roomNumber) async {
    final url = Uri.parse('$baseUrl/manage_rooms/room-details/$roomNumber');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty) {
          return RoomDetails.fromJson(jsonResponse[0]);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
