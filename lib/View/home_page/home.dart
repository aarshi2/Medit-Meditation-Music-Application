import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/home_page/tabbar_page/app_page/controller_all.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/resources/color.dart';
import 'package:medit_app/View_model/drawer/drawer.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AllController allController = Get.put(AllController());
  final MyController songController = Get.put(MyController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
          ),
        ),

        drawer: const MyDrawer(),

        backgroundColor: Colors.transparent,
        //tabbar screen
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 330,
                width: double.maxFinite,
                child: Obx(
                      () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songController.songModelList.length,
                      itemBuilder: (context, index) {
                        final song = songController.songModelList[index];
                        // final isFavorite = favoriteController.isFavorite(song.id);

                        return InkWell(
                          onTap: () {
                            Get.to(MusicPlayer(ModelList: songController.songModelList,),arguments: song);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: 150,
                            child: Column(
                              children: [
                                Image.network(song.songImg,height: 150,),
                                ListTile(
                                  title: Text(song.songName,style: const TextStyle(color: Colors.white),),
                                  subtitle: Text(song.artist,style: const TextStyle(color: Colors.white),),

                                )],
                            ),
                          ),
                        );


                      }),
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
                height: 160,
                width: double.maxFinite,
                child: Obx(
                      () => ListView.builder(
                    itemCount: allController.All.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = allController.All[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(item["image"]!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
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
                height: 160,
                width: double.maxFinite,
                child: Obx(
                      () => ListView.builder(
                    itemCount: allController.All.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = allController.All[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(item["image"]!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['name']!,
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recommendad for you",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 160,
                width: double.maxFinite,
                child: Obx(
                      () => ListView.builder(
                    itemCount: allController.All.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = allController.All[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(item["image"]!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
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
                height: 160,
                width: double.maxFinite,
                child: Obx(
                      () => ListView.builder(
                    itemCount: allController.All.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = allController.All[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              // ignore: prefer_const_constructors
                              image: NetworkImage(item["image"]!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
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
                height: 160,
                width: double.maxFinite,
                child: Obx(
                      () => ListView.builder(
                    itemCount: allController.All.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = allController.All[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(item["image"]!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
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

            ],
          ),
        ),

        /* const TabBarView(
          children: [
          *//*  AllPage(),
            MusicPage(),
            PodcastsPage(),*//*
          ],
        ),*/
      ),
    );
  }
}