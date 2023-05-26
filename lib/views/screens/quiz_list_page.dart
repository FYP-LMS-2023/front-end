import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/quiz_model.dart';
import 'package:front_end/utils/functions/time_left.dart';
import 'package:front_end/views/screens/quiz_page_start.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuizListPage extends StatefulWidget {
  String? id;

  QuizListPage({Key? key, this.id}) : super(key: key);

  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  bool loading = true;
  List<QuizModel>? quizzes;
  ClassModel? classData;

  Future<void> fetchQuizDetails() async {
    Log.i("fetching quizzes details");
    try {
      await context
          .read<QuizController>()
          .getAllQuizzes(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          loading = false;
          quizzes = context.read<QuizController>().getQuizzes;
          classData = context.read<ClassController>().getMyClass;
        });
      });
    } catch (e) {
      Log.e("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuizDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: <Widget>[
                    Subheading(
                        text: "Quizzes"),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.none,
                      itemCount: quizzes!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CourseOverviewCard(
                              type: "quiz",
                              title: quizzes != null
                                  ? quizzes![index].title
                                  : "Untitled",
                              date: quizzes![index].dueDate ?? DateTime.now(),
                              marks:
                                  quizzes != null ? quizzes![index].marks : 0,
                              status: quizzes![index].status,
                              onClick: () {
                                if (quizzes![index].status == "open" ||
                                    time_left(quizzes![index].dueDate) !=
                                        "Expired") {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuizPageStart(id: quizzes![index].id),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Row buildStats(context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Palette.kToDark[50],
            boxShadow: dropShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${20}%',
                  style: Styles.headlineLarge.copyWith(color: Colors.white)),
              Text(
                "Current",
                style: Styles.labelLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: dropShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${40}%', style: Styles.headlineLarge),
              Text(
                "Weightage",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: dropShadow),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${25}', style: Styles.headlineLarge),
              Text(
                "/${50} Points",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
