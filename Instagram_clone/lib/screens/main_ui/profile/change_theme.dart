import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  String s = "light";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            translation(context).theme,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: <Widget>[
            RadioListTile<String>(
              title: Text(translation(context).light),
              value: 'light',
              groupValue: s,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  s = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(translation(context).dark),
              value: "dark",
              groupValue: s,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  s = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(translation(context).system_default),
              value: "system_default",
              groupValue: s,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String? value) {
                setState(() {
                  s = value!;
                });
              },
            ),
          ],
        ));
  }
}
