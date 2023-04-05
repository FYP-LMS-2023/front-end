import 'package:flutter/material.dart';
import 'package:front_end/models/announcement_model.dart';
import 'package:intl/intl.dart';
import 'package:front_end/constants/fonts.dart';

import '../../models/assignment_model.dart';

//* Home Page Cards
//* This is the main card widget to build the cards on the home page
class HomeOverviewCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;

  const HomeOverviewCard({
    super.key,
    required this.title,
    this.subtitle = "",
    this.leading = const SizedBox(),
    this.trailing = const SizedBox(),
  });

  @override
  State<HomeOverviewCard> createState() => _HomeOverviewCardState();
}

class _HomeOverviewCardState extends State<HomeOverviewCard> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          //on pressed functionality
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (widget.leading != const SizedBox()) widget.leading,
                  if (widget.leading != const SizedBox())
                    const SizedBox(
                      width: 10,
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.title, style: Styles.titleMedium),
                      if (widget.subtitle != "")
                        const SizedBox(
                          height: 5,
                        ),
                      if (widget.subtitle != "")
                        Text(widget.subtitle, style: Styles.bodyMedium),
                    ],
                  ),
                ],
              ),
              if (widget.trailing != const SizedBox()) widget.trailing,
            ],
          ),
        ),
      ),
    );
  }
}

//This is a component that is being used in the cards
class CardProgressIndicator extends StatelessWidget {
  const CardProgressIndicator({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: progress / 100,
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              '${progress.toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//This is a component that is being used in the cards
class CardDueDate extends StatelessWidget {
  const CardDueDate({
    super.key,
    required this.dueDate,
  });

  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    String day = DateFormat('EEEE').format(dueDate);
    String date = DateFormat('dd-MM-yy').format(dueDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          "Due:",
          textAlign: TextAlign.right,
          style: Styles.bodySmall.copyWith(color: Colors.grey),
        ),
        Text(
          day,
          textAlign: TextAlign.right,
          style: Styles.bodySmall.copyWith(color: Colors.grey),
        ),
        Text(
          date,
          textAlign: TextAlign.right,
          style: Styles.bodySmall.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

//* Course Overview Cards
//* This is the main card widget used to buld the cards on the course overview page
class CourseOverviewCard extends StatelessWidget {
  final String type;
  final String title;
  final DateTime date;
  final String? postedBy;
  final String? description;
  final String? status;
  final Widget? progress;

  const CourseOverviewCard({
    super.key,
    required this.type,
    required this.title,
    required this.date,
    this.postedBy,
    this.description,
    this.progress,
    this.status,
  });

  //utility function to get the color of the status
  Color statusColor() {
    Color color = Colors.grey;
    switch (status) {
      case "Open":
        color = Colors.blue;
        break;
      case "Closed":
        color = Colors.grey;
        break;
      case "Late":
        color = Colors.red;
        break;
      case "Submitted":
        color = Colors.green;
        break;
      case "Returned":
        color = Colors.purple;
        break;
      case "Active":
        color = Colors.teal;
        break;
      case "Draft":
        color = Colors.lightBlue;
        break;
      case "Passed":
        color = Colors.green;
        break;
      case "Failed":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return color;
  }

  //utility function to get the time left
  String timeLeft(date) {
    Duration difference = date.difference(DateTime.now());

    String timeLeft = '';

    if (difference.inDays > 0) {
      timeLeft += '${difference.inDays}d ';
    }
    if (difference.inHours > 0) {
      timeLeft += '${difference.inHours % 24}h ';
    }
    if (difference.inMinutes > 0) {
      timeLeft += '${difference.inMinutes % 60}m ';
    }
    if (difference.inSeconds > 0 && difference.inHours == 0) {
      timeLeft += '${difference.inSeconds % 60}s ';
    }
    if (difference.inSeconds <= 0) {
      timeLeft = 'Expired';
    }

    return timeLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      type == "quiz"
                          ? 'Time Left: ${timeLeft(date)}'
                          : 'Posted by: $postedBy',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      type == "assignment" || type == "quiz"
                          ? 'Due: ${DateFormat('dd, MMMM yyyy @ hh:mm a').format(date)}'
                          : DateFormat('dd, MMMM yyyy - hh:mm a').format(date),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                status == null
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: Chip(
                          label: Text(
                            status!,
                            style:
                                Styles.bodySmall.copyWith(color: Colors.white),
                          ),
                          backgroundColor: statusColor(),
                        ),
                      ),
              ],
            ),
          ),
          description == null
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description!,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
          progress != null ? progress! : const SizedBox(),
        ],
      ),
    );
  }
}

class QuizProgress extends StatelessWidget {
  final int totalQuestions;
  final int answeredQuestions;

  const QuizProgress({
    super.key,
    required this.totalQuestions,
    required this.answeredQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width *
                (answeredQuestions / totalQuestions),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Text('$answeredQuestions/$totalQuestions Questions Answered',
                style: Styles.bodySmall.copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

//! THIS IS CURRENTLY UNDER DEVELOPMENT
//TODO - refactor the functionality of this card
class NumberOfStudentsCard extends StatelessWidget {
  final int numberOfStudents;

  const NumberOfStudentsCard({super.key, required this.numberOfStudents});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.33,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            numberOfStudents.toString(),
            style: Styles.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Students',
            style: Styles.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

//! THIS IS CURRENTLY UNDER DEVELOPMENT
//TODO - refactor the functionality of this card
class ThreeLineCard extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;

  const ThreeLineCard({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.5,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: Styles.labelLarge,
          ),
          Text(
            subtitle1,
            textAlign: TextAlign.left,
            style: Styles.bodySmall,
          ),
        ],
      ),
    );
  }
}
