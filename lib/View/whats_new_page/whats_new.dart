import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/resources/color.dart';

class WhatsNew extends StatefulWidget {
  const WhatsNew({super.key});

  @override
  State<WhatsNew> createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  final MyController songController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "What's New",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "The latest releases from artists, podcasts, and shows you follow.",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                      () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: songController.songModelList.length,
                    itemBuilder: (context, index) {
                      final song = songController.songModelList[index];
                      return Card(
                        color: Colors.white12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: Image.network(
                            song.songImg,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            song.songName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            song.artist,
                            style: const TextStyle(
                              color: Colors.white70,
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
      ),
    );
  }
}
