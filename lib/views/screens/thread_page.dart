import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/utils/functions/status_color.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({super.key});

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  bool isCommentBoxVisible = false;

  void _toggleCommentBox() {
    setState(() {
      isCommentBoxVisible = !isCommentBoxVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: 'Thread',
        subtitle: 'Course Code - Course Name',
        onMenuPressed: () {},
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                              backgroundColor: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              child: Text('FL',
                                  style: Styles.labelLarge
                                      .copyWith(color: Colors.white)),
                            ),
                            const HorizontalSpacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Full Name', style: Styles.titleMedium),
                                // const SizedBox(height: 4.0),
                                Text(
                                  '2 hours ago',
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
                              "Exam",
                              style: Styles.bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                            backgroundColor: status_color("Exam"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thread Description goes here. Write some long text here to explain the question in details so that others in the class may respond to them and help you out.',
                            style: Styles.bodyLarge,
                            maxLines: 10,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_upward),
                                onPressed: () {},
                              ),
                              Text(
                                '10',
                                style: Styles.labelLarge,
                              ),
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {},
                              ),
                              Text(
                                '3',
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    child: Text('FL',
                                        style: Styles.labelLarge
                                            .copyWith(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Full Name',
                                            style: Styles.labelLarge),
                                        const SizedBox(height: 4.0),
                                        const Text(
                                          'Comment text goes here. Write anything to answer to the question being asked.',
                                          style: TextStyle(fontSize: 14.0),
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
                                              onPressed: () {},
                                            ),
                                            Text(
                                              "Reply",
                                              style: Styles.labelMedium,
                                            ),
                                            // const Text('5'),

                                            IconButton(
                                              icon: const Icon(
                                                Icons.arrow_upward,
                                                size: 20,
                                              ),
                                              onPressed: () {},
                                            ),
                                            Text(
                                              "10",
                                              style: Styles.labelMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {
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
                                              backgroundColor: Colors.primaries[
                                                  Random().nextInt(
                                                      Colors.primaries.length)],
                                              child: Text('FL',
                                                  style: Styles.labelLarge
                                                      .copyWith(
                                                          color: Colors.white)),
                                            ),
                                            // const SizedBox(width: 8.0),
                                            const HorizontalSpacer(),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Full Name',
                                                      style: Styles.labelLarge),
                                                  const SizedBox(height: 4.0),
                                                  const Text(
                                                    'Reply text goes here. Write if you thing this comment is correct or false.',
                                                    style: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.arrow_upward,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                      Text(
                                                        "10",
                                                        style:
                                                            Styles.labelMedium,
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                cursorColor: Colors.black,
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
                    onPressed: () {},
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
