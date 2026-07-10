// premium_controller.dart
import 'package:flutter/material.dart';
import 'package:medit_app/modal/premium_modal.dart';

class PremiumController {
  List<Premium> getPremiumPlans() {
    return [
      Premium(
        name: 'Mini',
        price: '\$7 for 1/day,\n\$25 for 1/week',
        desc: ' - 1 Premium account\n - Cancel anytime\n - Subscribe or one-time payment',
        image: 'asset/image_360.png',
        color: Colors.white24,
        footer: "You can't upgrade to premium in the app. We know, it's not ideal.",
      ),
      Premium(
        name: 'Individual',
        price: '\$119 for 2 months,\n\$171 / month after',
        desc: ' - Up to 6 Premium accounts\n - Control content marked as explicit\n - Cancel anytime\n - Subscribe or one-time payment',
        image: 'asset/image_360.png',
        color: Colors.white12,
        footer: "You can't upgrade to premium in the app. We know, it's not ideal.",
      ),
      Premium(
        name: 'Family',
        price: '\$179 for 2 months,\n\$179 / month after',
        desc: ' - Up to 6 Premium accounts\n - Control content marked as explicit\n - Cancel anytime\n - Subscribe or one-time payment',
        image: 'asset/image_360.png',
        color: Colors.white30,
        footer: "You can't upgrade to premium in the app. We know, it's not ideal.",
      ),
      Premium(
        name: 'Duo',
        price: '\$149 for 2 months,\n\$149 / month after',
        desc: ' - 2 Premium accounts\n - Cancel anytime\n - Subscribe or one-time payment',
        image: 'asset/image_360.png',
        color: Colors.white,
        footer: "You can't upgrade to premium in the app. We know, it's not ideal.",
      ),
      Premium(
        name: 'Student',
        price: '\$59 for 2 months,\n\$59 / month after',
        desc: ' - 1 verified Premium account\n - Discount for eligible students\n - Cancel anytime\n - Subscribe or one-time payment',
        image: 'asset/image_360.png',
        color: Colors.black,
        footer: "You can't upgrade to premium in the app. We know, it's not ideal.",
      ),
    ];
  }
}
