import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/screen/login.dart';


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
            _topWidget(),
            Flexible(child: Container(), flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _centerWidget(),
            ),
            Flexible(child: Container(), flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ],
        ),
      ),
    );
  }

  var items = ['English (United States)', 'Tiếng Việt (Việt Nam)'];
  //String dropdownValue = translation(context).create_account;

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
          //dropdownValue = newValue!;
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
            child: Text(translation(context).create_account),
          ),
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
          }
        )
      ],
    );
  }
}
