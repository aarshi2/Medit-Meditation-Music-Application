import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/bottom_bar_screen/bottombar.dart';
import 'package:medit_app/View/favourite_screen/controller_fav.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';

import '../home_page/song_controller.dart';
import 'controller_player.dart';

// ignore: constant_identifier_names
enum AudioSourceOption { Network, Asset }

class MusicPlayer extends StatefulWidget {
  final ModelList;

  const MusicPlayer({super.key, required this.ModelList});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  var index;

  final PlayerController playerController = Get.put(PlayerController());
  final MyController songController = Get.put(MyController());
  final TextEditingController playlistcontroller = TextEditingController();
  final SignupController signupController = Get.put(SignupController());
  final ControllerFav controllerFav = Get.put(ControllerFav());
  final List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    index = Get.arguments;
    playerController.playerIndex.value = index;
    playerController.player.setVolume(1000000000000000000000);
    signupController.fetchPlaylist();
    playerController.lastIndex.value = widget.ModelList.length - 1;
    playerController.modelList = widget.ModelList;
    // Initialize song here
  }

  // late final List<SongModel> songList;
  // late final int currentIndex
  final double swipeThreshold = 100.0;

  Offset start = Offset.zero;
  Offset end = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        setState(() {
          isplay = true;
          /* Get.to(const BottomNavBarScreen());*/
        });
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const BottomNavBarScreen();
          },
        ));
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            /* onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              } else if (details.primaryVelocity! < 0) {
              playerController.increaseIndex();
              playerController.setupAudioPlayer(songController
                  .songModelList[playerController.playerIndex.value]);
            }*/
            onPanStart: (details) {
              start = details.globalPosition;
            },
            onPanUpdate: (details) {
              end = details.globalPosition;
            },
            onPanEnd: (details) {
              final dx = end.dx - start.dx;
              final dy = end.dy - start.dy;

              if (dx.abs() > dy.abs() && dx.abs() > swipeThreshold) {
                if (dx > 0) {
                  playerController.decreaseIndex();
                  playerController.setupAudioPlayer(songController
                      .songModelList[playerController.playerIndex.value]);
                  print('Swiped Right');
                } else {
                  // Left Swipe
                  playerController.increaseIndex();
                  playerController.setupAudioPlayer(songController
                      .songModelList[playerController.playerIndex.value]);
                }
              } else if (dy.abs() > swipeThreshold) {
                if (dy > 0) {
                  // Down Swipe
                  setState(() {
                    isplay = true;
                  });
                  Get.to(const BottomNavBarScreen());

                  print('Swiped Down');
                } else {
                  // Up Swipe
                  print('Swiped Up');
                }
              }

              // Reset start and end positions
              start = Offset.zero;
              end = Offset.zero;
            },
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.ModelList[playerController.playerIndex.value]
                              .songImg,
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.2)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 10,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isplay = true;
                                      });
                                      Get.to(const BottomNavBarScreen());
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 30,
                                    ))),
                            Expanded(
                              flex: 80,
                              child: Center(
                                  child: Obx(
                                () => Text(
                                  widget
                                      .ModelList[
                                          playerController.playerIndex.value]
                                      .songName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              )),
                            ),
                            const Expanded(
                              flex: 10,
                              child: SizedBox(),
                              /*IconButton(
                                onPressed: () {
                             Get.bottomSheet(Container(
                                    decoration: const BoxbDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: const Icon(
                                              Icons.favorite_outlined),
                                          title:
                                          const Text('Add to liked songs'),
                                          onTap: () {},
                                        ),
                                        ListTile(
                                          leading:
                                          const Icon(Icons.playlist_add),
                                          title: const Text('Add to playlist'),
                                          onTap: () {},
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.queue),
                                          title: const Text('Add to queue'),
                                          onTap: () {},
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.add_circle),
                                          title: const Text('Sleep timer'),
                                          onTap: () {},
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.add_circle),
                                          title: const Text(
                                              'Listen to music ad-free'),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 25,
                                ))*/
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 55,
                        child: Column(
                          children: [
                            const Expanded(flex: 20, child: SizedBox()),
                            Expanded(
                                flex: 60,
                                child: Obx(
                                  () => Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: NetworkImage(widget
                                                .ModelList[playerController
                                                    .playerIndex.value]
                                                .songImg),
                                            fit: BoxFit.cover,
                                          ))),
                                )),
                            Expanded(flex: 20, child: Container())
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: playerController.progessBar(),
                                ),
                              ),
                              Expanded(
                                flex: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () {
                                              playerController.decreaseIndex();

                                              playerController.setupAudioPlayer(
                                                  widget.ModelList[
                                                      playerController
                                                          .playerIndex.value]);
                                            },
                                            icon: const Icon(
                                              Icons.skip_previous,
                                              size: 35,
                                              color: Colors.white,
                                            ))),
                                    Expanded(
                                      flex: 1,
                                      child: playerController
                                          .playbackControlButton(64.0),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () {
                                              playerController.increaseIndex();
                                              playerController.setupAudioPlayer(
                                                  widget.ModelList[
                                                      playerController
                                                          .playerIndex.value]);
                                              //controllerFav.update();
                                            },
                                            icon: const Icon(
                                              Icons.skip_next,
                                              size: 35,
                                              color: Colors.white,
                                            ))),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 25,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white12,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: IconButton(
                                            icon: const Icon(
                                              Icons.playlist_add,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Get.bottomSheet(
                                                Container(
                                                  height: double.maxFinite,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: <Color>[
                                                        Colors.deepPurple,
                                                        Colors.black,
                                                      ],
                                                      tileMode: TileMode.mirror,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                "Save to playlist",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              Get.bottomSheet(Container(
                                                                  height: 300,
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                      gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter,
                                                                        colors: <Color>[
                                                                          Colors
                                                                              .deepPurple,
                                                                          Colors
                                                                              .black,
                                                                        ],
                                                                        tileMode:
                                                                            TileMode.mirror,
                                                                      )),
                                                                  child: Column(
                                                                    children: [
                                                                      const Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            "Add your playlist name",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 20),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                playlistcontroller,
                                                                            style:
                                                                                const TextStyle(color: Colors.white),
                                                                            decoration: const InputDecoration(
                                                                                hintText: "Enter your playlist name?",
                                                                                hintStyle: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 18,
                                                                                ),
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.deepPurple),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                                ),
                                                                                prefixIcon: Icon(Icons.playlist_add, size: 25, color: Colors.white),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.white),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            15),
                                                                        child: ElevatedButton(
                                                                            onPressed: () async {
                                                                              await signupController.addSongToPlaylist(widget.ModelList[playerController.playerIndex.value].id, widget.ModelList[playerController.playerIndex.value].songName, widget.ModelList[playerController.playerIndex.value].artist, playlistcontroller.text, widget.ModelList[playerController.playerIndex.value].songUrl, widget.ModelList[playerController.playerIndex.value].songImg, widget.ModelList[playerController.playerIndex.value].description);
                                                                              await signupController.fetchPlaylist();
                                                                              Get.back();
                                                                            },
                                                                            child: const Text(
                                                                              "Add playlist",
                                                                              style: TextStyle(color: Colors.deepPurple),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  )));
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .add_circle_outlined,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const Divider(
                                                        height: 2,
                                                      ),
                                                      Expanded(
                                                        child: Obx(
                                                          () =>
                                                              ListView.builder(
                                                            itemCount:
                                                                signupController
                                                                    .playlist
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              // Extract the key (playlist name) from the map
                                                              String
                                                                  playlistName =
                                                                  signupController
                                                                      .playlist[
                                                                          index]
                                                                      .keys
                                                                      .first;
                                                              var playlistSongs =
                                                                  signupController.playlist[index][playlistName]
                                                                              [
                                                                              0]
                                                                          [
                                                                          "songImg"] ??
                                                                      [];
                                                              // print(playlistSongs);
                                                              String?
                                                                  firstSongImg;
                                                              if (playlistSongs
                                                                  .isNotEmpty) {
                                                                firstSongImg =
                                                                    playlistSongs;
                                                              }
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: ListTile(
                                                                  leading:
                                                                      CircleAvatar(
                                                                    radius: 25,
                                                                    backgroundImage: firstSongImg !=
                                                                            null
                                                                        ? NetworkImage(
                                                                            firstSongImg)
                                                                        : null,
                                                                    // Use the first song's image if available
                                                                    child: firstSongImg ==
                                                                            null
                                                                        ? const Icon(
                                                                            Icons
                                                                                .music_note,
                                                                            color:
                                                                                Colors.white)
                                                                        : null, // Show a default icon if no image is available
                                                                  ),
                                                                  title: Text(
                                                                    playlistName,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  trailing:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            // Fetch and print all song data for the selected playlist
                                                                            // await signupController.fetchPlaylist();
                                                                            await signupController.playList(playlistName,
                                                                                index);
                                                                            List<dynamic>
                                                                                songs =
                                                                                signupController.modelList;
                                                                            bool
                                                                                songExists =
                                                                                songs.any(
                                                                              (song) => song['playlistId'] == widget.ModelList[playerController.playerIndex.value].id,
                                                                            );
                                                                            if (kDebugMode) {
                                                                              print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww$songExists");
                                                                            }
                                                                            if (!songExists) {
                                                                              // Add the song to the playlist if it does not already exist
                                                                              await signupController.toPlaylist(
                                                                                  widget.ModelList[playerController.playerIndex.value].id,
                                                                                  widget.ModelList[playerController.playerIndex.value].songName,
                                                                                  widget.ModelList[playerController.playerIndex.value].artist,
                                                                                  playlistName,
                                                                                  // Use the playlistName from the ListTile
                                                                                  widget.ModelList[playerController.playerIndex.value].songUrl,
                                                                                  widget.ModelList[playerController.playerIndex.value].songImg,
                                                                                  widget.ModelList[playerController.playerIndex.value].description,
                                                                                  index);
                                                                              if (kDebugMode) {
                                                                                print('Song added to playlist');
                                                                              }
                                                                            } else {
                                                                              if (kDebugMode) {
                                                                                print('Song already exists in the playlist');
                                                                              }
                                                                              Fluttertoast.showToast(msg: "Song already exists in the playlist", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                                                                            }
                                                                            //print(allSongsData);
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.add_circle_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                          )),
                                                                  onTap:
                                                                      () async {
                                                                    // Fetch and print all song data for the selected playlist
                                                                    // await signupController.fetchPlaylist();
                                                                    await signupController
                                                                        .playList(
                                                                            playlistName,
                                                                            index);
                                                                    List<dynamic>
                                                                        songs =
                                                                        signupController
                                                                            .modelList;
                                                                    bool
                                                                        songExists =
                                                                        songs
                                                                            .any(
                                                                      (song) =>
                                                                          song[
                                                                              'playlistId'] ==
                                                                          widget
                                                                              .ModelList[playerController.playerIndex.value]
                                                                              .id,
                                                                    );
                                                                    if (kDebugMode) {
                                                                      print(
                                                                          "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww$songExists");
                                                                    }
                                                                    if (!songExists) {
                                                                      // Add the song to the playlist if it does not already exist
                                                                      await signupController.toPlaylist(
                                                                          widget.ModelList[playerController.playerIndex.value].id,
                                                                          widget.ModelList[playerController.playerIndex.value].songName,
                                                                          widget.ModelList[playerController.playerIndex.value].artist,
                                                                          playlistName,
                                                                          // Use the playlistName from the ListTile
                                                                          widget.ModelList[playerController.playerIndex.value].songUrl,
                                                                          widget.ModelList[playerController.playerIndex.value].songImg,
                                                                          widget.ModelList[playerController.playerIndex.value].description,
                                                                          index);
                                                                      if (kDebugMode) {
                                                                        print(
                                                                            'Song added to playlist');
                                                                      }
                                                                    } else {
                                                                      if (kDebugMode) {
                                                                        print(
                                                                            'Song already exists in the playlist');
                                                                      }
                                                                      Get.snackbar(
                                                                        '',
                                                                        '',
                                                                        snackPosition:
                                                                            SnackPosition.BOTTOM,
                                                                        backgroundColor:
                                                                            Colors.grey[850],
                                                                        colorText:
                                                                            Colors.white,
                                                                        borderRadius:
                                                                            10,
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        duration:
                                                                            const Duration(seconds: 5),
                                                                        icon: const Icon(
                                                                            Icons
                                                                                .check_circle,
                                                                            color:
                                                                                Colors.green),
                                                                        messageText:
                                                                            const Text(
                                                                          "Song already exists in the playlist",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      );
                                                                    }
                                                                    //print(allSongsData);
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                          Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.bottomSheet(Container(
                                                      height: double.maxFinite,
                                                      width: double.maxFinite,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              "Sleeping Timer",
                                                              style: TextStyle(                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            color: Colors.grey,
                                                          ),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Future.delayed(const Duration(
                                                                        minutes:
                                                                            5))
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "5 minutes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Future.delayed(const Duration(
                                                                        minutes:
                                                                            10))
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "10 minutes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Future.delayed(const Duration(
                                                                        minutes:
                                                                            15))
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "15 minutes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Future.delayed(const Duration(
                                                                        minutes:
                                                                            30))
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "30 minutes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Future.delayed(const Duration(
                                                                        minutes:
                                                                            45))
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "45 minutes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Future.delayed(
                                                                        const Duration(
                                                                            hours:
                                                                                1))
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "1 hours",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                          ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                // ignore: non_constant_identifier_names
                                                                var Duration =
                                                                    playerController
                                                                        .player
                                                                        .duration!;
                                                                Future.delayed(
                                                                        Duration)
                                                                    .then((_) {
                                                                  playerController
                                                                      .player
                                                                      .pause();
                                                                });
                                                              },
                                                              title: const Text(
                                                                "End of track",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                        ],
                                                      ),
                                                    ));
                                                  },
                                                  icon: const Icon(
                                                    Icons.bedtime,
                                                    color: Colors.white,
                                                  ))),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                var song = widget.ModelList[
                                                    playerController
                                                        .playerIndex.value];
                                                // Toggle favorite status of the current song
                                                if (controllerFav.isFavorite(
                                                    song.id ?? '')) {
                                                  controllerFav
                                                      .removeSongFromFav(
                                                          song.id ?? '');
                                                } else {
                                                  controllerFav.addSongToFav(
                                                    song.id ?? '',
                                                    song.songName ?? '',
                                                    song.artist ?? '',
                                                    song.songUrl ?? '',
                                                    song.songImg ?? '',
                                                    song.description ?? '',
                                                  );
                                                }
                                                // No need to call toggleFavorite here as addSongToFav and removeSongFromFav already update the status
                                              },
                                              icon: Obx(() {
                                                var song = widget.ModelList[
                                                    playerController
                                                        .playerIndex.value];
                                                return Icon(
                                                  controllerFav.isFavorite(
                                                          song.id ?? '')
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color:
                                                      controllerFav.isFavorite(
                                                              song.id ?? '')
                                                          ? Colors.red
                                                          : Colors.white,
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          )),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
