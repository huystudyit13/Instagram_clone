import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/screens/login/forgot_password.dart';
import 'package:instagram_clone/screens/main_ui/home.dart';
import 'package:instagram_clone/screens/main_ui/navigator.dart';
import 'package:instagram_clone/screens/sign_up/sign_up_options.dart';

import '../../resources/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool userCheck = false;
  bool passCheck = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    username.addListener(() {
      setState(() {
        userCheck = username.text.isNotEmpty;
      });
    });
    password.addListener(() {
      setState(() {
        passCheck = password.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .loginUser(email: username.text, password: password.text);
    if (res == 'success') {

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeLayout(
                  mobileScreenLayout: MainUiNavigator(),
                )),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      if (res == "wrong-password") {
        if (!mounted) return;
        res = translation(context).wrong_password;
      } else if (res == "invalid-email") {
        if (!mounted) return;
        res = translation(context).invalid_email;
      } else if (res == "user-not-found") {
        if (!mounted) return;
        res = translation(context).user_not_found;
      }
      if (!mounted) return;
      showMess(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: _topWidget(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              //Flexible(flex: 1, child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _centerWidget(),
              ),
              Flexible(flex: 2, child: Container()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _bottomWidget(),
              ),
            ],
          ),
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
          key: const ValueKey('emailSignUpField'),
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
          key: const ValueKey('passwordSignUpField'),
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
            suffixIcon: passCheck
                ? IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    })
                : null,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              key: const ValueKey('loginButton'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.lightBlueAccent,
                disabledForegroundColor: Colors.white70,
              ),
              onPressed: userCheck && passCheck
                  ? () => {
                        FocusManager.instance.primaryFocus?.unfocus(),
                        loginUser(),
                      }
                  : null,
              child: !_isLoading
                  ? Text(
                      translation(context).log_in,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            )),
        const SizedBox(height: 24),
        RichText(
          key: const ValueKey('forgot'),
          textAlign: TextAlign.center,
          text: TextSpan(
            text: translation(context).forgot_login,
            style: const TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: translation(context).get_help,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPass()),
                    );
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Flexible(child: Divider(thickness: 2)),
            Text(translation(context).or),
            const Flexible(child: Divider(thickness: 2)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.facebook, size: 24, color: Colors.blue),
            Text(
              translation(context).log_in_with_fb,
              style: const TextStyle(color: Colors.blue),
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
        style: const TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: translation(context).sign_up,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpOptions()),
                );
              },
          ),
        ],
      ),
    );
  }
}
