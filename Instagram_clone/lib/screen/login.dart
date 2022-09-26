import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/main.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool user_check = false;
  bool pass_check = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.addListener(() {
      setState(() {
        user_check = username.text.isNotEmpty;
      });
    });
    password.addListener(() {
      setState(() {
        pass_check = password.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    password.dispose();
  }

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
            Flexible(child: Container(), flex: 2),
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
        const SizedBox(height: 24),
        TextField(
          controller: username,
          decoration: InputDecoration(
            labelText: translation(context).name_input_field,
            border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          obscureText: _isObscure,
          controller: password,
          decoration: InputDecoration(
            labelText: translation(context).pass_input_field,
            border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            filled: true,
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            // style: ElevatedButton.styleFrom(
            //   color: Colors.blue,
            // ),
            onPressed: user_check && pass_check ? () => {} : null,
            child: Text(
              translation(context).log_in,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //color: Colors.blue,
          )
        ),
        // ElevatedButton(
        //   onPressed: null,
        //   child: Text(
        //     'Submit',
        //     style: TextStyle(fontSize: 24),
        //   ),
        // ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translation(context).forgot_login),
            Text(translation(context).get_help,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Flexible(child: Divider(thickness: 2)),
            Text(translation(context).or),
            Flexible(child: Divider(thickness: 2)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/fb_icon.png", height: 32),
            Text(
              translation(context).log_in_with_fb,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        )
      ],
    );
  }

  Widget _bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(translation(context).dont_have_acc),
        Text(translation(context).sign_up,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
      ],
    );
  }
}
