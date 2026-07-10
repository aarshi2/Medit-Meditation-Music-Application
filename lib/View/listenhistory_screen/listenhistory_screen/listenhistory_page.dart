import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/listenhistory_screen/listenhistory_screen/listenhistory_controller.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/modal/history_model.dart';
import 'package:medit_app/resources/color.dart';

class ListenHistoryPage extends StatefulWidget {
  const ListenHistoryPage({super.key});

  @override
  State<ListenHistoryPage> createState() => _ListenHistoryPageState();
}

class _ListenHistoryPageState extends State<ListenHistoryPage> {
  final ListenHistory listenHistory = Get.put(ListenHistory());
  final PlayerController playerController = Get.put(PlayerController());

  @override
  void initState() {
    super.initState();
    listenHistory.fetchHistoryModel();
  }

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    DateTime now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return "Today";
    } else if (date.day == now.subtract(const Duration(days: 1)).day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Yesterday";
    } else {
      return "${date.day} ${_getMonthName(date.month)} ${date.year}";
    }
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Recently Played", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(
              () {
            // Group songs by date
            Map<String, List<HistoryModel>> groupedSongs = {};
            for (var song in listenHistory.historyList) {
              String formattedDate = formatDate(song.date);
              if (groupedSongs.containsKey(formattedDate)) {
                groupedSongs[formattedDate]!.add(song);
              } else {
                groupedSongs[formattedDate] = [song];
              }
            }

            return ListView(
              children: groupedSongs.entries.map((entry) {
                String date = entry.key;
                List<HistoryModel> songs = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ...songs.map((song) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  song.songImg,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            song.songName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            song.artist,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Get.to(MusicPlayer(ModelList: listenHistory.historyList,), arguments: songs.indexOf(song));
                              playerController.setupAudioPlayer(song);
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
