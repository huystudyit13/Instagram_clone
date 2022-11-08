import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  late String s;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      s = prefs.getString('languageCode')!;
    });
  }

  Future<void> changeData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            translation(context).language,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: <Widget>[
            RadioListTile<String>(
              title: Text(translation(context).first_language),
              value: 'en',
              groupValue: s,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  s = value!;
                });
                changeData(value!);
                changeLanguage(context, value);
              },
            ),
            RadioListTile<String>(
              title: Text(translation(context).second_language),
              value: "vi",
              groupValue: s,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  s = value!;
                });
                changeData(value!);
                changeLanguage(context, value);
              },
            ),
          ],
        ));
  }
}
