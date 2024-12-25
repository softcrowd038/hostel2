import 'dart:convert';
import 'package:accident/Presentation/Emergency/Models/student_installments.dart';
import 'package:accident/data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentInstallmentsProvider extends ChangeNotifier {
  Future<StudentInstallments?> fetchStudentInstallments(String regiNum) async {
    final url = Uri.parse('$baseUrl/installments/invoice/$regiNum');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty) {
          return StudentInstallments.fromJson(jsonResponse[0]);
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
