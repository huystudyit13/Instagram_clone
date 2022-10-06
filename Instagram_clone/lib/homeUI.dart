import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Instagram UI';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Post',
      style: optionStyle,
    ),
    Text(
      'Index 3: Activity',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    ),
  ];

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
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
              ],
            ),
            Icon(
              Icons.send_rounded,
              color: Colors.black,
              size: 35,
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
