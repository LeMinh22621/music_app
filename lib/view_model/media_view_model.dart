import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:music_app/model/api/api_response.dart';
import 'package:music_app/model/media.dart';
import 'package:music_app/model/media_respository.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/model/song_repository.dart';

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

  List<Song> getAllSong() {
    List<Song> _l = [];

    SongRespository.getAllSong().elementAt(0).then(
      (value) {
        List<Song> _songs = [];
        _songs.addAll(value.map((e) => e));
        _l = _songs;
        print("songs: = " + _songs.length.toString());
      },
    );

    print("l: = " + _l.length.toString());

    return _l;
  }
}
