// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/view/example_shorts/video_shorts_service.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// import 'flick_multi_player.dart';
// import 'mock_data.dart';
// import 'flick_multi_manager.dart';
//
// class AllShortsPlayer extends StatefulWidget {
//   const AllShortsPlayer({Key? key}) : super(key: key);
//
//   @override
//   AllShortsPlayerState createState() => AllShortsPlayerState();
// }
//
// class AllShortsPlayerState extends State<AllShortsPlayer> {
//   List items = [];
//
//   late FlickMultiManager flickMultiManager;
//
//   @override
//   void initState() {
//     super.initState();
//     getVideoData();
//     flickMultiManager = FlickMultiManager();
//   }
//
//   Future<void> getVideoData() async {
//     List<String> paths = await Future.wait([
//       for (var data in shortVideoMockData['items'])
//         VideoService.getVideoPath(data['trailer_url'])
//     ]);
//     items.addAll(paths);
//     if (mounted) setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return VisibilityDetector(
//       key: ObjectKey(flickMultiManager),
//       onVisibilityChanged: (visibility) {
//         if (visibility.visibleFraction == 0 && mounted) {
//           flickMultiManager.pause();
//         }
//       },
//       child: PageView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Container(
//               height: 800,
//               margin: const EdgeInsets.all(2),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: FlickMultiPlayer(
//                   url: items[index],
//                   flickMultiManager: flickMultiManager,
//                   image: shortVideoMockData['items'][index]['image'],
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }