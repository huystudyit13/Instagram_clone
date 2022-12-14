import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/comment_methods.dart';
import 'package:instagram_clone/resources/language_controller.dart';
import 'package:instagram_clone/resources/user_provider.dart';
import 'package:instagram_clone/resources/utils.dart';
import 'package:instagram_clone/screens/main_ui/news_feed/like_animation.dart';
import 'package:instagram_clone/screens/main_ui/profile/profile.dart';
import 'package:intl/intl.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final Map<String, dynamic> snap;
  final postSnap;
  const CommentCard({Key? key, required this.snap, required this.postSnap})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  deleteComment(String postId) async {
    try {
      await CommentMethods()
          .deleteComment(postId, widget.snap['commentId']);
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.max,
        children: [
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
              backgroundImage: NetworkImage(
                widget.snap['profilePic'],
              ),
              radius: 18,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
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
                            text: widget.snap['name'],
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: ' ${widget.snap['text']}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(
                            widget.snap['datePublished'].toDate(),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                          width: 10,
                        ),
                        widget.snap['likes'].length > 0
                            ? DefaultTextStyle(
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w800),
                                child: widget.snap['likes'].length == 1
                                    ? Text(
                                        "${widget.snap['likes'].length} ${translation(context).like}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )
                                    : Text(
                                        "${widget.snap['likes'].length} ${translation(context).likes}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ))
                            : const SizedBox(height: 0),
                        const SizedBox(
                          height: 0,
                          width: 10,
                        ),
                        widget.snap['uid'].toString() == user.uid ||
                                widget.postSnap['uid'].toString() == user.uid
                            ? DefaultTextStyle(
                                style: Theme.of(context).textTheme.subtitle2!,
                                child: InkWell(
                                    child: Text(translation(context).delete),
                                    onTap: () {
                                      deleteComment(
                                        widget.postSnap['postId'].toString(),
                                      );
                                    }),
                              )
                            : const SizedBox(height: 0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          LikeAnimation(
            isAnimating: widget.snap['likes'].contains(user.uid),
            smallLike: true,
            child: IconButton(
              icon: widget.snap['likes'].contains(user.uid)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 18,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      size: 18,
                    ),
              onPressed: () => CommentMethods().likeComment(
                  widget.postSnap['postId'].toString(),
                  user.uid,
                  widget.snap['likes'],
                  widget.snap['commentId']),
            ),
          )
        ],
      ),
    );
  }
}
