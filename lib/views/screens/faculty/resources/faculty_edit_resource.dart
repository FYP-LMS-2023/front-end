import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/resource_controller.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';

class FacEditResourcePage extends StatefulWidget {
  final String id;
  final ResourceModel resource;
  const FacEditResourcePage(
      {super.key, required this.id, required this.resource});

  @override
  State<FacEditResourcePage> createState() => _FacEditResourcePageState();
}

class _FacEditResourcePageState extends State<FacEditResourcePage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<File>? oldFiles;
  List<File>? newFiles;

  @override
  void initState() {
    super.initState();
    newFiles = [];
    titleController.text = widget.resource.title;
    descriptionController.text = widget.resource.description;
    oldFiles = widget.resource.files.map((e) => File(e.url)).toList();
  }

  void deletePopUp() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text("Delete Resource"),
        content: const Text("Are you sure you want to delete this resource?"),
        actionsPadding: EdgeInsets.all(12),
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
        .read<ResourceController>()
        .deleteResource(widget.resource.id, widget.id)
        .then(
      (value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Resource Deleted Successfully"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Resource Deletion Failed"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
    // Navigator.of(context).pop();
  }

  void editResource() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final data = {
        "title": titleController.text,
        "description": descriptionController.text,
      };

      context
          .read<ResourceController>()
          .updateResource(data, widget.resource.id)
          .then(
        (value) {
          if (value == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Resource updated successfully"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Resource update failed"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
            setState(() {
              loading = false;
            });
          }
        },
      );
    }
  }

  void addFile() async {
    context
        .read<ResourceController>()
        .addFile(newFiles, widget.resource.id)
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

  void deleteFile(int index) async {
    context
        .read<ResourceController>()
        .deleteFile(index, widget.resource.id)
        .then(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CourseHeader(
        title: "Edit Resource",
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
                                    setState(() {
                                      deleteFile(index);
                                      // filesToUpload!.removeAt(index);
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
                            newFiles!.addAll(result.paths
                                .map((path) => File(path!))
                                .toList());
                          });
                          addFile();
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
                  editResource();
                },
                text: "Save",
                color: Colors.green,
              ),
            )
          : SizedBox(),
    );
    ;
  }
}
