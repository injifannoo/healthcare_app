import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/Post/like_animation.dart';
import 'package:healthcare_app/Post/post.dart';
import 'package:healthcare_app/Providers/provider.dart';
import 'package:healthcare_app/models/user.dart';
import 'package:healthcare_app/utils/colors.dart';
import 'package:healthcare_app/utils/image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/model.dart' as model;
import 'comment.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc('postId')
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
  }

  // @override
  // Widget build(BuildContext context) {
  //   final model.Users user = Provider.of<UserProvider>(context).getCurrentUser;
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print("User current id is ${userId}");
    if (userId != null) {
      Provider.of<UserProvider>(context, listen: false)
          .fetchCurrentUser(userId);
    }
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final Users user = userProvider.getCurrentUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //header section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['ProfileImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.snap['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'] == user.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map(
                                      (e) => InkWell(
                                        onTap: () async {
                                          await postMethod().deletePost(
                                              widget.snap['postId']);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
              ],
            ),
          ),
          //image section
          GestureDetector(
            onDoubleTap: () async {
              await postMethod().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap['PostUrl'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
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
              )
            ]),
          ),
          //comment section
          Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await postMethod().likePost(
                      widget.snap['postId'].toString(),
                      user.uid,
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.red,
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ))
            ],
          ),
          //Discription and number of comment
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['name'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: '  ${widget.snap['description']}',
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(snap: widget.snap),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all $commentLen comments',
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
