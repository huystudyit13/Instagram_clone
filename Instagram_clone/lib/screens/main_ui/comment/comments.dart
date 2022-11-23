import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/comment_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/main_ui/comment/comment_card.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  CommentsScreenState createState() => CommentsScreenState();
}

class CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();
  bool cmtCheck = false;
  final ScrollController scrollController = ScrollController();
  late Stream<QuerySnapshot> data;

  @override
  void initState() {
    super.initState();
    commentEditingController.addListener(() {
      setState(() {
        cmtCheck = commentEditingController.text.isNotEmpty;
      });
    });
    data = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'].toString())
        .collection('comments')
        .orderBy("datePublished", descending: false)
        .snapshots();
  }

  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await CommentMethods().postComment(
        widget.snap['postId'].toString(),
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        if (!mounted) return;
        showMess(context, res);
      }
      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      showMess(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          translation(context).comments,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ).copyWith(right: 0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Profile(
                          uid: widget.snap['uid'].toString(),
                          isNavigate: false,
                        ),
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        widget.snap['profImage'].toString(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: widget.snap['username'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Profile(
                                        uid: widget.snap['uid'].toString(),
                                        isNavigate: false,
                                      ),
                                    ),
                                  );
                                },
                            ),
                            TextSpan(
                              text: ' ${widget.snap['description']}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      return CommentCard(
                        snap: data_,
                        postSnap: widget.snap,
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          height:
              kToolbarHeight, // 56 The height of the toolbar component of the AppBar.
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 100));
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                    },
                    controller: commentEditingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText:
                          '${translation(context).cmt_as} ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: cmtCheck
                    ? () => {
                          FocusManager.instance.primaryFocus?.unfocus(),
                          postComment(
                            user.uid,
                            user.username,
                            user.photoUrl,
                          ),
                        }
                    : null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    translation(context).post,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
