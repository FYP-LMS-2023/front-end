import 'package:flutter/material.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/announcement_controller.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';

class FacAddAnnouncementPage extends StatefulWidget {
  final String classID;

  const FacAddAnnouncementPage({super.key, required this.classID});

  @override
  State<FacAddAnnouncementPage> createState() => _FacAddAnnouncementPageState();
}

class _FacAddAnnouncementPageState extends State<FacAddAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String type = 'general';

  bool loading = false;

  void create() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      final data = {
        "classID": widget.classID,
        "title": titleController.text,
        "description": descriptionController.text,
        "announcementType": type,
      };

      await context
          .read<AnnouncementController>()
          .createAnnouncement(data)
          .then(
        (value) {
          if (value == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Announcement created successfully'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            setState(
              () {
                loading = false;
              },
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Announcement creation failed'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
            setState(
              () {
                loading = false;
              },
            );
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    titleController.text = "";
    descriptionController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Add Announcement",
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
                          return 'Please enter the resource description';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacer(),
                    Container(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value: type,
                        decoration: InputDecoration(
                          labelText: 'Type',
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
                            type = value!;
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
