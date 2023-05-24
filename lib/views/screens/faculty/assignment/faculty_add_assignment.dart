import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacAssignmentAddPage extends StatefulWidget {
  final String classID;

  const FacAssignmentAddPage({required this.classID});

  @override
  _FacAssignmentAddPageState createState() => _FacAssignmentAddPageState();
}

class _FacAssignmentAddPageState extends State<FacAssignmentAddPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  // TextEditingController dueDateController = TextEditingController();
  DateTime? dueDate;
  TextEditingController marks = TextEditingController();
  // TextEditingController status = TextEditingController();
  String status = 'active';
  // PlatformFile? file;
  // List<PlatformFile> files = [];
  List<File>? filesToUpload;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    title.text = '';
    description.text = '';
    marks.text = '';
    filesToUpload = [];
    dueDate = DateTime.now();

    Log.e('step 4: ${widget.classID}');
  }

  void create() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        loading = true;
      });

      final assignmentData = {
        'classID': widget.classID,
        'title': title.text,
        'description': description.text,
        'dueDate': DateFormat('dd/MM/yy').format(dueDate!),
        'marks': marks.text,
        'status': status,
      };

      context
          .read<AssignmentController>()
          .createAssignment(assignmentData, filesToUpload)
          .then((value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Assignment created successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error creating assignment'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Add Assignment",
        subtitle: "Class",
        onMenuPressed: () {},
      ),
      body: loading
          ? Loading()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Subheading(text: "Assignment Details"),
                    MainTextField(
                      label: "Title",
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      controller: title,
                    ),
                    const VerticalSpacer(),
                    MainTextField(
                      label: "Instructions",
                      maxLines: 6,
                      minLines: 6,
                      controller: description,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter the assignment instructions';
                        }
                        return null;
                      },
                      helperText: "Markdown formatting is supported",
                    ),
                    const VerticalSpacer(),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: MainTextField(
                            label: "Marks",
                            controller: marks,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter marks';
                              }
                              return null;
                            },
                          ),
                        ),
                        const HorizontalSpacer(),
                        Flexible(
                          flex: 1,
                          child: Container(
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
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.red),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(color: Colors.grey[700]),
                              ),
                              items: ['active', 'closed']
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
                        )
                      ],
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
                    const VerticalSpacer(),
                    const Subheading(text: "Upload Files"),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: filesToUpload!.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02);
                      },
                      itemBuilder: (context, index) {
                        return Ink(
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                createFileIcon(
                                    filesToUpload![index].path.split('.').last),
                                const HorizontalSpacer(),
                                Expanded(
                                  child: Text(
                                    filesToUpload![index].path.split('/').last,
                                    style: Styles.bodyMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      filesToUpload!.removeAt(index);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    MainButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result != null) {
                          setState(() {
                            filesToUpload!.addAll(result.paths
                                .map((path) => File(path!))
                                .toList());
                          });
                        }
                      },
                      text: "Upload File",
                      color: Colors.black,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    const VerticalSpacer(),
                  ],
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
