import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:music_app/model/song.dart';

class SongRespository {
  static FirebaseFirestore? _firebaseFirestore = null;
  static SongRespository? _instance = null;

  static SongRespository getInstance() {
    if (_instance == null) {
      _instance = new SongRespository();
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _instance!;
  }

  Future<List<Song>> getPopular() async {
    var collection = _firebaseFirestore!.collection('music');
    var querySnapshot = await collection.get();
    List<Song> listSong = [];
    for (var queryDocumentSnapShot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapShot.data();
      listSong.add(Song.fromMap(data));
    }

    return listSong;
  }

  Future<List<Song>> getTrend() async {
    var collection = _firebaseFirestore!.collection('new_music');
    var querySnapshot = await collection.get();
    List<Song> listSong = [];
    for (var queryDocumentSnapShot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapShot.data();
      listSong.add(Song.fromMap(data));
    }

    return listSong;
  }

  Future<List<Song>> getNew() async {
    var collection = _firebaseFirestore!.collection('new2_music');
    var querySnapshot = await collection.get();
    List<Song> listSong = [];
    for (var queryDocumentSnapShot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapShot.data();
      listSong.add(Song.fromMap(data));
    }

    return listSong;
  }
}
