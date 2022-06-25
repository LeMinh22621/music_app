import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:music_app/model/song.dart';

class SongRespository {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<List<Song>> getAllSong() async { //Lay tat cac du lieu tren firebase
    var collection = FirebaseFirestore.instance.collection('music');
    var querySnapshot = await collection.get();
    List<Song> listSong = [];
    for (var queryDocumentSnapShot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapShot.data();
      listSong.add(Song.fromMap(data));
    }

    return listSong;
  }

  static Future<List<Song>> getTrend() async { // Lay nhung bai nhac theo tren
    var collection = FirebaseFirestore.instance.collection('new2_music');
    var querySnapshot = await collection.get();
    List<Song> listSong = [];
    for (var queryDocumentSnapShot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapShot.data();
      listSong.add(Song.fromMap(data));
    }

    return listSong;
  }
}
