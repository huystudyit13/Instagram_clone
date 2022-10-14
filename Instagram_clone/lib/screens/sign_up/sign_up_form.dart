import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/start.dart';

import '../../resources/language_controller.dart';
import '../../resources/utils.dart';

class SignUpForm extends StatefulWidget {
  final String mail;
  const SignUpForm({super.key, required this.mail});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCfController = TextEditingController();
  Uint8List? _image;
  bool _isObscure = true;
  bool _isObscureCF = true;
  bool userCheck = false;
  bool passCheck = false;
  bool passCfCheck = false;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _passwordCfController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        userCheck = _usernameController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        passCheck = _passwordController.text.isNotEmpty;
      });
    });
    _passwordCfController.addListener(() {
      setState(() {
        passCfCheck = _passwordCfController.text.isNotEmpty;
      });
    });
  }

  Future<void> convert() async {
    final ByteData bytes =
        await rootBundle.load('assets/images/default_profile.jpg');
    final Uint8List list = bytes.buffer.asUint8List();
    _image = list;
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: widget.mail,
        password: _passwordController.text,
        username: _usernameController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Start()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (!mounted) return;
      showMess(context, translation(context).weak_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.white,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: translation(context).username,
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
              const SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: _isObscure,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: translation(context).pass_input_field,
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
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })
                      : null,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: _isObscureCF,
                controller: _passwordCfController,
                decoration: InputDecoration(
                  hintText: translation(context).pass_cf,
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
                  suffixIcon: passCfCheck
                      ? IconButton(
                          icon: Icon(_isObscureCF
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscureCF = !_isObscureCF;
                            });
                          })
                      : null,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.lightBlueAccent,
                      disabledForegroundColor: Colors.white70,
                    ),
                    onPressed: userCheck && passCheck && passCfCheck
                        ? () => {
                              // if (_image == null) {
                              //   convert(),
                              // },
                              if (_passwordCfController.text ==
                                  _passwordController.text)
                                {
                                  signUpUser(),
                                }
                              else
                                {
                                  showMess(context, translation(context).wrong_cf_pass),
                                }
                            }
                        : null,
                    child: !_isLoading
                        ? Text(
                            translation(context).sign_up_btn,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  )),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
