import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/screens/login/login.dart';
import 'package:instagram_clone/screens/sign_up/sign_up_methods.dart';
import 'package:instagram_clone/resources/utils.dart';

class SignUpOptions extends StatefulWidget {
  const SignUpOptions({super.key});

  @override
  State<SignUpOptions> createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {
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
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: _bottomWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topWidget() {
    return DropdownButton<String>(
      hint: Text(translation(context).language),
      alignment: Alignment.center,
      underline: null,
      items: [
        DropdownMenuItem<String>(
          value: 'en',
          child: Text(translation(context).first_language),
        ),
        DropdownMenuItem<String>(
          value: 'vi',
          child: Text(translation(context).second_language),
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
        const SizedBox(height: 96),
        SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
                key: const ValueKey('login_fb_button'),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.facebook, size: 24, color: Colors.white),
                    Text(
                      translation(context).log_in_with_fb,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
        const SizedBox(height: 48),
        Row(
          children: [
            const Flexible(child: Divider(thickness: 2)),
            Text(translation(context).or),
            const Flexible(child: Divider(thickness: 2)),
          ],
        ),
        const SizedBox(height: 24),
        InkWell(
            key: const ValueKey('sign_up_option'),
            child: Text(translation(context).sign_up_option,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpMethods()),
              );
            })
      ],
    );
  }

  Widget _bottomWidget() {
    return RichText(
      text: TextSpan(
        text: translation(context).alredy_have_acc,
        style: const TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: translation(context).sign_up_log_in,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
          ),
        ],
      ),
    );
  }
}
