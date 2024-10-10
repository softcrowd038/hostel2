// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:accident/Presentation/Profile/Model/profile_page_model.dart';
import 'package:accident/Presentation/Profile/Services/profile_firestore_databse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePictureField extends StatefulWidget {
  final bool isEdit;

  const ProfilePictureField({Key? key, required this.isEdit}) : super(key: key);

  @override
  ProfilePictureFieldState createState() => ProfilePictureFieldState();
}

class ProfilePictureFieldState extends State<ProfilePictureField> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isEdit) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _retainImage();
      });
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (!mounted) return;
      Provider.of<ProfilePageModel>(context, listen: false)
          .setImageUrl(File(pickedImage.path));
    } else {
      if (!mounted) return;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No image selected')));
      });
    }
  }

  Future<void> _retainImage() async {
    try {
      String? userEmail =
          Provider.of<ProfilePageModel>(context, listen: false).email;

      String? imageUrl =
          await FireStoreProfileData().getImageUrlFromFirestore(userEmail!);

      if (await File(imageUrl!).exists()) {
        if (!mounted) return;
        Provider.of<ProfilePageModel>(context, listen: false)
            .setImageUrl(File(imageUrl));
        return;
      }
      if (!mounted) return;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image not found in Firestore')));
      });
    } catch (e) {
      print('Error retrieving image from Firestore: $e');
      if (!mounted) return;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to retrieve image')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfilePageModel>(context);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: profileModel.imageurl != null
                ? FileImage(File(profileModel.imageurl!))
                : null,
            child: profileModel.imageurl == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _getImage,
          child: Text('Select Profile Picture'),
        ),
      ],
    );
  }
}
