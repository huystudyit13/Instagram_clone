import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/start.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Post',
      style: optionStyle,
    ),
    const Text(
      'Index 3: Activity',
      style: optionStyle,
    ),
    const Text(
      'Index 4: Profile',
    )
  ];


  Future<void> signOut() async {
    await AuthMethods().signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Start()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.black,
                  size: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                  child: Image.asset(
                    'assets/images/title.png',
                    fit: BoxFit.cover,
                    height: 60,
                  ),
                ),
            IconButton(
              icon: const Icon(Icons.send_rounded),
              color: Colors.black,
              onPressed: signOut,
              //size: 35,
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black38,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black38,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black38,
            ),
            activeIcon: Icon(
              Icons.add_box,
              color: Colors.black,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.black38,
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/images/UET.png'),
            ),
            activeIcon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/UET.png'),
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 30.0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }

}

Widget HomeScreen() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: const <Widget>[
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/images/UET.png'),
                        ),
                        Positioned(
                            right: -2.0,
                            bottom: -2.0,
                            child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage:
                                      AssetImage('assets/images/addstory.png'),
                                )))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Your Story'),
                    ),
                  ],
                ),
              ),

              //instagrammer1
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 39,
                      backgroundImage:
                          AssetImage('assets/images/storybackground.jpg'),
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/instagrammer1.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                          width: 100,
                          child: Center(
                              child: Text(
                            'ThuongDuyDao',
                            overflow: TextOverflow.ellipsis,
                          ))),
                    ),
                  ],
                ),
              ),

              //instagrammer2
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 39,
                      backgroundImage:
                          AssetImage('assets/images/storybackground.jpg'),
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/instagrammer2.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                          width: 100,
                          child: Center(
                              child: Text(
                            'itsnothoaanhtuc',
                            overflow: TextOverflow.ellipsis,
                          ))),
                    ),
                  ],
                ),
              ),

              //instagrammer3
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 39,
                      backgroundImage:
                          AssetImage('assets/images/storybackground.jpg'),
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/instagrammer3.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                          width: 100,
                          child: Center(
                              child: Text(
                            'duyCow',
                            overflow: TextOverflow.ellipsis,
                          ))),
                    ),
                  ],
                ),
              ),

              //instagrammer4
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 39,
                      backgroundImage:
                          AssetImage('assets/images/storybackground.jpg'),
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/instagrammer4.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                          width: 100,
                          child: Center(
                              child: Text(
                            'thuong.daoduy.3',
                            overflow: TextOverflow.ellipsis,
                          ))),
                    ),
                  ],
                ),
              ),

              //instagrammer5
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          AssetImage('assets/images/instagrammer5.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            'longVu',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //instagrammer6
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          AssetImage('assets/images/instagrammer6.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            'meme',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Column(
          children: <Widget>[
            Post(
              true,
              1,
              'ThuongDuyDao',
              '144 Xuân Thủy, Hà Lội',
            ),
            Post(
              true,
              2,
              'itsnothoaanhtuc',
              '199 Hồ Tùng Mậu, Hà Lội',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget Post(hasStory, numOfUser, name, location) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              hasStory
                  ? smallProfileWithStory(numOfUser)
                  : smallProfileWithoutStory(numOfUser),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(location,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                      )),
                ],
              )
            ],
          ),
          Image.asset(
            'assets/images/more.png',
            width: 40,
          )
        ],
      ),
      Image.asset(
          'assets/images/instagrammer${numOfUser}_post.png'),
    ],
  );
}

Widget smallProfileWithStory(numOfUser) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
        radius: 24,
        backgroundImage: const AssetImage('assets/images/storybackground.jpg'),
        child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage('assets/images/instagrammer$numOfUser.png'),
            ))),
  );
}

Widget smallProfileWithoutStory(numOfUser) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage('assets/images/instagrammer$numOfUser.png'),
    ),
  );
}

