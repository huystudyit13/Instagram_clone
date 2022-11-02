import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../language_controller.dart';
import '../utils.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCfController = TextEditingController();
  Uint8List? _image;
  bool _isObscure = true;
  bool _isObscureCF = true;
  bool user_check = false;
  bool pass_check = false;
  bool passCF_check = false;

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
        user_check = _usernameController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        pass_check = _passwordController.text.isNotEmpty;
      });
    });
    _passwordCfController.addListener(() {
      setState(() {
        passCF_check = _passwordCfController.text.isNotEmpty;
      });
    });
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              const SizedBox(
                height: 64,
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
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.grey,
                          ),
                          backgroundColor: Colors.white,
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
                      onSurface: Colors.blue,
                    ),
                    onPressed: user_check && pass_check && passCF_check
                        ? () => {}
                        : null,
                    child: Text(
                      translation(context).sign_up_btn,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
              Flexible(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
