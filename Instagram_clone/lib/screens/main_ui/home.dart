import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  const HomeLayout({
    Key? key,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return widget.mobileScreenLayout;
    });
  }
}
