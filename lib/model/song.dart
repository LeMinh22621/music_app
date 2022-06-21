class Song {
  final String? title;
  final String? music_file;
  final String? img;
  final String? artist;

  Song({
    this.title,
    this.music_file,
    this.img,
    this.artist,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'music_file': music_file,
      'img': img,
      'artist': artist,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      title: map['title'],
      music_file: map['music_file'],
      img: map['img'],
      artist: map['artist'],
    );
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['title'] as String?,
      music_file: json['music_file'] as String?,
      img: json['img'] as String?,
      artist: json['artist'] as String?,
    );
  }
}
