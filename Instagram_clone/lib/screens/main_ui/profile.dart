import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/start.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> signOut() async {
    await AuthMethods().signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Start()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          'assets/images/logo_insta.svg',
          color: Colors.black,
          height: 35,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            iconSize: 35,
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        DropdownButton<String>(
        hint: Text(translation(context).language),
      alignment: Alignment.center,
      underline: null,
      items: [
        DropdownMenuItem<String>(
          value: 'en',
          child: Text(
            translation(context).first_language,
            key: const ValueKey('firstMenu'),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'vi',
          child: Text(
            translation(context).second_language,
            key: const ValueKey('secondMenu'),
          ),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {});
        changeLanguage(context, newValue!);
      },
    ),
            SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.lightBlueAccent,
                      disabledForegroundColor: Colors.white70,
                    ),
                    onPressed: signOut,
                    child: Text(
                      translation(context).sign_out,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ))),
          ],
        ),

    );
  }
}
