import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/explore_screen/categories_screen/relaxing/relax_controller.dart';
import 'package:medit_app/View/explore_screen/controller_search.dart';
import 'package:medit_app/View/favourite_screen/favourite_page.dart';
import 'package:medit_app/View/library_screen/controller_palylist.dart';
import 'package:medit_app/View/library_screen/your_palylist.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'controller_library.dart';

class YourLibraryBody extends StatefulWidget {
  const YourLibraryBody({super.key});

  @override
  State<YourLibraryBody> createState() => _YourLibraryBodyState();
}

class _YourLibraryBodyState extends State<YourLibraryBody> {
  final ControllerLibrary playlistController = Get.put(ControllerLibrary());
  final ListController listController = Get.put(ListController());
  final RelaxController songList = Get.put(RelaxController());
  final SignupController signupController = Get.put(SignupController());
  final YourPalylist yourpalylist = Get.put(YourPalylist());
  bool isdelete = false;
  List<int> selectedPlaylists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signupController.fetchPlaylist();
    yourpalylist.fetchPlaylist();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: const Alignment(0.7, 1),
      colors: <Color>[
        Colors.deepPurple.withOpacity(0.7),
        Colors.black.withOpacity(0.8),
      ],
      tileMode: TileMode.mirror,
    ),
          ),
          child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Row(
        children: [
          SizedBox(width: 10),
          Text(
            'Your Library',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle search icon press
          },
        ),
        IconButton(
          onPressed: () {
            showMenu(
              context: context,
              position: const RelativeRect.fromLTRB(70, 70, 0, 0),
              // Change this to position the popup menu
              items: [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Select",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    "Select All",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    "Unselect All",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text(
                    "Delete",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ).then((value) async {
              // Handle the selected option here
              if (value != null) {
                switch (value) {
                  case 0:
                  // Do something for Select
                    setState(() {
                      isdelete =! isdelete;
                    });
                    break;
                  case 1:
                  // Select all items
                    setState(() {
                      selectedPlaylists = List<int>.generate(
                          yourpalylist.playlists.length, (index) => index);
                      isdelete = true;
                    });
                    break;
                  case 2:
                  // Delete selected items
                    setState((){
                      selectedPlaylists.clear();
                      isdelete = false;
                    });
                    break;
                  case 3:
                  // Delete selected items
                    setState(() async {
                      for (int index in selectedPlaylists) {
                        await yourpalylist.deletePlaylist(index);
                      }
                      selectedPlaylists.clear();
                      await signupController.fetchPlaylist();
                      yourpalylist.fetchPlaylist();
                      yourpalylist.fetchPlaylist();
                      isdelete = false;
                    });
                    break;
                }
              }
            });
          },
          icon: const Icon(Icons.more_vert, color: Colors.white),
        )
      ],
    ),
    backgroundColor: Colors.transparent,
    body: SingleChildScrollView(
      child: Column(
        children: [
          /*
          ListTile(
            onTap: () async {
              await signupController.fetchPlaylist();
              Get.to(const PlaylistPage());
            },
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg'),
              radius: 30,
            ),
            title: const Text(
              'Your Playlist',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'songs',
              style: TextStyle(color: Colors.white),
            ),
          ),
    */
          ListTile(
            onTap: () {
              Get.to(const FavScreen());
            },
            title: const Text(
              "Your Favorite",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              "Songs",
              style: TextStyle(color: Colors.white),
            ),
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg'),
            ),
          ),
          Obx(
                () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: yourpalylist.playlists.length,
              itemBuilder: (context, index) {
                // Extract the key (playlist name) from the map
                String playlistName =
                    yourpalylist.playlists[index].keys.first;
                //  print("print palylist.......${yourpalylist.playlist}");
                var playlistSongs = signupController.playlist[index]
                [playlistName][0]["songImg"] ??[];
                // print(playlistSongs);
                String? firstSongImg;
                if (playlistSongs.isNotEmpty) {
                  firstSongImg = playlistSongs;
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: firstSongImg != null
                          ? NetworkImage(firstSongImg)
                          : const NetworkImage(""),
                      // Use the first song's image if available
                      child: firstSongImg == null
                          ? const Icon(Icons.music_note,
                          color: Colors.white)
                          : null, // Show a default icon if no image is available
                    ),
                    title: Text(
                      playlistName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onLongPress: () {
                      setState(() {
                        isdelete = !isdelete;
                      });
                    },
                    // subtitle:Text("song ${yourpalylist.songL}",style: TextStyle(color: Colors.white),),
                    trailing: isdelete
                        ? Checkbox(
                      side: const BorderSide(color: Colors.white),
                      checkColor: Colors.white,
                      activeColor: Colors.deepPurple,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.deepPurple)),
                      value: selectedPlaylists.contains(index),
                      onChanged: (value) {
                        setState(() {
                          if (isdelete == true) {
                            selectedPlaylists.add(index);

                          } else {
                            selectedPlaylists.remove(index);

                          }
                        });
                      },
                      /*  yourpalylist.deletePlaylist(index);
                              await yourpalylist.fetchPlaylist();
                              await yourpalylist.fetchPlaylist();
                              yourpalylist.playlists;*/
                    )
                        : const Icon(
                      Icons.delete,
                      color: Colors.transparent,
                    ),
                    onTap: () async {
                      if (isdelete) {
                        setState(()  {
                          if (selectedPlaylists.contains(index)) {
                            selectedPlaylists.remove(index);
                          } else {
                            selectedPlaylists.add(index);
                          }
                        });
                      } else {
                        yourpalylist.fetchPlaylistModel(
                            playlistName, index);
                        if (kDebugMode) {
                          print("print data ${yourpalylist.playlistModel}");
                        }
                        Get.to(const YourPalyList());
                      }
                    },
                  ),
                );
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listController.explore.length,
            itemBuilder: (context, index) {
              var item = listController.explore[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: ListTile(
                  title: Text(
                    item.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  // subtitle: const Text('10 Song',style: TextStyle(color: Colors.white,fontSize: 12),),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(item.image),
                    radius: 30,
                  ),
                  onTap: () {
                    Get.to(item.page);
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
          ),
        );
  }
}
