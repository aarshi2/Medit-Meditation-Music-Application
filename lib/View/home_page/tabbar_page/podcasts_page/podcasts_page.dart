import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:medit_app/view/home_page/tabbar_page/podcasts_page/controller_podcasts.dart';
import 'package:medit_app/view/home_page/tabbar_page/podcasts_page/showmore_text.dart';

class PodcastsPage extends StatefulWidget {
  const PodcastsPage({super.key});

  @override
  State<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends State<PodcastsPage> {
  PodcastsController podcastsController = Get.put(PodcastsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => ListView.builder(
          itemCount: podcastsController.Podcasts.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var item = podcastsController.Podcasts[index];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(item["image"]!), fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
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
                          Expanded(
                            flex: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          Expanded(
                            flex: 80,
                            child: Padding(
                              padding: EdgeInsets.only(left: 11),
                              child: Text(
                                "Lorem Ipsum is simply dummy text",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: SizedBox(),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://img.freepik.com/free-psd/music-channel-podcast-cover-template_23-2151366385.jpg?w=740&t=st=1716460530~exp=1716461130~hmac=fae26cbb1f52d114eb154f75f4b1708d4e9dca13cdd442f8b9f002c07f0e2930"))),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: ShowMoreText(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          maxLength: 50,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 65,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: Icon(Icons.volume_mute),
                                      ),
                                      Expanded(
                                        flex: 70,
                                        child: Text("preview episode"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                    ))),
                          ),
                          Expanded(
                            flex: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.play_circle,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
