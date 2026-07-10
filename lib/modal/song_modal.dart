import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SongModel {
  String id;
  String artist;
  String songName;
  String songImg;
  String songUrl;
  String description;

  SongModel(
      {required this.id,
      required this.artist,
      required this.songName,
      required this.songImg,
      required this.songUrl,
      required this.description,
        });
  // Factory method to create a MyModel instance from a Firestore document
  factory SongModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return SongModel(
      id: doc.id,
      songName: doc['songName'],
      artist: doc['artist'],
      songImg: doc['songImg'],
      songUrl: doc["songUrl"],
      description: doc["description"],
    ); 
  }
}



class RelaxingModal {
  String id;
  String artist;
  String songName;
  String songImg;
  String songUrl;
  String description;
  final ValueNotifier<bool> isFavorite;

  RelaxingModal(
      {required this.id,
        required this.artist,
        required this.songName,
        required this.songImg,
        required this.songUrl,
        required this.description,
        bool isFavorite = false, // Default to false if not specified
      }) :  this.isFavorite = ValueNotifier<bool>(isFavorite);

  // Factory method to create a MyModel instance from a Firestore document
  factory RelaxingModal.fromDocumentSnapshot(DocumentSnapshot doc) {
    return RelaxingModal(
      id: doc.id,
      songName: doc['songName'],
      artist: doc['artist'],
      songImg: doc['songImg'],
      songUrl: doc["songUrl"],
      description: doc["description"],
    );
  }
}

class SpiritualModal {
  String id;
  String artist;
  String songName;
  String songImg;
  String songUrl;
  String description;
  final ValueNotifier<bool> isFavorite;

  SpiritualModal({required this.id,
    required this.artist,
    required this.songName,
    required this.songImg,
    required this.songUrl,
    required this.description,
    bool isFavorite = false, // Default to false if not specified
  }) : this.isFavorite = ValueNotifier<bool>(isFavorite);

  // Factory method to create a MyModel instance from a Firestore document
  factory SpiritualModal.fromDocumentSnapshot(DocumentSnapshot doc) {
    return SpiritualModal(
      id: doc.id,
      songName: doc['songName'],
      artist: doc['artist'],
      songImg: doc['songImg'],
      songUrl: doc["songUrl"],
      description: doc["description"],
    );
  }
}

class NatureModal {
  String id;
  String artist;
  String songName;
  String songImg;
  String songUrl;
  String description;
  final ValueNotifier<bool> isFavorite;

  NatureModal({required this.id,
    required this.artist,
    required this.songName,
    required this.songImg,
    required this.songUrl,
    required this.description,
    bool isFavorite = false, // Default to false if not specified
  }) : this.isFavorite = ValueNotifier<bool>(isFavorite);

  // Factory method to create a MyModel instance from a Firestore document
  factory NatureModal.fromDocumentSnapshot(DocumentSnapshot doc) {
    return NatureModal(
      id: doc.id,
      songName: doc['songName'],
      artist: doc['artist'],
      songImg: doc['songImg'],
      songUrl: doc["songUrl"],
      description: doc["description"],
    );
  }
}

class InspirationModal {
  String id;
  String artist;
  String songName;
  String songImg;
  String songUrl;
  String description;
  final ValueNotifier<bool> isFavorite;

  InspirationModal({required this.id,
    required this.artist,
    required this.songName,
    required this.songImg,
    required this.songUrl,
    required this.description,
    bool isFavorite = false, // Default to false if not specified
  }) : this.isFavorite = ValueNotifier<bool>(isFavorite);

  // Factory method to create a MyModel instance from a Firestore document
  factory InspirationModal.fromDocumentSnapshot(DocumentSnapshot doc) {
    return InspirationModal(
      id: doc.id,
      songName: doc['songName'],
      artist: doc['artist'],
      songImg: doc['songImg'],
      songUrl: doc["songUrl"],
      description: doc["description"],
    );
  }
}
