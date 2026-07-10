import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/resources/color.dart';
import 'controller_acc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ControllerSetting controllerSetting = Get.put(ControllerSetting());
  int tappedIndex = -1;

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
            "Settings",
            style: TextStyle(color: Colors.white,
                fontSize: 23),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          // Remove const keyword here
          children: [
            const Center(
              child: Text(
                "Free Account",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controllerSetting.items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListTile(
                              selected: false,

                              //visualDensity: VisualDensity(horizontal: 10),
                              title: Text(
                                controllerSetting.items[index]["text"],
                                style: const TextStyle(color: Colors.white),
                              ),

                              leading: Icon(
                                controllerSetting.items[index]["icon"],
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  controllerSetting.items[index]
                                      ["navigation"]();
                                });
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: BorderDirectional(
                                    bottom: BorderSide(color: Colors.white))),
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
