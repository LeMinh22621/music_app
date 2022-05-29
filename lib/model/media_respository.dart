import 'package:music_app/model/media.dart';
import 'package:music_app/model/service/base_service.dart';
import 'package:music_app/model/service/media_service.dart';

class MediaRespository {
  BaseService _mediaService = MediaService();

  Future<List<Media>> fetchMediaList(String value) async {
    dynamic response = await _mediaService.getResponse(value);
    final jsonData = response['results'] as List;

    List<Media> mediaList =
        jsonData.map((tagJson) => Media.fromJson(tagJson)).toList();
    return mediaList;
  }
}
