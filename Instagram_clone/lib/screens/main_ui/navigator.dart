import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          // const Home(),
          Text('home'),
          // const Search(),
          Text('search'),
          // const AddPost(),
          Text('add'),
          // const Notification(),
          Text('notifications'),
          // ProfileScreen(
          //   uid: FirebaseAuth.instance.currentUser!.uid,
          // ),
          Text('profile'),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: (_page == 0)
                ? const Icon(
                    Icons.home,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: (_page == 1)
                  ? SvgPicture.asset(
                      'assets/images/ic_search_selected.svg',
                      //color: Colors.black,
                    )
                  : SvgPicture.asset(
                      'assets/images/ic_search.svg',
                      //color: Colors.black,
                    ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: (_page == 2)
                  ? const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.add_circle_outline,
                      color: Colors.black,
                    ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: (_page == 3)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: Colors.black,
                  ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: (_page == 4)
                ? const Icon(
                    Icons.person,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.person_outlined,
                    color: Colors.black,
                  ),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
