import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:instagram_clone/screens/main_ui/add_post/add_post.dart';
import 'package:instagram_clone/screens/main_ui/news_feed/feed.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';
import 'package:instagram_clone/screens/main_ui/search/search.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/models/user.dart' as model;

class MainUiNavigator extends StatefulWidget {
  const MainUiNavigator({Key? key}) : super(key: key);

  @override
  State<MainUiNavigator> createState() => _MainUiNavigatorState();
}

class _MainUiNavigatorState extends State<MainUiNavigator> {
  int _page = 0;
  late PageController pageController; // for tabs animation
  var userData = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: [
          const Feed(),
          const Search(),
          const AddPost(),
          // const Notification(),
          const Text('notifications'),
          Profile(
            uid: FirebaseAuth.instance.currentUser!.uid,
            isNavigate: true,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: const ValueKey('bottomBar'),
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: '',
              backgroundColor: Colors.white),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline_outlined,
              ),
              activeIcon: Icon(
                Icons.add_circle,
                color: Colors.black,
              ),
              label: '',
              backgroundColor: Colors.white),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline_outlined,
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            activeIcon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                    radius: 13, backgroundImage: NetworkImage(user.photoUrl)),
              ),
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: navigationTapped,
        iconSize: 30.0,
        currentIndex: _page,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
