import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/language_controller.dart';
import 'package:instagram_clone/screen/login.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpMethods extends StatefulWidget {
  @override
  State<SignUpMethods> createState() => _SignUpMethodsState();
}

class _SignUpMethodsState extends State<SignUpMethods>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  final email = TextEditingController();
  final phone = TextEditingController();
  bool check_phone = false;
  bool check_mail = false;
  //String initialCountry = 'VN';
  PhoneNumber number = PhoneNumber(isoCode: 'VN');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone.addListener(() {
      setState(() {
        check_phone = phone.text.isNotEmpty;
      });
    });
    email.addListener(() {
      setState(() {
        check_mail = email.text.isNotEmpty;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 1),
            _topWidget(),
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
    return Icon(
      Icons.person,
      size: 120,
    );
  }

  Widget _centerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: translation(context).phone),
              Tab(text: translation(context).email),
            ],
          ),
        ),
        Container(
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
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          textFieldController: phone,
                          initialValue: number,
                          formatInput: false,
                          spaceBetweenSelectorAndTextField: 0,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: Colors.black,
                          inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, left: 0),
                            //border: InputBorder.none,
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
                        style: TextStyle(color: Colors.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Colors.blue,
                          ),
                          onPressed: check_phone ? () => {} : null,
                          child: Text(
                            translation(context).next,
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                          onSurface: Colors.blue,
                        ),
                        onPressed: check_mail ? () => {} : null,
                        child: Text(
                          translation(context).next,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
