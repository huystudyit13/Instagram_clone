import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/screen/sign_up_options.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _topWidget(),
            ),
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

  bool _isObscure = true;

  Widget _centerWidget() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/logo_insta.svg',
          color: Colors.black,
          height: 52.0,
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
              style: ElevatedButton.styleFrom(
                onSurface: Colors.blue,
              ),
              onPressed: user_check && pass_check ? () => {} : null,
              child: Text(
                translation(context).log_in,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
        const SizedBox(height: 24),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: translation(context).forgot_login,
            style: TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: translation(context).get_help,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpOptions()),);
                  },
              ),
            ],
          ),
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
            Icon(Icons.facebook, size: 24, color: Colors.blue),
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
    return RichText(
      text: TextSpan(
        text: translation(context).dont_have_acc,
        style: TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: translation(context).sign_up,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpOptions()),
                );
              },
          ),
        ],
      ),
    );
  }
}
