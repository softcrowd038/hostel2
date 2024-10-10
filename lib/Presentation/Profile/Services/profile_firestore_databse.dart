// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors
import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreProfileData {
  Future<void> storeUserData(
      String? imageurl,
      String? name,
      String? email,
      String? phone,
      String? emergencyContactName,
      String? relation,
      String? emergencyPhone,
      String? address,
      DateTime? birthdate,
      String? gender) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'profilePictureUrl': imageurl,
        'name': name,
        'email': email,
        'phone': phone,
        'guardian': emergencyContactName,
        'relation': relation,
        'emergencyPhone': emergencyPhone,
        'address': address,
        'birthdate': birthdate,
        'gender': gender
      });
      print('User data stored successfully!');
    } catch (e) {
      print('Error storing user data: $e');
    }
  }

  Future<ProfilePageModel?> getUserData(String email) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        return ProfilePageModel(
            imageurl: userData['profilePictureUrl'],
            name: userData['name'],
            email: userData['email'],
            phone: userData['phone'],
            emergencyContactName: userData['guardian'],
            relation: userData['relation'],
            emergencyPhone: userData['emergencyPhone'],
            address: userData['address'],
            birthdate: userData['birthdate']
                ?.toDate(), // Convert Timestamp to DateTime
            gender: userData['gender']);
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> updateDocument(
      BuildContext context, ProfilePageModel updatedUserData) async {
    try {
      // Convert ProfilePageModel to Map
      Map<String, dynamic> updatedData = {
        'profilePictureUrl': updatedUserData.imageurl,
        'name': updatedUserData.name,
        'email': updatedUserData.email,
        'phone': updatedUserData.phone,
        'guardian': updatedUserData.emergencyContactName,
        'relation': updatedUserData.relation,
        'emergencyPhone': updatedUserData.emergencyPhone,
        'address': updatedUserData.address,
        'birthdate': updatedUserData.birthdate,
        'gender': updatedUserData.gender
      };

      // Update the document in Firestore with the new data
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedUserData.email)
          .update(updatedData);

      // Show success message or navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data updated successfully')),
      );
    } catch (error) {
      // Handle any errors that occur during updating
      print('Error updating document: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to update data. Please try again later.')),
      );
    }
  }

  Future<String?> getImageUrlFromFirestore(String email) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (snapshot.exists) {
        return snapshot.data()?['profilePictureUrl'];
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error retrieving image URL from Firestore: $e');
    }
    return null;
  }
}
