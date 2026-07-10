import 'package:flutter/material.dart';
import 'package:medit_app/resources/color.dart';
import 'package:medit_app/modal/premium_modal.dart';
import 'controller_premium.dart';


class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final PremiumController _controller = PremiumController();

  @override
  Widget build(BuildContext context) {
    List<Premium> mapList = _controller.getPremiumPlans();

    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(
                "https://www.theaudiostore.in/cdn/shop/articles/Why_Does_Music_Sound_Better_at_Night_Exploring_the_Science_behind_the_Phenomenon.png?v=1681157018",
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Upgrade to Medit Premium',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Enjoy ad-free music, offline listening, and more!',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:Colors.black.withOpacity(0.1),
                  ),
                  onPressed: () {
                    // Handle button tap
                  },
                  child: const Text('Get Premium'),
                ),
              ),
              const SizedBox(height: 20),
              const ListTile(
                leading: Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
                title: Text(
                  'Ad-Free Music',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Listen to music without interruptions.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
                title: Text(
                  'Offline Listening',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Download your favorite tracks to listen offline.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.high_quality,
                  color: Colors.white,
                ),
                title: Text(
                  'High Quality Audio',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Enjoy music in high fidelity.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: mapList.map((premiumPlan) {
                  return Card(
                    color: Colors.black.withOpacity(0.1),
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                AssetImage("asset/image_360.png"),
                              ),
                              Text(
                                "  Premium",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            premiumPlan.name ?? 'N/A',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            premiumPlan.price ?? 'N/A',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            height: 18,
                            color: Colors.white,
                          ),
                          Text(
                            premiumPlan.desc ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            premiumPlan.footer ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
