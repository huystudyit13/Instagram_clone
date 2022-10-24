import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:instagram_clone/screens/main_ui/add_post.dart';
import 'package:instagram_clone/screens/main_ui/feed.dart';
import 'package:provider/provider.dart';

class MainUiNavigator extends StatefulWidget {
  const MainUiNavigator({Key? key}) : super(key: key);

  @override
  State<MainUiNavigator> createState() => _MainUiNavigatorState();
}

class _MainUiNavigatorState extends State<MainUiNavigator> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    addData();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
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
    //final model.User user = Provider.of<UserProvider>(context).getUser;
    //final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: const [
          Feed(),
          // const Search(),
          Text('search'),
          AddPost(),
          //Text('search'),
          // const Notification(),
          Text('notifications'),
          // ProfileScreen(
          //   uid: FirebaseAuth.instance.currentUser!.uid,
          // ),
          Text('profile'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              //color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
              // activeIcon: SvgPicture.asset(
              //   'assets/images/ic_search_selected.svg',
              // ),
              // icon    : SvgPicture.asset(
              //   'assets/images/ic_search.svg',
              // ),
              icon: Icon(
                Icons.search_outlined,
                //color: Colors.black,
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
                //color: Colors.black,
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
              //color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
              //color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   icon: CircleAvatar(
          //     radius: 15,
          //     backgroundImage: NetworkImage(userProvider.getUser.photoUrl),
          //   ),
          //   activeIcon: CircleAvatar(
          //     radius: 18,
          //     backgroundColor: Colors.black,
          //     child: CircleAvatar(
          //       radius: 17,
          //       backgroundColor: Colors.white,
          //       child: CircleAvatar(
          //           radius: 15, backgroundImage: NetworkImage(userProvider.getUser.photoUrl)),
          //     ),
          //   ),
          //   label: '',
          //   backgroundColor: Colors.white,
          // ),
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
