import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:instagram_clone/screens/login/login.dart';
import 'package:instagram_clone/screens/main_ui/news_feed/post.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          'assets/images/logo_insta.svg',
          color: Colors.black,
          height: 35,
          key: const ValueKey('logo'),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/message.svg',
              color: Colors.black,
            ),
            color: Colors.black,
            iconSize: 35,
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy("datePublished", descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 16.0),
                                    child: Column(
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundImage:
                                                  NetworkImage(user.photoUrl),
                                            ),
                                            const Positioned(
                                                right: -2.0,
                                                bottom: -2.0,
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.white,
                                                )),
                                            Positioned(
                                                right: -14.0,
                                                bottom: -14.0,
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add_circle,
                                                      color: Colors.blue,
                                                    )))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Text(
                                              translation(context).your_story),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PostCard(
                              snap: snapshot.data!.docs[index].data(),
                            ),
                          ],
                        );
                      } else {
                        return PostCard(
                          snap: snapshot.data!.docs[index].data(),
                        );
                      }
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget smallProfileWithStory(numOfUser) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: CircleAvatar(
//         radius: 24,
//         backgroundImage: const AssetImage('assets/images/storybackground.jpg'),
//         child: CircleAvatar(
//             radius: 22,
//             backgroundColor: Colors.white,
//             child: CircleAvatar(
//               radius: 20,
//               backgroundImage:
//                   AssetImage('assets/images/instagrammer$numOfUser.png'),
//             ))),
//   );
// }
//
// Widget smallProfileWithoutStory(numOfUser) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: CircleAvatar(
//       radius: 20,
//       backgroundImage: AssetImage('assets/images/instagrammer$numOfUser.png'),
//     ),
//   );
// }
