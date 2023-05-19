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
  String? id;
  ThreadsList({super.key, this.id});

  @override
  State<ThreadsList> createState() => _ThreadsListState();
}

class _ThreadsListState extends State<ThreadsList> {
  List<ThreadModel>? threads;
  List<String> tags = [
    "General",
    "Homework",
    "Project",
    "Exam",
    "Question",
    "Other"
  ];

  List<String> addedTags = [];

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

  Future<void> fetchThreads() async {
    try {
      await context
          .read<ChannelController>()
          .getAllThreads(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          threads = context.read<ChannelController>().getThreads;
          print("Threads length: ${threads?.length}");
        });
      });
    } catch (e) {
      Log.e("error araha fetch threads me $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Log.d("Channel Id arahi hai: ${widget.id}");
    fetchThreads();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          create_thread(context, size);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: threads == null
              ? Container(
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  child: Text("No threads yet",
                      style: Styles.bodySmall.copyWith(
                          color: const Color.fromARGB(255, 97, 65, 65)),
                      textAlign: TextAlign.center))
              : ListView.builder(
                  itemCount: threads != null ? threads!.length : 0,
                  itemBuilder: (context, index) {
                    ThreadModel thread = threads![index];
                    String timeDifference =
                        calculateTimeDifference(thread.datePosted!);
                    return Column(
                      children: [
                        ThreadTile(
                          userInitials: thread.postedBy!.fullName
                              .split(' ')
                              .map((name) => name[0])
                              .join(),
                          userFullName: thread.postedBy!.fullName,
                          timeSincePosted: timeDifference,
                          threadTitle: thread.title,
                          upVoteCount: thread.upVoteCount,
                          downVoteCount: thread.downVoteCount,
                          commentsCount: thread.commentsCount,
                          tag: thread.tags.first,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ],
                    );
                  }),
        ),
      ),
    );
  }

  Future<dynamic> create_thread(BuildContext context, Size size) {
    return showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                height: size.height, // Set a fixed height
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "Create Thread",
                          style: Styles.name.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle thread creation
                            Navigator.of(context).pop();
                          },
                          child: const Text('Post'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          radius: 28.0,
                          child: Text(
                            "HK",
                            style: Styles.labelLarge
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          "Huzaifa Karbalai",
                          style: Styles.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Flexible(
                      // Replace Expanded with Flexible
                      child: TextField(
                        maxLines: null, // Allow multiple lines
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Flexible(
                      // Replace Expanded with Flexible
                      child: TextField(
                        maxLines: null, // Allow multiple lines
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "Tags",
                      style: Styles.labelLarge,
                    ),
                    Wrap(
                      spacing: 8.0, // Set the spacing between buttons
                      runSpacing: 8.0, // Set the spacing between lines
                      children: List<Widget>.generate(
                        tags.length,
                        (index) => ElevatedButton(
                          onPressed: () {
                            setState(() {
                              addedTags.contains(tags[index]) ? 
                              addedTags.remove(tags[index]) : addedTags.add(tags[index]); 
                              Log.d("Added tags: $addedTags");
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.blue; // Set the color when pressed
                                  }
                                  return addedTags.contains(tags[index])
                                      ? Colors.blue // Set the color when selected
                                      : Colors.white; // Set the default color
                                },
                              ),
                            ),
                          child: Text(tags[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }

  String calculateTimeDifference(DateTime postedDate) {
    Duration difference = DateTime.now().difference(postedDate);
    String timeDifference;

    if (difference.inDays > 0) {
      timeDifference = "${difference.inDays}d";
    } else {
      timeDifference = "${difference.inHours}h";
    }

    return timeDifference;
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
              context, MaterialPageRoute(builder: (_) => const ThreadPage()));
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
                      const Icon(Icons.arrow_downward, size: 16.0),
                      Text(
                        widget.downVoteCount.toString(),
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
