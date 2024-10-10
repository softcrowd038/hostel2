import 'package:flutter/material.dart';

class HealthDetailsModel extends ChangeNotifier {
  int? height;
  String? heightUnit;
  double? weight;
  String? weightUnit;
  String? medicalCondition;
  String? nutritionCondition;
  String? fitnessGoal;
  String? activityLevel;
  List<String>? _fitnessInterest;
  List<String>? get fitnessInterest => _fitnessInterest;
  String? fitnessExperience;
  String? workoutLocation;
  String? facebookUrl;
  String? twitterUrl;
  String? instagramUrl;

  void setHeight(int height) {
    this.height = height; // Store the image path
    notifyListeners();
  }

  void setHeightUnit(String heightUnit) {
    this.heightUnit = heightUnit;
    notifyListeners();
  }

  void setWeight(double weight) {
    this.weight = weight; // Store the image path
    notifyListeners();
  }

  void setWeightUnit(String weightUnit) {
    this.weightUnit = weightUnit;
    notifyListeners();
  }

  void setMedicalCondition(String medicalCondition) {
    this.medicalCondition = medicalCondition;
    notifyListeners();
  }

  void setNutritionCondition(String nutritionCondition) {
    this.nutritionCondition = nutritionCondition;
    notifyListeners();
  }

  void setFitnessGoal(String fitnessGoal) {
    this.fitnessGoal = fitnessGoal;
    notifyListeners();
  }

  void setActivityLevel(String activityLevel) {
    this.activityLevel = activityLevel;
    notifyListeners();
  }

  setFitnessInterest(List<String>? fitnessInterest) {
    _fitnessInterest = fitnessInterest;
    notifyListeners(); // Notify listeners to rebuild widgets consuming this model
  }

  void setFitnessExperience(String fitnessExperience) {
    // Changed method name to camelCase
    this.fitnessExperience = fitnessExperience;
    notifyListeners();
  }

  void setWorkoutLocation(String workoutLocation) {
    this.workoutLocation = workoutLocation;
    notifyListeners();
  }

  void setFacebookUrl(String facebookUrl) {
    this.facebookUrl = facebookUrl;
    notifyListeners();
  }

  void setTwitterUrl(String twitterUrl) {
    this.twitterUrl = twitterUrl;
    notifyListeners();
  }

  void setInstagramUrl(String instagramUrl) {
    this.instagramUrl = instagramUrl;
    notifyListeners();
  }
}
