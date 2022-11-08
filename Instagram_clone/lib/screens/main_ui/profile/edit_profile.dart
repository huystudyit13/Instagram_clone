import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).edit_profile),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Colors.blue,
              ))
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
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
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://familywing.com/wp-content/uploads/2019/09/no-image-baby-385x405.png",
                        ))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: InkWell(
                    child: Text(
                  translation(context).change_profile_photo,
                  style: TextStyle(color: Colors.blue, fontSize: 20.0),
                )),
              ),
              buildTextField(translation(context).name, ''),
              buildTextField(translation(context).username, "placeholder"),
              buildTextField(translation(context).bio, ''),
            ],
          )),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: placeholder,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3.0),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
