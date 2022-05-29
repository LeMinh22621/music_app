import 'package:flutter/cupertino.dart';
import 'package:music_app/model/api/api_response.dart';
import 'package:music_app/model/media.dart';
import 'package:music_app/model/media_respository.dart';

class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  Media? _media;

  ApiResponse get response {
    return _apiResponse;
  }

  Media? get media {
    return _media;
  }

  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('fetching artist data');
    notifyListeners();

    try {
      List<Media> mediaList = await MediaRespository().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(
          'get a List Media with: ' + mediaList.length.toString() + 'elements');
    } catch (exception) {
      _apiResponse = ApiResponse.error(exception.toString());
      print(exception);
    }
    notifyListeners();
  }

  void setSelectedMedia(Media? media) {
    _media = media;
    notifyListeners();
  }
}
