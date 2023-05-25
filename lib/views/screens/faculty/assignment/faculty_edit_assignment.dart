import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacEditAssignmentPage extends StatefulWidget {
  final AssignmentModel? assignment;
  final String id;
  const FacEditAssignmentPage({
    super.key,
    required this.id,
    required this.assignment,
  });

  @override
  State<FacEditAssignmentPage> createState() => _FacEditAssignmentPageState();
}

class _FacEditAssignmentPageState extends State<FacEditAssignmentPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  DateTime? dueDate;
  String status = 'active';
  List<File>? oldFiles;
  List<File>? newFiles;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    newFiles = [];
    if (widget.assignment != null) {
      titleController.text = widget.assignment!.title;
      descriptionController.text = widget.assignment!.description;
      marksController.text = widget.assignment!.marks.toString();
      dueDate = widget.assignment!.dueDate;
      status = widget.assignment!.status;
      oldFiles = widget.assignment!.files!
          .map(
            (e) => File(e.url),
          )
          .toList();
    }
  }

  void editAssignment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      final assignmentData = {
        "title": titleController.text,
        "description": descriptionController.text,
        "dueDate": dueDate!.toIso8601String(),
        "status": status,
        "marks": marksController.text,
      };

      context
          .read<AssignmentController>()
          .udpateAssignment(
            assignmentData,
            widget.id,
          )
          .then((value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Assignment edited successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error editing assignment'),
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

  void deleteFile(int index) async {
    context.read<AssignmentController>().deleteFile(index, widget.id).then(
      (value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'File ${oldFiles![index].path.split('/').last} removed successfully',
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          setState(() {
            oldFiles!.removeAt(index);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to removed file ${oldFiles![index].path.split('/').last}',
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }

  void addFile() async {
    context
        .read<AssignmentController>()
        .addFile(newFiles, widget.id)
        .then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File added successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() {
          oldFiles!.addAll(newFiles!);
          newFiles = [];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error adding file'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void deletePopUp() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text("Delete Assignment"),
        content: const Text(
            "Are you sure you want to delete this resource? You will no longer be able to see any submissions made to this assignment."),
        actionsPadding: const EdgeInsets.all(12),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteResource();
              },
              child:
                  const Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void deleteResource() async {
    await context
        .read<AssignmentController>()
        .deleteAssignment(widget.assignment!.id)
        .then(
      (value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Assignment Deleted Successfully"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Assignment Deletion Failed"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Add Assignment",
        subtitle: "Class",
        onMenuPressed: () {},
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Colors.red,
            )),
            onPressed: () {
              deletePopUp();
            },
            child: Text(
              "Delete",
              style: Styles.labelMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: loading
          ? const Loading()
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
                      controller: titleController,
                    ),
                    const VerticalSpacer(),
                    MainTextField(
                      label: "Instructions",
                      maxLines: 6,
                      minLines: 6,
                      controller: descriptionController,
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
                            controller: marksController,
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
                      itemCount: oldFiles!.length,
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
                                    oldFiles![index].path.split('.').last),
                                const HorizontalSpacer(),
                                Expanded(
                                  child: Text(
                                    oldFiles![index].path.split('/').last,
                                    style: Styles.bodyMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteFile(index);
                                  },
                                  icon: const Icon(
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
                            newFiles!.addAll(result.paths
                                .map((path) => File(path!))
                                .toList());
                          });
                          addFile();
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
              padding: const EdgeInsets.all(16.0),
              child: MainButton(
                onPressed: () {
                  editAssignment();
                },
                text: "Save",
                color: Colors.green,
              ),
            )
          : const SizedBox(),
    );
  }
}
