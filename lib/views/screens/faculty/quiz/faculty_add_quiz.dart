import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/views/screens/faculty/quiz/faculty_add_question.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacCreateQuizPage extends StatefulWidget {
  final String id;
  const FacCreateQuizPage({super.key, required this.id});

  @override
  State<FacCreateQuizPage> createState() => _FacCreateQuizPageState();
}

class _FacCreateQuizPageState extends State<FacCreateQuizPage> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? dueDate;
  String? status = "open";

  void create() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    setState(() {
      loading = true;
    });

    final data = {
      'classID': widget.id,
      'title': titleController.text,
      'description': descriptionController.text,
      'startDate': DateFormat('MM/dd/yyyy')
          .format(startDate != null ? startDate! : DateTime.now()),
      'dueDate': DateFormat('MM-dd-yyyy')
          .format(dueDate != null ? dueDate! : DateTime.now()),
      'status': status,
    };

    context.read<QuizController>().createQuiz(data).then((value) {
      if (value != '1') {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Quiz created successfully"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return FacAddQuestionPage(
            id: value,
          );
        }));
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Quiz creation failed"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: Loading())
        : Scaffold(
            appBar: CourseHeader(
              title: "Add Quiz",
              onMenuPressed: () {},
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Subheading(text: "Quiz Details"),
                      MainTextField(
                        label: "Quiz Title",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter a title";
                          }
                          return null;
                        },
                        controller: titleController,
                      ),
                      const VerticalSpacer(),
                      MainTextField(
                        label: "Description",
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter a description";
                          }
                          return null;
                        },
                      ),
                      const VerticalSpacer(),
                      Container(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          value: status,
                          decoration: InputDecoration(
                            labelText: 'Status',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.redAccent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  const BorderSide(width: 1, color: Colors.red),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey[700]),
                          ),
                          items: ['open', 'pending', 'closed']
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              status = value!;
                            });
                          },
                        ),
                      ),
                      const VerticalSpacer(),
                      const Subheading(text: "Start Date"),
                      InkWell(
                        onTap: () async {
                          final selectedDateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary: Colors
                                            .black, // Customize the primary color
                                        onPrimary: Colors.white,
                                        secondary: Colors
                                            .black // Customize the text color
                                        ),
                                    dialogBackgroundColor: Colors.white
                                    // Customize the dialog background color
                                    ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDateTime != null) {
                            // ignore: use_build_context_synchronously
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors
                                          .black, // Customize the primary color
                                      onPrimary: Colors
                                          .white, // Customize the text color
                                      secondary: Colors.black,
                                    ),
                                    dialogBackgroundColor: Colors.grey[
                                        900], // Customize the dialog background color
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedTime != null) {
                              setState(() {
                                startDate = DateTime(
                                  selectedDateTime.year,
                                  selectedDateTime.month,
                                  selectedDateTime.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              DateFormat('EEE, dd MMMM, yyyy @ hh:mm a')
                                  .format(startDate ?? DateTime.now()),
                              style: Styles.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpacer(),
                      const Subheading(text: "Due Date"),
                      InkWell(
                        onTap: () async {
                          final selectedDateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary: Colors
                                            .black, // Customize the primary color
                                        onPrimary: Colors.white,
                                        secondary: Colors
                                            .black // Customize the text color
                                        ),
                                    dialogBackgroundColor: Colors.white
                                    // Customize the dialog background color
                                    ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDateTime != null) {
                            // ignore: use_build_context_synchronously
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors
                                          .black, // Customize the primary color
                                      onPrimary: Colors
                                          .white, // Customize the text color
                                      secondary: Colors.black,
                                    ),
                                    dialogBackgroundColor: Colors.grey[
                                        900], // Customize the dialog background color
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedTime != null) {
                              setState(() {
                                dueDate = DateTime(
                                  selectedDateTime.year,
                                  selectedDateTime.month,
                                  selectedDateTime.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              DateFormat('EEE, dd MMMM, yyyy @ hh:mm a')
                                  .format(dueDate ?? DateTime.now()),
                              style: Styles.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: !loading
                ? Container(
                    padding: EdgeInsets.all(16.0),
                    child: MainButton(
                      onPressed: () {
                        create();
                      },
                      text: "Save",
                      color: Colors.green,
                    ),
                  )
                : SizedBox(),
          );
  }
}
