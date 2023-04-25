import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'dart:math';

import 'thread_page.dart';

class ThreadsList extends StatelessWidget {
  ThreadsList({super.key});

  final List<String> userNames = ['John Doe', 'Jane Smith', 'Bob Johnson', 'Emily Davis', 'Chris Lee'];
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
final List<String> tags = ['General', 'Homework', 'Project', 'Exam', 'Question', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Threads'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: List.generate(10, (index) {
          final String userFullName = userNames[Random().nextInt(userNames.length)];
          final String userInitials = userFullName.split(' ').map((name) => name[0]).join();
          final String timeSincePosted = '${Random().nextInt(24)}h';
          final String threadTitle = threadTitles[Random().nextInt(threadTitles.length)];
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
              const Divider(thickness: 1.2,)
            ],
          );
        }
        )
      )
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

  const ThreadTile({super.key, 
    required this.userInitials,
    required this.userFullName,
    required this.timeSincePosted,
    required this.threadTitle,
    required this.upVoteCount,
    required this.downVoteCount,
    required this.commentsCount,
    required this.tag
  });

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
          context,
          MaterialPageRoute(builder: (_) => ThreadPage()) 
        );
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28.0,
              child: Text(widget.userInitials,),
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
                      const SizedBox(width: 8.0),
                      Text('• ${widget.timeSincePosted}', style: Styles.labelLarge,),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  
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
                      Text(widget.upVoteCount.toString(), style: Styles.labelMedium,),
                      const SizedBox(width: 8.0),
                      // const Icon(Icons.arrow_downward, size: 16.0),
                      // Text(widget.downVoteCount.toString(),style: Styles.labelMedium),
                      // const SizedBox(width: 8.0),
                      const Icon(Icons.comment, size: 16.0),
                      SizedBox(width: 4,),
                      Text(widget.commentsCount.toString(),style: Styles.labelMedium),
                      const SizedBox(width: 8.0,),
                      const Icon(Icons.flag, size: 16.0,),
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

