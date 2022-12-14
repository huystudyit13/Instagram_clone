import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/screens/login/login.dart';
import 'package:instagram_clone/screens/sign_up/sign_up_options.dart';
import 'package:instagram_clone/resources/utils.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _topWidget(),
            ),
            Flexible(flex: 1, child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _centerWidget(),
            ),
            Flexible(flex: 1, child: Container()),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topWidget() {
    return DropdownButton<String>(
      hint: Text(translation(context).default_language),
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
    );
  }

  Widget _centerWidget() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/logo_insta.svg',
          color: Colors.black,
          height: 52.0,
        ),
        const SizedBox(height: 24),
        SizedBox(
            height: 48,
            key: const ValueKey('signupButton'),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpOptions()),
                );
              },
              child: Text(
                translation(context).create_account,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
        const SizedBox(height: 24),
        InkWell(
            key: const ValueKey('login'),
            child: Text(
              translation(context).log_in,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            })
      ],
    );
  }
}
