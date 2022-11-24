import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/login/login.dart';
import 'package:instagram_clone/screens/main_ui/profile/change_language.dart';
import 'package:instagram_clone/screens/main_ui/profile/change_theme.dart';
import 'package:instagram_clone/screens/main_ui/profile/edit_profile.dart';
import 'package:instagram_clone/screens/main_ui/profile/follow_detail.dart';
import 'package:instagram_clone/screens/main_ui/search/post_search.dart';

class Profile extends StatefulWidget {
  final String uid;
  final bool isNavigate;
  const Profile({Key? key, required this.uid, required this.isNavigate})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> signOut() async {
    await AuthMethods().signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  void showOptions() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(
                  thickness: 5,
                  color: Colors.grey,
                  indent: MediaQuery.of(context).size.width * 0.4,
                  endIndent: MediaQuery.of(context).size.width * 0.4,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.language_outlined,
                    color: Colors.black,
                  ),
                  title: Text(translation(context).language),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeLanguage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.color_lens_outlined,
                    color: Colors.black,
                  ),
                  title: Text(translation(context).theme),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeTheme()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.lock_outlined,
                    color: Colors.black,
                  ),
                  title: Text(translation(context).change_pass),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text(translation(context).sign_out),
                  onTap: () {
                    signOut();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getData() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      showMess(
        context,
        e.toString(),
      );
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  refresh() async {
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    userData = userSnap.data()!;
    followers = userSnap.data()!['followers'].length;
    following = userSnap.data()!['following'].length;
    // if (!mounted) return;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    refresh();
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: !widget.isNavigate ? true : false,
              leading: !widget.isNavigate
                  ? const BackButton(color: Colors.black)
                  : null,
              backgroundColor: Colors.white,
              title: Text(
                userData['username'],
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: widget.isNavigate
                  ? [
                      IconButton(
                        icon: const Icon(Icons.menu),
                        color: Colors.black,
                        iconSize: 35,
                        onPressed: () {
                          showOptions();
                        },
                      ),
                    ]
                  : null,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 40,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatColumn(
                                          postLen, translation(context).posts),
                                      buildStatGesture(followers,
                                          translation(context).followers, 0),
                                      buildStatGesture(following,
                                          translation(context).following, 1),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            userData['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                            top: 1,
                          ),
                          child: Text(
                            userData['bio'],
                          ),
                        ),
                        FirebaseAuth.instance.currentUser!.uid == widget.uid
                            ? TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                              userData: userData,
                                            )),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 30,
                                  child: Text(
                                    translation(context).edit_profile,
                                    style: const TextStyle(
                                      color: Color(0xFF3E3E3E),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : isFollowing
                                ? TextButton(
                                    onPressed: () async {
                                      await AuthMethods().followUser(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        userData['uid'],
                                      );

                                      setState(() {
                                        isFollowing = false;
                                        followers--;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 30,
                                      child: Text(
                                        translation(context).unfollow,
                                        style: const TextStyle(
                                          color: Color(0xFF3E3E3E),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      await AuthMethods().followUser(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        userData['uid'],
                                      );

                                      setState(() {
                                        isFollowing = true;
                                        followers++;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 30,
                                      child: Text(
                                        translation(context).follow,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .orderBy("datePublished", descending: true)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Post(
                                  snap: snap.data(),
                                ),
                              ),
                            ),
                            child: Image.network(
                              snap['postUrl'],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ));
  }

  InkWell buildStatGesture(int num, String label, int tab) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FollowDetail(
                    uid: widget.uid, tab: tab,
                  )),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            num.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
