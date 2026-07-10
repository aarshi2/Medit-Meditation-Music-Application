class FavModel {
  final String? id;  // Add this line
  final String? playlistId;
  final String? songName;
  final String? artist;
  final String? songUrl;
  final String? songImg;
  final String? description;
  final bool? isFavorite;

  FavModel({
    this.id,  // Add this line
    this.playlistId,
    this.songName,
    this.artist,
    this.songUrl,
    this.songImg,
    this.description,
    this.isFavorite,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) {
    return FavModel(
      id: json['id'] as String?,  // Add this line
      playlistId: json['playlistId'] as String?,
      songName: json['songName'] as String?,
      artist: json['artist'] as String?,
      songUrl: json['songUrl'] as String?,
      songImg: json['songImg'] as String?,
      description: json['description'] as String?,
      isFavorite: json['isFavorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  // Add this line
      'playlistId': playlistId,
      'songName': songName,
      'artist': artist,
      'songUrl': songUrl,
      'songImg': songImg,
      'description': description,
      'isFavorite': isFavorite,
    };
  }
}
