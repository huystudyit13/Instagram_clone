import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/search_history.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/screens/main_ui/search/post_search.dart';

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
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
                          child: searchController.text.isEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      isShowUsers = false;
                                    });
                                    searchController.clear();
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(Icons.clear),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {});
                                    searchController.clear();
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
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                        .orderBy('datePublished', descending: true)
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
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Post(
                                snap: (snapshot.data! as dynamic)
                                    .docs[index]
                                    .data(),
                              ),
                            ),
                          ),
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
                              return (snapshot.data! as dynamic)
                                          .docs[index]['username']
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchController.text) ||
                                      (snapshot.data! as dynamic)
                                          .docs[index]['name']
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchController.text)
                                  ? InkWell(
                                      onTap: () {
                                        SearchHistory().addSearchHistory(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['uid'],
                                            (snapshot.data! as dynamic)
                                                .docs[index]['username'],
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            (snapshot.data! as dynamic)
                                                .docs[index]['name'],
                                            (snapshot.data! as dynamic)
                                                .docs[index]['photoUrl']);
                                        FocusScope.of(context).unfocus();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Profile(
                                              uid: (snapshot.data! as dynamic)
                                                  .docs[index]['uid'],
                                              isNavigate: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, top: 8.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              (snapshot.data! as dynamic)
                                                  .docs[index]['photoUrl'],
                                            ),
                                            radius: 32,
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (snapshot.data! as dynamic)
                                                    .docs[index]['username'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              (snapshot.data! as dynamic)
                                                          .docs[index]['name']
                                                          .length >
                                                      0
                                                  ? Text(
                                                      (snapshot.data!
                                                              as dynamic)
                                                          .docs[index]['name'],
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  : const SizedBox(),
                                              (snapshot.data! as dynamic)
                                                      .docs[index]['followers']
                                                      .contains(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid)
                                                  ? Text(
                                                      translation(context)
                                                          .following,
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          );
                        },
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16.0, bottom: 8.0),
                            child: Text(
                              translation(context).recent,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('search')
                                .orderBy("time", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    (snapshot.data! as dynamic).docs.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      SearchHistory().addSearchHistory(
                                          (snapshot.data! as dynamic)
                                              .docs[index]['uid'],
                                          (snapshot.data! as dynamic)
                                              .docs[index]['username'],
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          (snapshot.data! as dynamic)
                                              .docs[index]['name'],
                                          (snapshot.data! as dynamic)
                                              .docs[index]['profilePic']);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Profile(
                                            uid: (snapshot.data! as dynamic)
                                                .docs[index]['uid'],
                                            isNavigate: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, top: 8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['profilePic'],
                                          ),
                                          radius: 32,
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['username'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                (snapshot.data! as dynamic)
                                                            .docs[index]['name']
                                                            .length >
                                                        0
                                                    ? Text(
                                                        (snapshot.data!
                                                                    as dynamic)
                                                                .docs[index]
                                                            ['name'],
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  CollectionReference search =
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection('search');
                                                  search
                                                      .doc((snapshot.data!
                                                              as dynamic)
                                                          .docs[index]['uid'])
                                                      .delete();
                                                },
                                                icon: const Icon(Icons.clear)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
