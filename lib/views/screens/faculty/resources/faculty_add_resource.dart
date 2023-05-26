import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/resource_controller.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';

class FacAddResourcePage extends StatefulWidget {
  final String classID;
  const FacAddResourcePage({super.key, required this.classID});

  @override
  State<FacAddResourcePage> createState() => _FacAddResourcePageState();
}

class _FacAddResourcePageState extends State<FacAddResourcePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<File>? filesToUpload;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    titleController.text = "";
    descriptionController.text = "";
    filesToUpload = [];
  }

  void create() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      // await Future.delayed(Duration(seconds: 2));
      final data = {
        "classID": widget.classID,
        "title": titleController.text,
        "description": descriptionController.text,
      };

      await context
          .read<ResourceController>()
          .createResource(data, filesToUpload!)
          .then((value) {
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      });

      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CourseHeader(
        title: "Add Resource",
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
                    const Subheading(text: "Resource Details"),
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
                      helperText: "Markdown formatting is supported",
                    ),
                    const VerticalSpacer(),
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
                      child: Icon(
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
