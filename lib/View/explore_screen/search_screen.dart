import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/explore_screen/controller_search.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/modal/song_modal.dart';
import 'package:medit_app/resources/color.dart';
import 'package:medit_app/view_model/drawer/drawer.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ListController listController = Get.put(ListController());
  final MyController songController = Get.put(MyController());
  final PlayerController playerController = Get.put(PlayerController());

  final TextEditingController searchController = TextEditingController();
  final RxList<SongModel> filteredSongs = <SongModel>[].obs;

  @override
  void initState() {
    super.initState();
    filteredSongs.addAll(songController.songModelList);
    searchController.addListener(filterSongs);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterSongs() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredSongs.assignAll(songController.songModelList);
    } else {
      filteredSongs.assignAll(
        songController.songModelList.where((song) {
          return song.songName.toLowerCase().contains(query);
        }).toList(),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: GradientDecoration.getBackground(),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text("Search",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            backgroundColor: Colors.transparent,
          ),
          drawer: const MyDrawer(),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(

                          hintText: "What do you want to listen to?",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon:
                              Icon(Icons.search, size: 25, color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )
                      ),

                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Explore your genres",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,

                      // Set a fixed height for the horizontal ListView
                      child: Obx(
                        () => ListView.builder(
                          itemCount: listController.explore.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {

                            var item = listController.explore[index];
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  Get.to(item.page);
                                },
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(item.image),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Browse Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];
                          final originalIndex = songController.songModelList
                              .indexWhere((element) => element.id == song.id);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              key: ValueKey(song.id),
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                width: 80,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(song.songImg),
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
                                    Get.to(
                                        MusicPlayer(
                                          ModelList: songController.songModelList,
                                        ),
                                        arguments: originalIndex);
                                    playerController.setupAudioPlayer(
                                        songController
                                            .songModelList[originalIndex]);
                                  },
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  )),

                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
