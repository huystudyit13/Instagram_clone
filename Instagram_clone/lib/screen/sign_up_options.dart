import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/screen/login.dart';
import 'package:instagram_clone/screen/sign_up_methods.dart';

class SignUpOptions extends StatefulWidget {
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
            Flexible(child: Container(), flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _centerWidget(),
            ),
            Flexible(child: Container(), flex: 1),
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
          value: 'English',
          child: Text(translation(context).first_language),
        ),
        DropdownMenuItem<String>(
          value: 'Tiếng Việt',
          child: Text(translation(context).second_language),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() async {
          //dropdownValue = newValue!;
          Locale _locale;
          if (newValue == "Tiếng Việt") {
            _locale = await setLocale('vi');
            MyApp.setLocale(context, _locale);
          } else if (newValue == "English") {
            _locale = await setLocale('en');
            MyApp.setLocale(context, _locale);
          }
        });
      },
    );
  }

  Widget _centerWidget() {
    return Column(
      children: [
        // SvgPicture.asset(
        //   'assets/logo_insta.svg',
        //   color: Theme.of(context).colorScheme.onBackground,
        //   height: 32.0,
        // ),
        Image.asset(
          'assets/images/instagram_icon.png',
          height: 64,
        ),
        const SizedBox(height: 96),
        SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, size: 24, color: Colors.white),
                    Text(
                      translation(context).log_in_with_fb,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
        const SizedBox(height: 48),
        Row(
          children: [
            Flexible(child: Divider(thickness: 2)),
            Text(translation(context).or),
            Flexible(child: Divider(thickness: 2)),
          ],
        ),
        const SizedBox(height: 24),
        InkWell(
            child: Text(translation(context).sign_up_option,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpMethods()),
              );
            })
      ],
    );
  }

  Widget _bottomWidget() {
    return RichText(
      text: TextSpan(
        text: translation(context).alredy_have_acc,
        style: TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: translation(context).sign_up_log_in,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
          ),
        ],
      ),
    );
  }
}
