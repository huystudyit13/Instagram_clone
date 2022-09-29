import 'package:flutter/material.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/screen/login.dart';
import 'package:instagram_clone/screen/sign_up_options.dart';

class StartingUp extends StatefulWidget {
  @override
  State<StartingUp> createState() => _StartingUpState();
}

class _StartingUpState extends State<StartingUp> {
  @override
  Widget build(BuildContext context) {
    //context.watch<LanguageController>();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(translation(context).language),
        alignment: Alignment.center,
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
      ),
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
        const SizedBox(height: 24),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {},
              child: InkWell(
                  child: Text(translation(context).create_account,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpOptions()),
                    );
                  })),
        ),
        const SizedBox(height: 24),
        InkWell(
            child: Text(
              translation(context).log_in,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            })
      ],
    );
  }
}
