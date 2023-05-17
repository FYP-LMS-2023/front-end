import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../constants/log.dart';
import '../../controllers/channel_controller.dart';
import '../../models/channel_model.dart';
import '../../models/thread_model.dart';
import 'thread_page.dart';

class ThreadsList extends StatefulWidget {
  String ? id;
  ThreadsList({super.key, this.id});

  @override
  State<ThreadsList> createState() => _ThreadsListState();
}

class _ThreadsListState extends State<ThreadsList> {

  List<ThreadModel>? threads;

  final List<String> userNames = [
    'John Doe',
    'Jane Smith',
    'Bob Johnson',
    'Emily Davis',
    'Chris Lee'
  ];

  final List<String> threadTitles = [
    'What is the best way to learn Flutter?',
    'How can I improve my UI design skills?',
    'Which is better, React or Vue?',
    'What are the most important programming concepts to learn? Right Now',
    'What are your favorite productivity tools?',
    'How do you stay motivated when working on a long-term project?',
    'What are some good resources for learning data science?',
    'What do you think of the latest Apple product releases?',
    'What is the best way to get started with machine learning?',
    'How can I become a better public speaker?',
  ];

  final List<String> tags = [
    'General',
    'Homework',
    'Project',
    'Exam',
    'Question',
    'Other'
  ];

  Future<void> fetchThreads() async {
    try {
      await context.read<ChannelController>().getAllThreads(widget.id != null ? widget.id! : "1")
        .then(
          (value) {
            setState(() {
              threads = context.read<ChannelController>().getThreads;
              print("Threads length: ${threads?.length}");
            });
          }
        );
    } catch (e) {
      Log.e("error araha fetch threads me $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Log.d("Channel Id arahi hai: ${widget.id}");
    fetchThreads();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: ListView(
          children: List.generate(
            5,
            (index) {
              final String userFullName =
                  userNames[Random().nextInt(userNames.length)];
              final String userInitials =
                  userFullName.split(' ').map((name) => name[0]).join();
              final String timeSincePosted = '${Random().nextInt(24)}h';
              final String threadTitle =
                  threadTitles[Random().nextInt(threadTitles.length)];
              final int upVoteCount = Random().nextInt(1000);
              final int downVoteCount = Random().nextInt(100);
              final int commentsCount = Random().nextInt(1000);
              final String tag = tags[Random().nextInt(6)];

              return Column(
                children: [
                  ThreadTile(
                    userInitials: userInitials,
                    userFullName: userFullName,
                    timeSincePosted: timeSincePosted,
                    threadTitle: threadTitle,
                    upVoteCount: upVoteCount,
                    downVoteCount: downVoteCount,
                    commentsCount: commentsCount,
                    tag: tag,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ThreadTile extends StatefulWidget {
  final String userInitials;
  final String userFullName;
  final String timeSincePosted;
  final String threadTitle;
  final int upVoteCount;
  final int downVoteCount;
  final int commentsCount;
  final String tag;

  const ThreadTile(
      {super.key,
      required this.userInitials,
      required this.userFullName,
      required this.timeSincePosted,
      required this.threadTitle,
      required this.upVoteCount,
      required this.downVoteCount,
      required this.commentsCount,
      required this.tag});

  @override
  State<ThreadTile> createState() => _ThreadTileState();
}

class _ThreadTileState extends State<ThreadTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ThreadPage()));
        });
      },
      child: Ink(
        padding: const EdgeInsets.all(16.0),
        decoration: boxDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                backgroundColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                radius: 28.0,
                child: Text(
                  widget.userInitials,
                  style: Styles.labelLarge.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.userFullName,
                        style: Styles.labelLarge,
                      ),
                      const HorizontalSpacer(),
                      Text(
                        widget.timeSincePosted,
                        style: Styles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.threadTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.arrow_upward, size: 16.0),
                      Text(
                        widget.upVoteCount.toString(),
                        style: Styles.labelMedium,
                      ),
                      const SizedBox(width: 8.0),
                      const Icon(Icons.comment, size: 16.0),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(widget.commentsCount.toString(),
                          style: Styles.labelMedium),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Icon(
                        Icons.flag,
                        size: 16.0,
                      ),
                      Text(widget.tag, style: Styles.labelMedium),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
