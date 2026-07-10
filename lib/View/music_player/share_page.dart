import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lyric_controller.dart';


class ShareScreen extends StatelessWidget {
  final String lyrics;

  ShareScreen({super.key, required this.lyrics}) {
    final ShareController controller = Get.put(ShareController());
    controller.setLyrics(lyrics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Select Lyrics', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          GetX<ShareController>(
            builder: (controller) {
              if (controller.selectedLineIndices.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () => controller.shareSelectedLyrics(controller.lyrics.value.split('\n')),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetX<ShareController>(
          builder: (controller) {
            final lyricsLines = controller.lyrics.value.split('\n');
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: lyricsLines.length,
                    itemBuilder: (context, index) {
                      final line = lyricsLines[index];
                      final isSelected = controller.selectedLineIndices.contains(index);
                      final isAboveSelected = controller.selectedLineIndices.contains(index + 1);
                      final isBelowSelected = controller.selectedLineIndices.contains(index - 1);

                      if (line.trim().isEmpty) {
                        // Skip blank lines
                        return const SizedBox.shrink();
                      }

                      return GestureDetector(
                        onTap: () {
                          controller.toggleSelection(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.black
                                : (isAboveSelected || isBelowSelected)
                                ? Colors.white10
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            line,
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (controller.selectedLineIndices.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => controller.shareSelectedLyrics(lyricsLines),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Share'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
