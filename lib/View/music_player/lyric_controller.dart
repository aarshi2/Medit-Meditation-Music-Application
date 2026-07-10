import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareController extends GetxController {
  final lyrics = ''.obs;
  final selectedLineIndices = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedLineIndices.contains(index)) {
      selectedLineIndices.remove(index);
    } else {
      if (_isSelectable(index)) {
        selectedLineIndices.add(index);
        selectedLineIndices.sort();
      } else {
        selectedLineIndices.clear();
        selectedLineIndices.add(index);
      }
    }
  }

  bool _isSelectable(int index) {
    if (selectedLineIndices.isEmpty) return true;
    if (selectedLineIndices.contains(index)) {
      // Deselect all lines if the index is already selected
      selectedLineIndices.clear();
      return false;
    }
    if (selectedLineIndices.length >= 4) return false;
    return (index == selectedLineIndices.first - 1) || (index == selectedLineIndices.last + 1);
  }

  Future<void> shareSelectedLyrics(List<String> lyricsLines) async {
    final selectedLines = selectedLineIndices.map((index) => lyricsLines[index]).join('\n');
    Share.share(selectedLines);
  }

  void setLyrics(String lyricsText) {
    lyrics.value = lyricsText;
  }
}

