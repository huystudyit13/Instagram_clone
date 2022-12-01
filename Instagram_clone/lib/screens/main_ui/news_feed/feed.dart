import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/user_provider.dart';
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
  final ScrollController scrollController = ScrollController();
  late Stream<QuerySnapshot> data;

  @override
  void initState() {
    super.initState();
    data = FirebaseFirestore.instance
        .collection('posts')
        .orderBy("datePublished", descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              scrollController
                  .jumpTo(scrollController.position.minScrollExtent);
            });
          },
          child: SvgPicture.asset(
            'assets/images/logo_insta.svg',
            color: Colors.black,
            height: 35,
          ),
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
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(user.photoUrl),
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
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(translation(context).your_story),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: data,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data_ =
                          document.data()! as Map<String, dynamic>;
                      return PostCard(
                        snap: data_,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
