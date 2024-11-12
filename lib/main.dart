import 'package:flutter/material.dart';
import 'package:pravin_mspl/ui_helper/custom_colors.dart';
import 'package:pravin_mspl/view/tabsscreenviews/shorts_videos/shorts_video_player.dart';
import 'package:pravin_mspl/view/tabsscreenviews/tabs_screen.dart';
import 'package:pravin_mspl/view/dynamic_tabview/videosection_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      //ShortVideoHomePage(),
      VideoSectionMain(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: CustomColors.clrwhite,
        ),

        // tabBarTheme: const TabBarTheme(
        //     overlayColor: WidgetStateColor.transparent
        // )
      ),
    );

  }
}
