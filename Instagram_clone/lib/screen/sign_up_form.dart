import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../language_controller.dart';
import '../utils.dart';

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



  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              const SizedBox(
                height: 32,
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
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
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
                  suffixIcon: IconButton(
                      icon: Icon(_isObscureCF
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscureCF = !_isObscureCF;
                        });
                      }),
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
                        ? () => {}
                        : null,
                    child: Text(
                      translation(context).sign_up_btn,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
