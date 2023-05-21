import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  TextEditingController dueDateController = TextEditingController();
  DateTime? dueDate;
  TextEditingController marks = TextEditingController();
  // TextEditingController status = TextEditingController();
  String status = 'active';
  PlatformFile? file;
  List<PlatformFile> files = [];
  List<File>? filesToUpload;

  // String title = '';
  // String description = '';
  // DateTime? dueDate;
  // int marks = 0;
  // String status = 'active';

  @override
  void initState() {
    super.initState();
    title.text = '';
    description.text = '';
    marks.text = '';

    Log.e('step 4: ${widget.classID}');
  }

  // void _saveAssignment() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     Log.e(widget.classID);
  //     // Create a map to store the information
  //     final assignmentData = {
  //       'classID': widget.classID,
  //       'title': title.text,
  //       'description': description.text,
  //       'dueDate': DateFormat('dd/MM/yy').format(dueDate!),
  //       'marks': marks.text,
  //       'status': status,
  //       // 'file': file != null ? file!.path : "",
  //     };

  //     // Display the information in the console
  //     // print(assignmentData);
  //     Log.e(assignmentData);
  //     // context
  //     //     .read<AssignmentController>()
  //     //     .createAssignment(assignmentData, files != null ? files! : null);
  //   }
  // }

  void create() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

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
          .createAssignment(assignmentData, filesToUpload);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const VerticalSpacer(),
              MainTextField(
                label: "Title",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                controller: title,
              ),
              const VerticalSpacer(),
              MainTextField(
                label: "Instructions",
                maxLines: null,
                controller: description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const VerticalSpacer(),
              MainTextField(
                label: "Marks",
                controller: marks,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter marks';
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
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(color: Colors.grey[700]),
                  ),
                  items: ['active', 'closed', 'deleted']
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
                                primary:
                                    Colors.black, // Customize the primary color
                                onPrimary: Colors.white,
                                secondary:
                                    Colors.black // Customize the text color
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
                              primary:
                                  Colors.black, // Customize the primary color
                              onPrimary:
                                  Colors.white, // Customize the text color
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
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    setState(() {
                      filesToUpload =
                          result.paths.map((path) => File(path!)).toList();
                    });

                    // _saveAssignment();
                    // final assignmentData = {
                    //   'classID': widget.classID,
                    //   'title': title.text,
                    //   'description': description.text,
                    //   'dueDate': DateFormat('dd/MM/yy').format(dueDate!),
                    //   'marks': marks.text,
                    //   'status': status,
                    // };
                    // context
                    //     .read<AssignmentController>()
                    //     .createAssignment(assignmentData, files);
                  }
                },
                child: const Text('Upload File'),
              ),
              // buildFileIcon(
              //   file != null
              //       ? file!
              //       : PlatformFile(
              //           name: 'Nothing here',
              //           size: 0,
              //         ),
              // ),
              const VerticalSpacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: MainButton(
          onPressed: () {
            create();
          },
          text: "Save",
        ),
      ),
    );
  }

  Widget buildFileIcon(PlatformFile file) {
    IconData iconData;

    switch (file.name.split('.').last) {
      case 'jpeg':
      case 'png':
        iconData = Icons.image;
        break;
      case 'pdf':
        iconData = Icons.picture_as_pdf;
        break;
      // case 'text/plain':
      //   iconData = Icons.text_snippet;
      //   break;
      // Add more cases for different file types as needed
      default:
        iconData = Icons.insert_drive_file;
        break;
    }

    print('File type: ${file.extension}');
    print('File name: ${file.name}');
    print('File size: ${file.size}');
    print('File bytes: ${file.bytes}');
    print('File path: ${file.path}');
    print('File identifier: ${file.identifier}');
    print('File read-stream: ${file.readStream}');

    return Column(
      children: [
        Icon(iconData, size: 48),
        Text(file.name),
      ],
    );
  }
}
