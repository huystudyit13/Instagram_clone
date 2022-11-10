import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final email = TextEditingController();
  bool checkMail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(() {
      setState(() {
        checkMail = email.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
  }

  Future<bool> resetPassword() async {
    bool check = true;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
    } on FirebaseAuthException catch (e) {
      check = false;
      if (e.code == "invalid-email") {
        showMess(context, translation(context).invalid_email);
      } else if (e.code == "user-not-found") {
        showMess(context, translation(context).user_not_found);
      }
    }
    return check;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: ,
        title: Text(
          translation(context).forgot_pass_title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                translation(context).forgot_pass_title1,
                style: const TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text(translation(context).forgot_pass_subtitle),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: translation(context).email,
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
                          backgroundColor: Colors.lightBlueAccent,
                          disabledForegroundColor: Colors.white70,
                        ),
                        onPressed: checkMail
                            ? () async {
                                if (await resetPassword()) {
                                  showMess(
                                      context,
                                      translation(context)
                                          .password_reset_inform);
                                  Navigator.pop(context);
                                }
                              }
                            : null,
                        child: Text(
                          translation(context).next,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
