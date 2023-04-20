import 'package:flutter/material.dart';
import 'package:front_end/entities/announcement_entity.dart';
import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/models/mock_data.dart';

class AnnouncementProvider extends ChangeNotifier {
  List<AnnouncementEntity> list = [];

  List<AnnouncementEntity> get getAnnouncements => list;

  void loadAnnouncements() {
    list = [];
    AnnouncementModel announcementModel =
        AnnouncementModel.fromJson(announcementJSON);

    AnnouncementEntity announcement = AnnouncementEntity(
      title: announcementModel.title,
      description: announcementModel.description,
      uploadDate: announcementModel.uploadDate,
      postedBy: announcementModel.postedBy,
    );
    list.add(announcement);
  }

  @override
  notifyListeners();
}
