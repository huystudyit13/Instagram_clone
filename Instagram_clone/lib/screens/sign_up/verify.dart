import 'package:email_auth/email_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/sign_up/sign_up_form.dart';

class Verify extends StatefulWidget {
  final String mail;
  final EmailAuth emailAuth;
  const Verify({
    super.key,
    required this.mail,
    required this.emailAuth,
  });
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final code = TextEditingController();
  bool checkCode = false;

  bool verify() {
    return widget.emailAuth
        .validateOtp(recipientMail: widget.mail, userOtp: code.value.text);
  }

  void resendOTP() async {
    await widget.emailAuth.sendOtp(recipientMail: widget.mail);
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    code.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    code.addListener(() {
      setState(() {
        checkCode = code.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _centerWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            translation(context).verify_title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(translation(context).verify_title_1,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.mail,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(
                text: ". ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: translation(context).resend,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    resendOTP();
                    showMess(context, translation(context).resend_inform);
                  },
              ),
              const TextSpan(
                text: ". ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: code,
            decoration: InputDecoration(
              hintText: translation(context).cf_code,
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
        ),
        SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.lightBlueAccent,
                disabledForegroundColor: Colors.white70,
              ),
              onPressed: checkCode
                  ? () async => {
                        if (verify())
                          {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpForm(mail: widget.mail)),
                            ),
                          }
                        else
                          {
                            showMess(context, translation(context).validate_fail),
                          }
                      }
                  : null,
              child: Text(
                translation(context).next,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}
