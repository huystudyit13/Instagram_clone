import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';

class EditProfile extends StatefulWidget {
  final userData;
  const EditProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final username = TextEditingController();
  final name = TextEditingController();
  final bio = TextEditingController();
  bool checkUsername = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    name.dispose();
    bio.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.text = widget.userData['username'];
    name.text = widget.userData['name'];
    bio.text = widget.userData['bio'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          translation(context).edit_profile,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (username.text == widget.userData['username'] &&
                name.text == widget.userData['name'] &&
                bio.text == widget.userData['bio']) {
              Navigator.pop(context);
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    translation(context).unsaved,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Text(translation(context).unsaved_content),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text(
                        translation(context).no,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: Text(
                        translation(context).yes,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ).then((value) {
                if (value == 'OK') {
                  Navigator.pop(context);
                }
              });
            }
          },
        ),
        actions: checkUsername
            ? [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check,
                      color: Colors.blue,
                    ))
              ]
            : null,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.userData['photoUrl'],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: InkWell(
                    child: Text(
                  translation(context).change_profile_photo,
                  style: const TextStyle(color: Colors.blue, fontSize: 20.0),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3.0),
                      labelText: translation(context).name,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  onChanged: (_) {
                    setState(() {});
                    var temp = usernameError(username.text, context);
                    if (temp == null) {
                      checkUsername = true;
                    } else {
                      checkUsername = false;
                    }
                  },
                  controller: username,
                  maxLength: 30,
                  decoration: InputDecoration(
                      errorText: usernameError(username.text, context),
                      contentPadding: const EdgeInsets.only(bottom: 3.0),
                      labelText: translation(context).username,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: bio,
                  keyboardType: TextInputType.multiline,
                  maxLength: 150,
                  maxLines: null,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3.0),
                      labelText: translation(context).bio,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
