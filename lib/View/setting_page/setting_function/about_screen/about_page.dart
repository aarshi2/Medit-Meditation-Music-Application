import 'package:flutter/material.dart';
import 'package:medit_app/resources/color.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override

  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),

      child: Scaffold(
        // Using Text to write in app bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("About",style: TextStyle(color:Colors.white ),),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.all(10),
          child:   const Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 17
                    ,),
                  Text("Version",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),),
                  SizedBox(width: 220,),
                  Text("8.9.42.575",style: TextStyle(color: Colors.white,fontSize: 14),)
                ],
              ),
           SizedBox(height: 10),
           ListTile(
            title: Text("Third-party software",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
            subtitle: Text(
              "Sweet software that helped us",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),

          ),
              //SizedBox(height: 10),
              ListTile(
                title: Text("Terms and condition",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
                subtitle: Text(
                  "All the stuff you need to know",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(Icons.screen_share_outlined,color: Colors.white,),

              ),

              ListTile(
                title: Text("Privacy policy",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
                subtitle: Text(
                  "Important for both of us",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(Icons.screen_share_outlined,color: Colors.white,),

              ),
              ListTile(
                title: Text("Platform rules",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
                subtitle: Text(
                  "Help keep Spotify safe for all",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(Icons.screen_share_outlined,color: Colors.white,),

              ),
              ListTile(
                title: Text("Support",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
                subtitle: Text(
                  "Get help from us and the community",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(Icons.screen_share_outlined,color: Colors.white,),

              )



            ],
          ),
        ),


      ),
    );
  }
}
