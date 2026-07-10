

class PlaylistModel {
  final String songName;
  final String id;
  final String artist;
  final String description;
  final String songImg;
  final String songUrl;

  PlaylistModel({
    required this.songName,
    required this.id,
    required this.artist,
    required this.description,
    required this.songImg,
    required this.songUrl,
  });

  // Factory constructor to create a Song from JSON
  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      songName: json['songName'],
      id: json['playlistId'],
      artist: json['artist'],
      description: json['description'],
      songImg: json['songImg'],
      songUrl: json['songUrl'],
    );
  }

  // Method to convert a Song instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'songName': songName,
      'Id': id,
      'artist': artist,
      'description': description,
      'songImg': songImg,
      'songUrl': songUrl,
    };
  }
}
