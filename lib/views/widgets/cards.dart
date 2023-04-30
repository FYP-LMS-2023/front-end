import 'package:flutter/material.dart';
import 'package:front_end/utils/functions/status_color.dart';
import 'package:front_end/utils/functions/time_left.dart';
import 'package:intl/intl.dart';
import 'package:front_end/constants/fonts.dart';

//* Home Page Cards/////////////////////////////////////////////////////////////////////////////
class HomeOverviewCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;
  final Function onPressed;

  const HomeOverviewCard({
    super.key,
    required this.title,
    this.subtitle = "",
    this.leading = const SizedBox(),
    this.trailing = const SizedBox(),
    required this.onPressed,
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
          widget.onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                      SizedBox(
                          width: 200,
                          child: Text(
                            widget.title,
                            style: Styles.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
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
              if (widget.trailing != const SizedBox())
                Flexible(child: widget.trailing),
            ],
          ),
        ),
      ),
    );
  }
}

//This is a component that is being used in the cards
class CourseProgress extends StatelessWidget {
  const CourseProgress({
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

class CardDate extends StatelessWidget {
  const CardDate({
    super.key,
    required this.Date,
  });

  final DateTime Date;

  @override
  Widget build(BuildContext context) {
    String day = DateFormat('EEEE').format(Date);
    String date = DateFormat('dd-MM-yy').format(Date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
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
//* /////////////////////////////////////////////////////////////////////////////////////////////

//* Course Overview Cards////////////////////////////////////////////////////////////////////////
class CourseOverviewCard extends StatelessWidget {
  final String type;
  final String title;
  final DateTime date;
  final String? postedBy;
  final String? description;
  final String? status;
  final Widget? progress;
  final Function? onClick;

  const CourseOverviewCard({
    super.key,
    required this.type,
    required this.title,
    required this.date,
    this.postedBy,
    this.description,
    this.progress,
    this.status,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick != null ? onClick!() : null;
      },
      child: Container(
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
                            ? 'Time Left: ${time_left(date)}'
                            : 'Posted by: $postedBy',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        type == "assignment" || type == "quiz"
                            ? 'Due: ${DateFormat('dd, MMMM yyyy @ hh:mm a').format(date)}'
                            : DateFormat('dd, MMMM yyyy - hh:mm a')
                                .format(date),
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
                              style: Styles.bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                            backgroundColor: status_color(status),
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
      ),
    );
  }
}

//This is a component that is being used in the cards
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
//* /////////////////////////////////////////////////////////////////////////////////////////////

//* Assignment Detail Card////////////////////////////////////////////////////////////////////////
class AssignmentDetailCard extends StatelessWidget {
  final DateTime dueDate;
  final int numResubmissions;
  final DateTime resubmissionDueDate;
  final String status;

  const AssignmentDetailCard({
    super.key,
    required this.dueDate,
    required this.numResubmissions,
    required this.resubmissionDueDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16.0),
              color: status_color(status)),
          child: Text(
            status,
            style: Styles.bodySmall.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Due Date: ",
                      style: Styles.labelMedium,
                    ),
                    Text(
                      DateFormat('dd, MMMM yyyy @ hh:mm a').format(dueDate),
                      style: Styles.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      "No. of Resubmissions Allowed: ",
                      style: Styles.labelMedium,
                    ),
                    Text(
                      numResubmissions.toString(),
                      style: Styles.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Resubmission Deadline: ",
                      style: Styles.labelMedium,
                    ),
                    Text(
                      DateFormat('dd, MMMM yyyy @ hh:mm a')
                          .format(resubmissionDueDate),
                      style: Styles.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
//* /////////////////////////////////////////////////////////////////////////////////////////////

class CenteredCard extends StatelessWidget {
  final double width;
  final int? number;
  final String text;
  final Icon? icon;
  const CenteredCard({
    super.key,
    this.number,
    required this.text,
    this.icon,
    this.width = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          number != null
              ? Text(number.toString(), style: Styles.titleMedium)
              : icon!,
          const SizedBox(height: 5.0),
          Text(text, style: Styles.bodyMedium),
        ],
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final double width;
  final String? teacherName;
  final List<Map<String, dynamic>> details;

  const DetailCard({
    super.key,
    this.teacherName,
    required this.details,
    this.width = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            teacherName != null
                ? Text(teacherName!, style: Styles.labelLarge)
                : const SizedBox(),
            const SizedBox(height: 5.0),
            SizedBox(
              // height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('${details[index]['label']}: ',
                              style: Styles.labelMedium),
                          Text(details[index]['value'],
                              style: Styles.bodySmall),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
