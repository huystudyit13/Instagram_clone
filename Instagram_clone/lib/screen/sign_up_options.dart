import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/screen/login.dart';

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
            _topWidget(),
            Flexible(child: Container(), flex: 2),
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

  var items = ['English (United States)', 'Tiếng Việt (Việt Nam)'];

  Widget _topWidget() {
    return DropdownButton<String>(
      hint: Text(translation(context).language),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() async {
          Locale _locale;
          if (newValue == "Tiếng Việt (Việt Nam)") {
            _locale = await setLocale('vi');
            MyApp.setLocale(context, _locale);
          } else if (newValue == "English (United States)") {
            _locale = await setLocale('en');
            MyApp.setLocale(context, _locale);
          }
        });
      },
    );
  }

  bool _isObscure = true;

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
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
        Text(
          translation(context).sign_up_option,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(translation(context).alredy_have_acc),
        InkWell(
            child: Text(translation(context).sign_up_log_in,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            }
        )
      ],
    );
  }
}
