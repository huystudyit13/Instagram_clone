import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/screens/main_ui/news_feed/post.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late bool isShowUsers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isShowUsers = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            !isShowUsers
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowUsers = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              translation(context).search,
                              style: const TextStyle(color: Color(0xFF3E3E3E)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                isShowUsers = false;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200]),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        Divider.createBorderSide(context),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        Divider.createBorderSide(context),
                                  ),
                                  contentPadding: const EdgeInsets.all(8.0),
                                  hintText: translation(context).search),
                              onChanged: (String _) {
                                setState(() {});
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            !isShowUsers
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .orderBy('datePublished')
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return StaggeredGridView.countBuilder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) => GestureDetector(
                          //           onTap: () => Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (context) => PostCard(
                          // snap: (snapshot.data! as dynamic).docs[index],
                          //               ),
                          //             ),
                          //           ),
                          onTap: () {},
                          child: Image.network(
                            (snapshot.data! as dynamic).docs[index]['postUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        staggeredTileBuilder: (index) => StaggeredTile.count(
                            (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      );
                    },
                  )
                : searchController.text.isNotEmpty
                    ? FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .where(
                              'username',
                              isGreaterThanOrEqualTo: searchController.text,
                            )
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                      uid: (snapshot.data! as dynamic)
                                          .docs[index]['uid'],
                                      isNavigate: false,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      (snapshot.data! as dynamic).docs[index]
                                          ['photoUrl'],
                                    ),
                                    radius: 16,
                                  ),
                                  title: Text(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['username'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
