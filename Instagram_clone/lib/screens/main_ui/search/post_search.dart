import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/comment_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/post_methods.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/main_ui/comment/comment_card.dart';
import 'package:instagram_clone/screens/main_ui/news_feed/like_animation.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final snap;
  const Post({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLikeAnimating = false;
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
        cmtCheck = commentEditingController.text.toString().trim().isNotEmpty;
      });
    });
    data = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'].toString())
        .collection('comments')
        .orderBy("datePublished", descending: false)
        .snapshots();
  }

  deletePost(String postId) async {
    try {
      await PostMethods().deletePost(postId);
    } catch (err) {
      showMess(
        context,
        err.toString(),
      );
    }
  }

  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await CommentMethods().postComment(
        widget.snap['postId'].toString(),
        commentEditingController.text.toString().trim(),
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
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          translation(context).explore,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            // HEADER SECTION OF THE POST
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
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
                      radius: 16,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            child: Text(
                              widget.snap['username'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.snap['uid'].toString() == user.uid
                      ? IconButton(
                          onPressed: () {
                            showDialog(
                              useRootNavigator: false,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                        translation(context).delete,
                                      ]
                                          .map(
                                            (e) => InkWell(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  child: Text(e),
                                                ),
                                                onTap: () {
                                                  deletePost(
                                                    widget.snap['postId']
                                                        .toString(),
                                                  );
                                                  Navigator.of(context).pop();
                                                  showMess(
                                                    context,
                                                    translation(context)
                                                        .deleted,
                                                  );
                                                }),
                                          )
                                          .toList()),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            size: 30,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            // IMAGE SECTION OF THE POST
            GestureDetector(
              onDoubleTap: () {
                PostMethods().likePost(widget.snap['postId'].toString(),
                    user.uid, widget.snap['likes'], true);
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: NetworkImage(
                      widget.snap['postUrl'].toString(),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: <Widget>[
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                    onPressed: () => PostMethods().likePost(
                        widget.snap['postId'].toString(),
                        user.uid,
                        widget.snap['likes'],
                        false),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/message.svg',
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                    iconSize: 30,
                  ),
                ))
              ],
            ),
            //DESCRIPTION AND NUMBER OF COMMENTS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.snap['likes'].length > 0
                      ? DefaultTextStyle(
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          child: widget.snap['likes'].length == 1
                              ? Text(
                                  "${widget.snap['likes'].length} ${translation(context).like}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "${widget.snap['likes'].length} ${translation(context).likes}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))
                      : const SizedBox(height: 0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: const TextStyle(
                        color: Colors.black,
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
      bottomNavigationBar: Container(
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
                    hintText: '${translation(context).cmt_as} ${user.username}',
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
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: cmtCheck
                    ? Text(
                        translation(context).post,
                        style: const TextStyle(color: Colors.blue),
                      )
                    : Text(
                        translation(context).post,
                        style: const TextStyle(color: Colors.grey),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
