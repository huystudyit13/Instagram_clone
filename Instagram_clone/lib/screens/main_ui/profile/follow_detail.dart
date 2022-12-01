import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';

class FollowDetail extends StatefulWidget {
  final String uid;
  final int tab;
  const FollowDetail({Key? key, required this.uid, required this.tab})
      : super(key: key);

  @override
  State<FollowDetail> createState() => _FollowDetailState();
}

class _FollowDetailState extends State<FollowDetail> {
  late int followers;
  late int following;
  var userData = {};
  bool isLoading = false;
  final TextEditingController followerSearchController =
      TextEditingController();
  final TextEditingController followingSearchController =
      TextEditingController();
  late int tab;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    tab = widget.tab;
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      setState(() {});
    } catch (e) {
      showMess(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 2,
            initialIndex: tab,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  userData['username'].toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                leading: const BackButton(color: Colors.black),
                bottom: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "${translation(context).followers}: $followers",
                    ),
                    Tab(
                      text: "${translation(context).following}: $following",
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200]),
                          child: TextField(
                            controller: followerSearchController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.black,
                                ),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                hintText: translation(context).search),
                            onChanged: (String _) {
                              setState(() {});
                            },
                          ),
                        ),
                        followers > 0
                            ? followerSearchController.text.isEmpty
                                ? FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('following',
                                            arrayContains: widget.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: (snapshot.data! as dynamic)
                                            .docs
                                            .length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                      uid: (snapshot.data!
                                                              as dynamic)
                                                          .docs[index]['uid'],
                                                      isNavigate: false,
                                                    ),
                                                  ),
                                                )
                                                .then((value) => setState(() {
                                                      getData();
                                                    })),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0, top: 8.0),
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    (snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['photoUrl'],
                                                  ),
                                                  radius: 24,
                                                ),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index]
                                                              ['username'],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        (snapshot.data! as dynamic)
                                                                    .docs[index]
                                                                        ['name']
                                                                    .length >
                                                                0
                                                            ? Text(
                                                                (snapshot.data!
                                                                            as dynamic)
                                                                        .docs[
                                                                    index]['name'],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            : const SizedBox(),
                                                        (snapshot.data!
                                                                    as dynamic)
                                                                .docs[index][
                                                                    'followers']
                                                                .contains(
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                            ? Text(
                                                                translation(
                                                                        context)
                                                                    .following,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                    FirebaseAuth.instance.currentUser!.uid == widget.uid ?
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        width: 75,
                                                        height: 40,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0,
                                                                  bottom: 8.0),
                                                          child: Text(
                                                            translation(context)
                                                                .remove,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF3E3E3E),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ) : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('following',
                                            arrayContains: widget.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: (snapshot.data! as dynamic)
                                            .docs
                                            .length,
                                        itemBuilder: (context, index) {
                                          return (snapshot.data! as dynamic)
                                                      .docs[index]['username']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          followerSearchController
                                                              .text) ||
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['name']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          followerSearchController
                                                              .text)
                                              ? InkWell(
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Profile(
                                                            uid: (snapshot.data!
                                                                        as dynamic)
                                                                    .docs[index]
                                                                ['uid'],
                                                            isNavigate: false,
                                                          ),
                                                        ),
                                                      )
                                                      .then((value) =>
                                                          setState(() {
                                                            getData();
                                                          })),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          (snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index]
                                                              ['photoUrl'],
                                                        ),
                                                        radius: 24,
                                                      ),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                (snapshot.data!
                                                                            as dynamic)
                                                                        .docs[index]
                                                                    [
                                                                    'username'],
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              (snapshot.data! as dynamic)
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'name']
                                                                          .length >
                                                                      0
                                                                  ? Text(
                                                                      (snapshot.data!
                                                                              as dynamic)
                                                                          .docs[index]['name'],
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    )
                                                                  : const SizedBox(),
                                                              (snapshot.data!
                                                                          as dynamic)
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'followers']
                                                                      .contains(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                  ? Text(
                                                                      translation(
                                                                              context)
                                                                          .following,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                          FirebaseAuth.instance.currentUser!.uid == widget.uid ?
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[200],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 75,
                                                              height: 40,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8.0),
                                                                child: Text(
                                                                  translation(
                                                                          context)
                                                                      .remove,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF3E3E3E),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ) : const SizedBox(),
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
                            : Text(translation(context).no_user_found),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200]),
                          child: TextField(
                            controller: followingSearchController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.black,
                                ),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                hintText: translation(context).search),
                            onChanged: (String _) {
                              setState(() {});
                            },
                          ),
                        ),
                        following > 0
                            ? followingSearchController.text.isEmpty
                                ? FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('followers',
                                            arrayContains: widget.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: (snapshot.data! as dynamic)
                                            .docs
                                            .length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                      uid: (snapshot.data!
                                                              as dynamic)
                                                          .docs[index]['uid'],
                                                      isNavigate: false,
                                                    ),
                                                  ),
                                                )
                                                .then((value) => setState(() {
                                                      tab = 1;
                                                      getData();
                                                    })),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0, top: 8.0),
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    (snapshot.data! as dynamic)
                                                            .docs[index]
                                                        ['photoUrl'],
                                                  ),
                                                  radius: 24,
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['username'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    (snapshot.data! as dynamic)
                                                                .docs[index]
                                                                    ['name']
                                                                .length >
                                                            0
                                                        ? Text(
                                                            (snapshot.data!
                                                                        as dynamic)
                                                                    .docs[index]
                                                                ['name'],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('followers',
                                            arrayContains: widget.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: (snapshot.data! as dynamic)
                                            .docs
                                            .length,
                                        itemBuilder: (context, index) {
                                          return (snapshot.data! as dynamic)
                                                      .docs[index]['username']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          followingSearchController
                                                              .text) ||
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['name']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          followingSearchController
                                                              .text)
                                              ? InkWell(
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Profile(
                                                            uid: (snapshot.data!
                                                                        as dynamic)
                                                                    .docs[index]
                                                                ['uid'],
                                                            isNavigate: false,
                                                          ),
                                                        ),
                                                      )
                                                      .then((value) =>
                                                          setState(() {
                                                            tab = 1;
                                                            getData();
                                                          })),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          (snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index]
                                                              ['photoUrl'],
                                                        ),
                                                        radius: 24,
                                                      ),
                                                      title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            (snapshot.data!
                                                                        as dynamic)
                                                                    .docs[index]
                                                                ['username'],
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          (snapshot.data! as dynamic)
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'name']
                                                                      .length >
                                                                  0
                                                              ? Text(
                                                                  (snapshot.data!
                                                                              as dynamic)
                                                                          .docs[
                                                                      index]['name'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey),
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
                            : Text(translation(context).no_user_found),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
