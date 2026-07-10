import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/home_page/tabbar_page/app_page/all_page.dart';
import 'package:medit_app/View/library_screen/your_library_body.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/view/explore_screen/search_screen.dart';
import 'package:medit_app/view/premium_screen/premium_page.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:text_scroll/text_scroll.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});
  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

bool isplay = false;

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final PlayerController playerController = Get.put(PlayerController());
  final MyController songController = Get.put(MyController());

  int selectedIndex = 0;
  List selectedIndex1 = [];
  static final List<Widget> widgetOptions = <Widget>[
    const AllPage(),
    const SearchScreen(),
    const YourLibraryBody(),
    const PremiumScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      selectedIndex1.add(index);
      print("print index $selectedIndex1");
    });
  }

  //how many
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(selectedIndex1.length > 0){
          setState(() {
            selectedIndex = selectedIndex1.last;
            selectedIndex1.removeLast();
            print("print last index$selectedIndex");
          });
        }
       else{
         setState(() {
           selectedIndex =0;
         });
        }
          // Handle the back button press logic
          // Don't exit the app
      },
      child: Scaffold(
        body: Stack(
          children: [
            widgetOptions.elementAt(selectedIndex),
            isplay
                ? Miniplayer(
                    backgroundColor: Colors.transparent,
                    minHeight: 70,
                    maxHeight: 70,
                    builder: (height, percentage) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity! > 0) {
                            playerController.decreaseIndex();
                            playerController.setupAudioPlayer(
                                songController.songModelList[
                                    playerController.playerIndex.value]);
                          } else if (details.primaryVelocity! < 0) {
                            playerController.increaseIndex();
                            playerController.setupAudioPlayer(
                                songController.songModelList[
                                    playerController.playerIndex.value]);
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                MusicPlayer(
                                  ModelList: songController.songModelList,
                                ),
                                arguments: playerController.playerIndex.value);
                          },
                          child: Obx(
                            () => Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                    Colors.deepPurple.withOpacity(0.7),
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  tileMode: TileMode.mirror,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.deepPurple,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  playerController
                                                      .modelList[
                                                          playerController
                                                              .playerIndex
                                                              .value]
                                                      .songImg),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextScroll(
                                          playerController
                                              .modelList[playerController
                                                  .playerIndex.value]
                                              .songName,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        TextScroll(
                                          playerController
                                              .modelList[playerController
                                                  .playerIndex.value]
                                              .description,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  playerController.playbackControlButton(35.0),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isplay = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                ),
                label: "Explore",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_music,
                ),
                label: "Your Library",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.ac_unit_outlined,
                ),
                label: "Premium",
                backgroundColor: Colors.white),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedIconTheme:
              const IconThemeData(color: Colors.deepPurple, size: 35),
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.white,
          iconSize: 25,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
