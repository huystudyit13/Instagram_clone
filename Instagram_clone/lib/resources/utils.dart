import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/main.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  final XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

Future<void> changeLanguage(BuildContext context, String newValue) async {
  Locale locale;
  locale = await setLocale(newValue);
  //if (!mounted) return;
  // ignore: use_build_context_synchronously
  MyApp.setLocale(context, locale);
}

void showMess(BuildContext context, String content) {
  final snackBar = SnackBar(
    key: const ValueKey('message'),
    content: Text(
      content,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blue,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

