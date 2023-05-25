import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
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

import '../../../../controllers/announcement_controller.dart';
import '../../../../models/announcement_model.dart';

class FacEditAnnouncementPage extends StatefulWidget {
  final AnnouncementModel? announcement;
  final String id;
  const FacEditAnnouncementPage({
    super.key,
    required this.id,
    required this.announcement,
  });

  @override
  State<FacEditAnnouncementPage> createState() => _FacEditAnnouncementPageState();
}

class _FacEditAnnouncementPageState extends State<FacEditAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String ? announcementType;
  String status = 'active';
  List<File>? oldFiles;
  List<File>? newFiles;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    newFiles = [];
    if (widget.announcement != null) {
      titleController.text = widget.announcement!.title;
      descriptionController.text = widget.announcement!.description;
      announcementType = widget.announcement!.announcementType;
      // dueDate = widget.assignment!.dueDate;
      // status = widget.assignment!.status;
      // oldFiles = widget.assignment!.files!
      //     .map(
      //       (e) => File(e.url),
      //     )
      //     .toList();
    }
  }

  void editAnnouncement() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      final announcementData = {
        "title": titleController.text,
        "description": descriptionController.text,
        "announcementType": announcementType,
      };

      context
          .read<AnnouncementController>()
          .udpateAnnouncement(
            announcementData,
            widget.id,
          )
          .then((value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Announcement edited successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error editing announcement'),
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

  void deletePopUp() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text("Delete Announcement"),
        content: const Text(
            "Are you sure you want to delete this announcement?"),
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
        .read<AnnouncementController>()
        .deleteAnnouncement(widget.id)
        .then(
      (value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Announcement Deleted Successfully"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop(true);
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Announcement Deletion Failed"),
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
        title: "Add Announcement",
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
                    const Subheading(text: "Announcement Details"),
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
                      label: "Description",
                      maxLines: 6,
                      minLines: 6,
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter the announcement description';
                        }
                        return null;
                      },
                      helperText: "Markdown formatting is supported",
                    ),
                    const VerticalSpacer(),
                  Container(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value: announcementType,
                        decoration: InputDecoration(
                          labelText: 'Announcement Type',
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
                        items:
                            ["general", "course", "quiz", "assignment", "exam"]
                                .map((type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(type),
                                    ))
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            announcementType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: !loading
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: MainButton(
                onPressed: () {
                  editAnnouncement();
                },
                text: "Save",
                color: Colors.green,
              ),
            )
          : const SizedBox(),
    );
  }
}
