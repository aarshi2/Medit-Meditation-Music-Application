import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/resources/color.dart';
import 'lang_controller.dart';
//import 'language_controller.dart'; // Import the controller

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController controller = Get.put(LanguageController());

    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),

      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Text("Language",style: TextStyle(color:Colors.white ),),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Obx(() => RadioListTile(
                            title: const Text('English'),
                            value: 1,
                            groupValue: controller.selectedValue.value,
                            onChanged: (value) {
                              controller.changeLanguage(value!);
                              Navigator.pop(context); // Close the modal sheet
                            },
                          )),
                          Obx(() => RadioListTile(
                            title: const Text('Hindi'),
                            value: 2,
                            groupValue: controller.selectedValue.value,
                            onChanged: (value) {
                              controller.changeLanguage(value!);
                              Navigator.pop(context); // Close the modal sheet
                            },
                          )),
                          Obx(() => RadioListTile(
                            title: const Text('Gujarati'),
                            value: 3,
                            groupValue: controller.selectedValue.value,
                            onChanged: (value) {
                              controller.changeLanguage(value!);
                              Navigator.pop(context); // Close the modal sheet
                            },
                          )),
                        ],
                      );
                    },
                  );
                },
                child: const ListTile(
                  title: Text(
                    "App Language",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color:Colors.white ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Sets the language for your app, notifications and emails from Medit",
                      style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),
                    ),
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
