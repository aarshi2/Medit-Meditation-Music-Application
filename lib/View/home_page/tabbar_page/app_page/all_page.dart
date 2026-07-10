import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/listenhistory_screen/listenhistory_screen/listenhistory_controller.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/modal/AdHelper.dart';
import 'package:medit_app/resources/color.dart';
import 'package:medit_app/view_model/drawer/drawer.dart';

import 'controller_all.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  final AllController allController = Get.put(AllController());
  final MyController songController = Get.put(MyController());
  final PlayerController playerController = Get.put(PlayerController());
  final ListenHistory listenHistory = Get.put(ListenHistory());

  /*BannerAd? bannerAd;
  bool isBannerAdReady = false;*/
  //final FavoriteController favoriteController = Get.put(FavoriteController());
  void initState() {
    super.initState();
    AdsManager().loadBannerAd();
    AdsManager().loadInterstitialAd();
    AdsManager().loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          FlutterAppMinimizer.minimize(); // Minimize the app
        },
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: GradientDecoration.getBackground(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "Home",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            drawer: const MyDrawer(),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //   Center(child: Container(child: AdsManager().getBannerAdWidget())),
                  /*   ElevatedButton(onPressed: () {
                AdsManager().loadInterstitialAd();
                AdsManager().showInterstitialAd();
              }, child: Text("data"),),
              ElevatedButton(onPressed: () {
                AdsManager().loadRewardedAd();
                AdsManager().showRewardedAd();
              }, child: Text("data"),),*/
                  /* isBannerAdReady
    ? Container(
    height: bannerAd!.size.height.toDouble(),
    width: bannerAd!.size.width.toDouble(),
    child: AdWidget(ad: bannerAd!),
    )
        : SizedBox.shrink(),*/
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "To get you started",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 290,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songController.songModelList.length > 5
                            ? 5
                            : songController.songModelList.length,
                        itemBuilder: (context, index) {
                          final song = songController.songModelList[index];
                          // final isFavorite = favoriteController.isFavorite(song.id);

                          return InkWell(
                            onTap: () {
                              AdsManager().loadRewardedAd();
                              AdsManager().showRewardedAd();
                              listenHistory.addSongToHistory(
                                  song.id,
                                  song.songName,
                                  song.artist,
                                  song.songUrl,
                                  song.songImg,
                                  song.description);
                              Get.to(
                                  MusicPlayer(
                                    ModelList: songController.songModelList,
                                  ),
                                  arguments: index);
                              playerController.setupAudioPlayer(
                                  songController.songModelList[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        song.songImg,
                                      ),
                                      fit: BoxFit.cover,
                                      opacity: 0.2)),
                              child: SizedBox(
                                width: 190,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Image.network(
                                        song.songImg,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        song.songName,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      subtitle: Text(
                                        song.artist,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Try something else",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: (songController.songModelList.length > 10)
                            ? 5
                            : (songController.songModelList.length - 5)
                                .clamp(0, 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Adjust index to start from 5 (i.e., index 5 in 0-based index)
                          final songIndex = index + 5;
                          if (songIndex >=
                              songController.songModelList.length) {
                            return const SizedBox
                                .shrink(); // Return an empty widget if the index is out of bounds
                          }
                          final song = songController.songModelList[songIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                AdsManager().loadRewardedAd();
                                AdsManager().showRewardedAd();
                                listenHistory.addSongToHistory(
                                    song.id,
                                    song.songName,
                                    song.artist,
                                    song.songUrl,
                                    song.songImg,
                                    song.description);
                                Get.to(
                                    MusicPlayer(
                                      ModelList: songController.songModelList,
                                    ),
                                    arguments: songIndex);
                                playerController.setupAudioPlayer(
                                    songController.songModelList[songIndex]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          song.songImg,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.2)),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 190,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          song.songImg,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          song.songName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          song.artist,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Recently played",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: (songController.songModelList.length > 15)
                            ? 5
                            : (songController.songModelList.length - 10)
                                .clamp(0, 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Adjust index to start from 10 (i.e., index 10 in 0-based index)
                          final songIndex = index + 10;
                          if (songIndex >=
                              songController.songModelList.length) {
                            return const SizedBox
                                .shrink(); // Return an empty widget if the index is out of bounds
                          }
                          final song = songController.songModelList[songIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                AdsManager().loadRewardedAd();
                                AdsManager().showRewardedAd();
                                listenHistory.addSongToHistory(
                                    song.id,
                                    song.songName,
                                    song.artist,
                                    song.songUrl,
                                    song.songImg,
                                    song.description);
                                Get.to(
                                    MusicPlayer(
                                      ModelList: songController.songModelList,
                                    ),
                                    arguments: songIndex);
                                playerController.setupAudioPlayer(
                                    songController.songModelList[songIndex]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          song.songImg,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.2)),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 190,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          song.songImg,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          song.songName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          song.artist,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Recommend for you",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: (songController.songModelList.length > 20)
                            ? 5
                            : (songController.songModelList.length - 15)
                                .clamp(0, 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Adjust index to start from 15 (i.e., index 15 in 0-based index)
                          final songIndex = index + 15;
                          if (songIndex >=
                              songController.songModelList.length) {
                            return const SizedBox
                                .shrink(); // Return an empty widget if the index is out of bounds
                          }
                          final song = songController.songModelList[songIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                AdsManager().loadRewardedAd();
                                AdsManager().showRewardedAd();
                                listenHistory.addSongToHistory(
                                    song.id,
                                    song.songName,
                                    song.artist,
                                    song.songUrl,
                                    song.songImg,
                                    song.description);
                                Get.to(
                                    MusicPlayer(
                                      ModelList: songController.songModelList,
                                    ),
                                    arguments: songIndex);
                                playerController.setupAudioPlayer(
                                    songController.songModelList[songIndex]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          song.songImg,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.2)),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 190,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          song.songImg,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          song.songName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          song.artist,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Shows to try",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: (songController.songModelList.length > 25)
                            ? 5
                            : (songController.songModelList.length - 20)
                                .clamp(0, 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Adjust index to start from 20 (i.e., index 20 in 0-based index)
                          final songIndex = index + 20;
                          if (songIndex >=
                              songController.songModelList.length) {
                            return const SizedBox
                                .shrink(); // Return an empty widget if the index is out of bounds
                          }
                          final song = songController.songModelList[songIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                AdsManager().loadRewardedAd();
                                AdsManager().showRewardedAd();
                                listenHistory.addSongToHistory(
                                    song.id,
                                    song.songName,
                                    song.artist,
                                    song.songUrl,
                                    song.songImg,
                                    song.description);
                                Get.to(
                                    MusicPlayer(
                                      ModelList: songController.songModelList,
                                    ),
                                    arguments: songIndex);
                                playerController.setupAudioPlayer(
                                    songController.songModelList[songIndex]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          song.songImg,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.2)),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 190,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          song.songImg,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          song.songName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          song.artist,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Fresh new music",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: (songController.songModelList.length > 30)
                            ? 5
                            : (songController.songModelList.length - 25)
                                .clamp(0, 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Adjust index to start from 25 (i.e., index 25 in 0-based index)
                          final songIndex = index + 25;
                          if (songIndex >=
                              songController.songModelList.length) {
                            return const SizedBox
                                .shrink(); // Return an empty widget if the index is out of bounds
                          }
                          final song = songController.songModelList[songIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () async {
                                AdsManager().loadRewardedAd();
                                AdsManager().showRewardedAd();
                                await listenHistory.addSongToHistory(
                                    song.id,
                                    song.songName,
                                    song.artist,
                                    song.songUrl,
                                    song.songImg,
                                    song.description);
                                Get.to(
                                    MusicPlayer(
                                      ModelList: songController.songModelList,
                                    ),
                                    arguments: songIndex);
                                playerController.setupAudioPlayer(
                                    songController.songModelList[songIndex]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          song.songImg,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.2)),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 190,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          song.songImg,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          song.songName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          song.artist,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // bottomNavigationBar: const BottomNavBarScreen(),
          ),
        ));
  }
}
