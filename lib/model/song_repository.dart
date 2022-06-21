import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:music_app/model/song.dart';

class SongRespository {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Stream<List<Song>> getAllSong() {
    return FirebaseFirestore.instance
        .collection('music')
        .snapshots()
        .map((event) {
      List<Song> _songs = [];
      event.docs.forEach((element) {
        _songs.add(Song.fromMap(element.data()));
      });
      return _songs.reversed.toList();
    });
  }
}
