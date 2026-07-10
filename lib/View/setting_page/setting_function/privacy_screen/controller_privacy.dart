import 'package:get/get.dart';

class ControllerPri extends GetxController {
  // Declare observable variables
  var isSwitchedFollowers = false.obs;
  var isSwitchedPrivateSession = true.obs;
  var isSwitchedListeningActivity = false.obs;

  // Methods to toggle the switches
  void toggleFollowersSwitch(bool value) {
    isSwitchedFollowers.value = value;
  }

  void togglePrivateSessionSwitch(bool value) {
    isSwitchedPrivateSession.value = value;
  }

  void toggleListeningActivitySwitch(bool value) {
    isSwitchedListeningActivity.value = value;
  }
}
