import 'package:absher/models/category_response.dart';
import 'package:absher/models/reels_model.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/api_const.dart';
import '../../models/home_model.dart';
import '../../models/profile_model.dart';
import '../../models/search_response.dart';
import '../../models/sub_category_response.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class HomeRepository {
  static Future<Either<String, HomeModel>> getHomeData() {
    return BaseApiClient.get<HomeModel>(
        url: ApiConst.home,
        converter: (e) {
          return HomeModel.fromJson(e['data']);
        });
  }
  static Future<Either<String, ProfileModel>> getProfile() {
    return BaseApiClient.get<ProfileModel>(
        url: ApiConst.profile,
        converter: (e) {
          return ProfileModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, List<VendorModel>>> getSearchCategory(
      {required String text}) {
    return BaseApiClient.get<List<VendorModel>>(
        url: ApiConst.search + text,
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }

  static Future<Either<String, List<VendorModel>>> getVendorsList(
      {required int categoryId}) {
    return BaseApiClient.get<List<VendorModel>>(
        url: ApiConst.vendorsList(categoryId),
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }
  static Future<Either<String, List<VendorModel>>> getFavoriteList() {
    return BaseApiClient.get<List<VendorModel>>(
        url: ApiConst.getFavorite,
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }
  static Future<Either<String, SubCategoriesModel>> getSubCategory(
      {required int categoryId}) {
    return BaseApiClient.get<SubCategoriesModel>(
        url: ApiConst.getSubCategories(categoryId),
        converter: (e) {
          return SubCategoriesModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, List<ReelsModel>>> getReels() {
    return BaseApiClient.get<List<ReelsModel>>(
        url: ApiConst.reels ,
        converter: (e) {
          return ReelsModel.listFromJson(e["data"]);
        });
  }
}