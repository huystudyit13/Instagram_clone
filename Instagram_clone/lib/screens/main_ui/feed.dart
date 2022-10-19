import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/start.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  Future<void> signOut() async {
    await AuthMethods().signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Start()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          'assets/images/logo_insta.svg',
          color: Colors.black,
          height: 35,
        ),
        actions: [
            IconButton(
              icon: const Icon(Icons.send_rounded),
              color: Colors.black,
              onPressed: signOut,
              iconSize: 35,
            ),
          ],
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
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
        ),
      ),

    );
  }

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
                      //fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(location,
                      // style: const TextStyle(
                      //   fontFamily: 'Roboto',
                      // )
                    ),
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

