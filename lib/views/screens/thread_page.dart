import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/user_controller.dart';
import 'package:front_end/utils/functions/status_color.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

import '../../constants/icons.dart';
import '../../constants/log.dart';
import '../../controllers/channel_controller.dart';
import '../../controllers/comment_controller.dart';
import '../../controllers/reply_controller.dart';
import '../../controllers/thread_controller.dart';
import '../../models/comment_model.dart';
import '../../models/thread_model.dart';
import '../widgets/loading.dart';

class ThreadPage extends StatefulWidget {
  String? id;
  ThreadPage({super.key, this.id});
  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  bool isCommentBoxVisible = false;
  ThreadModel? thread;
  bool showReplyTextField = false; // for reply text field
  int selectedCommentIndex = -1;
  String? userId;
  final _formKey = GlobalKey<FormState>();

  void _toggleCommentBox() {
    setState(() {
      isCommentBoxVisible = !isCommentBoxVisible;
    });
  }

  Future<void> fetchThreadDetails() async {
    Log.i("fetching thread details");
    try {
      await context
          .read<ChannelController>()
          .getThreadDetails(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          thread = context.read<ChannelController>().getThreadObject;
        });
      });

      Log.d("Thread details:  ${thread!.comments}");
    } catch (e) {
      Log.e("error araha fetch thread details me $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchThreadDetails();
    userId = context.read<UserController>().getUser!.id;
    Log.d("User ID: $userId");
  }

  String calculateTimeDifference(DateTime? postedDate) {
    Duration difference = DateTime.now().difference(postedDate!);
    String timeDifference;

    if (difference.inDays > 0) {
      timeDifference = "${difference.inDays}d";
    } else {
      timeDifference = "${difference.inHours}h";
    }

    return timeDifference;
  }

  @override
  Widget build(BuildContext context) {
    String timeDifference = calculateTimeDifference(
        thread != null ? thread!.datePosted : DateTime.now());
    final commentController = TextEditingController();
    final replyController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: 'Thread',
        onMenuPressed: () {},
      ),
      body: thread == null
          ? const Loading()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.primaries[thread != null
                                    ? thread!.postedBy!.fullName[0].hashCode % Colors.primaries.length
                                    : 0],
                                    child: Text(
                                        thread != null
                                            ? thread!.postedBy!.fullName
                                                .split(' ')
                                                .map((name) => name[0])
                                                .join()
                                            : "FL",
                                        style: Styles.labelLarge
                                            .copyWith(color: Colors.white)),
                                  ),
                                  const HorizontalSpacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          thread != null
                                              ? thread!.postedBy!.fullName
                                              : "Full Name",
                                          style: Styles.titleMedium),
                                      // const SizedBox(height: 4.0),
                                      Text(
                                        timeDifference,
                                        style: Styles.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerRight,
                                child: Chip(
                                  label: Text(
                                    thread != null ? thread!.tags[0] : "Exam",
                                    style: Styles.bodySmall
                                        .copyWith(color: Colors.white),
                                    maxLines: 5,
                                  ),
                                  backgroundColor: status_color(thread != null
                                      ? thread!.tags[0]
                                      : "Exam"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  thread != null ? thread!.title : "Title",
                                  style: Styles.bodyLarge,
                                  maxLines: 10,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  thread != null
                                      ? thread!.description
                                      : "Description",
                                  style: Styles.bodyMedium,
                                  maxLines: 10,
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(MyIcons.up),
                                      color: thread!.upvotes.contains(userId)
                                          ? Colors.green
                                          : null,
                                      onPressed: () async {
                                        bool c =
                                            thread!.upvotes.contains(userId);

                                        await context
                                            .read<ThreadController>()
                                            .upvoteThread(thread!.id);
                                        Log.d(
                                            "Thread Upvotes list: ${thread!.upvotes}");
                                        Log.d("User Id is: $userId");
                                        Log.d(
                                            "Thread Upvotes contain UserID: $c");
                                        setState(() {
                                          fetchThreadDetails();
                                        });
                                      },
                                    ),
                                    Text(
                                      thread != null
                                          ? thread!.upVoteCount.toString()
                                          : "-1",
                                      style: Styles.labelLarge,
                                    ),
                                    IconButton(
                                      icon: Icon(MyIcons.down),
                                      color: thread!.downvotes.contains(userId)
                                          ? Colors.red
                                          : null,
                                      onPressed: () async {
                                        await context
                                            .read<ThreadController>()
                                            .downvoteThread(thread!.id);
                                        setState(() {
                                          fetchThreadDetails();
                                        });
                                      },
                                    ),
                                    Text(
                                      thread != null
                                          ? thread!.downVoteCount.toString()
                                          : "-1",
                                      style: Styles.labelLarge,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.comment),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      thread != null
                                          ? thread!.commentsCount.toString()
                                          : "-1",
                                      style: Styles.labelLarge,
                                    ),
                                  ],
                                ),
                              ]),
                          const Divider(),
                          const Subheading(text: "Comments"),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                thread != null ? thread!.comments.length : 0,
                            itemBuilder: (context, index) {
                              CommentModel comment = thread!.comments[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                           backgroundColor: Colors.primaries[thread != null
                                            ? comment.postedBy!.fullName[0].hashCode % Colors.primaries.length
                                            : 0],
                                          child: Text(
                                              comment.postedBy!.fullName
                                                  .split(' ')
                                                  .map((name) => name[0])
                                                  .join(),
                                              style: Styles.labelLarge.copyWith(
                                                  color: Colors.white)),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(comment.postedBy!.fullName,
                                                  style: Styles.labelLarge),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                comment.comment,
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.reply,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        selectedCommentIndex =
                                                            index;
                                                        showReplyTextField =
                                                            !showReplyTextField;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "Reply",
                                                    style: Styles.labelMedium,
                                                  ),
                                                  // const Text('5'),
                                                  IconButton(
                                                    icon: Icon(MyIcons.up, size: 20,),
                                                    color: comment.upvotes
                                                            .contains(userId)
                                                        ? Colors.green
                                                        : null,
                                                    onPressed: () async {
                                                      await context
                                                          .read<
                                                              CommentController>()
                                                          .upvoteComment(
                                                              comment.id);
                                                      setState(() {
                                                        fetchThreadDetails();
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    comment.upVoteCount
                                                        .toString(),
                                                    style: Styles.labelMedium,
                                                  ),
                                                  IconButton(
                                                    icon: Icon(MyIcons.down, size: 20,),
                                                    color: comment.downvotes
                                                            .contains(userId)
                                                        ? Colors.red
                                                        : null,
                                                    onPressed: () async {
                                                      await context
                                                          .read<
                                                              CommentController>()
                                                          .downvoteComment(
                                                              comment.id);
                                                      setState(() {
                                                        fetchThreadDetails();
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    comment.downVoteCount
                                                        .toString(),
                                                    style: Styles.labelMedium,
                                                  ),
                                                ],
                                              ),
                                              if (showReplyTextField &&
                                                  selectedCommentIndex ==
                                                      index) // Add this condition
                                                Container(
                                                  color: Colors.white,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Form(
                                                    key: _formKey,
                                                    child: TextFormField(
                                                      controller: replyController,
                                                      cursorColor: Colors.black,
                                                      validator: (value) {
                                                        if (value!.trim().isEmpty) {
                                                          return 'Please enter a reply';
                                                        } 
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        border:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.black),
                                                        ), // your color
                                                  
                                                        hintText:
                                                            'Write a reply...',
                                                        suffixIcon: IconButton(
                                                          icon: const Icon(
                                                            Icons.send,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () async {
                                                            if (_formKey.currentState!.validate()) {
                                                              await context
                                                                  .read<
                                                                      ReplyController>()
                                                                  .createReply(
                                                                    comment.id,
                                                                    replyController
                                                                        .text,
                                                                  );
                                                              setState(() {
                                                                fetchThreadDetails();
                                                                showReplyTextField =
                                                                    false;
                                                                selectedCommentIndex =
                                                                    -1;
                                                              });
                                                              replyController
                                                                  .clear();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: comment.replies.length,
                                      itemBuilder: (context, index) {
                                        Reply reply = comment.replies[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 45.0, top: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                  backgroundColor: Colors.primaries[thread != null
                                                  ? reply.postedBy!.fullName[0].hashCode % Colors.primaries.length
                                                  : 0],
                                                    child: Text(
                                                        reply.postedBy!.fullName
                                                            .split(' ')
                                                            .map((name) =>
                                                                name[0])
                                                            .join(),
                                                        style: Styles.labelLarge
                                                            .copyWith(
                                                                color: Colors
                                                                    .white)),
                                                  ),
                                                  // const SizedBox(width: 8.0),
                                                  const HorizontalSpacer(),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            reply.postedBy!
                                                                .fullName,
                                                            style: Styles
                                                                .labelLarge),
                                                        const SizedBox(
                                                            height: 4.0),
                                                        Text(
                                                          reply.reply,
                                                          style: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        const SizedBox(
                                                            height: 4.0),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IconButton(
                                                              icon: Icon(MyIcons.up, size: 20,),
                                                              color: reply
                                                                      .upvotes
                                                                      .contains(
                                                                          userId)
                                                                  ? Colors.green
                                                                  : null,
                                                              onPressed:
                                                                  () async {
                                                                await context
                                                                    .read<
                                                                        ReplyController>()
                                                                    .upvoteReply(
                                                                        reply
                                                                            .id);
                                                                setState(() {
                                                                  fetchThreadDetails();
                                                                });
                                                              },
                                                            ),
                                                            Text(
                                                              reply.upVoteCount
                                                                  .toString(),
                                                              style: Styles
                                                                  .labelMedium,
                                                            ),
                                                            IconButton(
                                                              icon: Icon(MyIcons.down, size: 20,),
                                                              color: reply
                                                                      .downvotes
                                                                      .contains(
                                                                          userId)
                                                                  ? Colors.red
                                                                  : null,
                                                              onPressed:
                                                                  () async {
                                                                await context
                                                                    .read<
                                                                        ReplyController>()
                                                                    .downvoteReply(
                                                                        reply
                                                                            .id);
                                                                setState(() {
                                                                  fetchThreadDetails();
                                                                });
                                                              },
                                                            ),
                                                            Text(
                                                              reply
                                                                  .downVoteCount
                                                                  .toString(),
                                                              style: Styles
                                                                  .labelMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!showReplyTextField)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: commentController,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter a comment';
                            } 
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.black),
                            ), // your color
                      
                            hintText: 'Write a comment...',
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await context
                                      .read<CommentController>()
                                      .createComment(
                                        thread!.id,
                                        commentController.text,
                                      );
                                  setState(() {
                                    fetchThreadDetails();
                                  });
                                  commentController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
