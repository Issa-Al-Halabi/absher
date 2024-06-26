import 'package:absher/models/story_item_model.dart';

import 'localization_String_model.dart';

class StoryModelDto {
  int? id;
  List<StoryItemModel>? stories;
  List<VendorStoryModel>? vendor;
  int? views;
  StoryModelDto({

    this.id,
    this.stories,
    this.vendor,
    this.views,
  });

  StoryModelDto.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    stories = StoryItemModel.listFromJson(json['storyDetails']?? []);
    vendor = VendorStoryModel.listFromJson(json['vendor']?? []);
    views = json['views'];
  }

  static List<StoryModelDto> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => StoryModelDto.fromJson(value)).toList();
  }
}
class VendorStoryModel {
  int? id;
  LocalizationStringModel? name;
  String? image;
  VendorStoryModel(
      {this.id,
        this.image,
       });
  VendorStoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    image = json['image'];
    name =LocalizationStringModel.fromJson(json, "name");
  }

  static List<VendorStoryModel> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => VendorStoryModel.fromJson(value)).toList();
  }}
