import 'package:get/get.dart';
import 'package:medit_app/View/explore_screen/categories_screen/inspiration/inspiration_playlist.dart';
import 'package:medit_app/View/explore_screen/categories_screen/nature/nature_playlist.dart';
import 'package:medit_app/View/explore_screen/categories_screen/spiritual/spiritual_playlist.dart';
import 'package:medit_app/modal/search_modal.dart';
import 'categories_screen/relaxing/relax_playlist.dart';

class ListController extends GetxController {
  var explore = [
    Genre(name: "Relaxing", image:"asset/img_4.png",page:  const RelaxPlaylist()),
    Genre(name: "Spiritual", image: "asset/spiritual.jpeg",page:  const SpiritualPlaylist()),
    Genre(name: "Nature", image: "asset/img_3.png",page:  const NaturePlaylist()),
    Genre(name: "Inspiration", image: "asset/inspiration.jpeg",page:  const InspirationPlaylist()),
  ].obs;


}
