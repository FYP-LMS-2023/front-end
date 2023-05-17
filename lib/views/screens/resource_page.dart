import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcePage extends StatelessWidget {
  final ResourceModel? resourceData;
  final String classData;
  const ResourcePage(
      {super.key, required this.resourceData, required this.classData});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Resources",
        subtitle: classData,
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        resourceData!.title,
                        style: Styles.titleMedium,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        resourceData!.description,
                        style: Styles.bodyMedium,
                        overflow: TextOverflow.clip,
                      ),
                      const VerticalSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Posted By: ",
                            style: Styles.titleSmall,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              resourceData!.uploadedBy!.fullName,
                              style: Styles.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Date Posted: ",
                            style: Styles.titleSmall,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              DateFormat('dd MMM yyy @ hh:mm a').format(
                                  resourceData!.dateUploaded as DateTime),
                              style: Styles.bodyMedium,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalSpacer(),
              const Subheading(text: "Files"),
              ListView.separated(
                shrinkWrap: true,
                itemCount: resourceData!.files.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _launchInBrowser(
                          Uri.parse(resourceData!.files[index].url));
                    },
                    child: Ink(
                      decoration: boxDecoration,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              height: MediaQuery.of(context).size.width * 0.13,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: createIcon(resourceData!.files[index].url
                                  .split("-")[1]
                                  .split(".")[1]),
                            ),
                            const HorizontalSpacer(),
                            Container(
                                child: Text(resourceData!.files[index].url
                                    .split("/")[8]
                                    .split("-")[1]))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Icon createIcon(String ext) {
    // print(ext);
    if (ext == "pdf") {
      return const Icon(
        Icons.picture_as_pdf_rounded,
        color: Colors.white,
      );
    } else if (ext == "png") {
      return const Icon(Icons.image, color: Colors.white);
    } else if (ext == "mp4") {
      return const Icon(Icons.video_library, color: Colors.white);
    } else if (ext == "mp3") {
      return const Icon(Icons.audio_file, color: Colors.white);
    } else if (ext == "txt") {
      return const Icon(Icons.text_snippet_rounded, color: Colors.white);
    } else if (ext == "docx") {
      return const Icon(Icons.edit_document, color: Colors.white);
    }
    return const Icon(
      Icons.file_copy_rounded,
      color: Colors.white,
    );
  }
}
