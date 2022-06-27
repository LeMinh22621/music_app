import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/model/song_repository.dart';

class MediaViewModel with ChangeNotifier {
  List<Song> _currentList = [];

  set setCurrentList(List<Song> list) {
    _currentList = list;
  }

  List<Song> get getCurrentList => _currentList;

  Future<List<Song>> loadPopular() async {
    return await SongRespository.getPopular();
  }

  Future<List<Song>> loadTrend() async {
    return await SongRespository.getTrend();
  }

  Future<List<Song>> loadNew() async {
    return await SongRespository.getNew();
  }
}
