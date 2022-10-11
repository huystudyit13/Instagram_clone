import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/screens/verify.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpMethods extends StatefulWidget {
  const SignUpMethods({super.key});

  @override
  State<SignUpMethods> createState() => _SignUpMethodsState();
}

class _SignUpMethodsState extends State<SignUpMethods>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  final email = TextEditingController();
  final phone = TextEditingController();
  bool checkPhone = false;
  bool checkMail = false;
  PhoneNumber number = PhoneNumber(isoCode: 'VN');
  late EmailAuth emailAuth;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void showMess(String content) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> checkEmail({
    required String email,
    required String password,
  }) async {
    bool check = true;
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      check = false;
      if (error.code == "email-already-in-use") {
        showMess(translation(context).email_already_in_use);
      } else if (error.code == "invalid-email") {
        showMess(translation(context).invalid_email);
      }
    }
    return check;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailAuth = EmailAuth(
      sessionName: "Instagram_clone",
    );
    phone.addListener(() {
      setState(() {
        checkPhone = phone.text.isNotEmpty;
      });
    });
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
    phone.dispose();
    email.dispose();
  }

  void sendOTP() async {
    await auth.currentUser?.delete();
    bool result = await emailAuth.sendOtp(recipientMail: email.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 1, child: Container()),
            _topWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _centerWidget(),
            ),
            Flexible(flex: 2, child: Container()),
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
    return const Icon(
      Icons.person,
      size: 120,
    );
  }

  Widget _centerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: [
            Tab(text: translation(context).phone),
            Tab(text: translation(context).email),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 210,
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Stack(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            //print(number.phoneNumber);
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          textFieldController: phone,
                          initialValue: number,
                          formatInput: false,
                          spaceBetweenSelectorAndTextField: 0,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: Colors.black,
                          inputDecoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(bottom: 15, left: 0),
                            hintText: translation(context).phone,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 16),
                          ),
                        ),
                        Positioned(
                          left: 90,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            height: 40,
                            width: 1,
                            color: Colors.black.withOpacity(0.13),
                          ),
                        )
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: translation(context).sign_up_info,
                        style: const TextStyle(color: Colors.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.lightBlueAccent,
                            disabledForegroundColor: Colors.white70,
                          ),
                          onPressed: checkPhone ? () => {} : null,
                          child: Text(
                            translation(context).next,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
              Column(
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
                          disabledBackgroundColor: Colors.lightBlueAccent,
                          disabledForegroundColor: Colors.white70,
                        ),
                        onPressed: checkMail
                            ? () async => {
                                  if (await checkEmail(
                                      email: email.value.text,
                                      password: "123456"))
                                    {
                                      sendOTP(),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Verify(
                                                  mail: email.value.text,
                                                  emailAuth: emailAuth,
                                                )),
                                      ),
                                    }
                                }
                            : null,
                        child: Text(
                          translation(context).next,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
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
