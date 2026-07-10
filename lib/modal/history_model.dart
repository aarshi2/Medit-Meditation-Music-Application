import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String songName;
  final String id;
  final String artist;
  final String description;
  final String songImg;
  final String songUrl;
  final Timestamp date; // Timestamp field

  HistoryModel({
    required this.songName,
    required this.id,
    required this.artist,
    required this.description,
    required this.songImg,
    required this.songUrl,
    required this.date, // Add this parameter
  });

  // Factory constructor to create a HistoryModel from JSON
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      songName: json['songName'] ?? '', // Provide default values
      id: json['playlistId'] ?? '',
      artist: json['artist'] ?? '',
      description: json['description'] ?? '',
      songImg: json['songImg'] ?? '',
      songUrl: json['songUrl'] ?? '',
      date: json['date'] != null ? (json['date'] as Timestamp) : Timestamp.now(), // Handle null date
    );
  }

  // Method to convert a HistoryModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'songName': songName,
      'playlistId': id,
      'artist': artist,
      'description': description,
      'songImg': songImg,
      'songUrl': songUrl,
      'date': date, // Add date to JSON
    };
  }
}
