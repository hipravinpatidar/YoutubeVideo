// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/model/newtabs_model.dart';
// import 'package:pravin_mspl/ui_helper/custom_colors.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import '../../model/playlist_model.dart';
//
// class YoutubePlayerScreen extends StatefulWidget {
//  // final dynamicTabs dynamicTabs;
//   final DynamicTabs dynamicTabs;
//   final int currentIndex;
//
//   const YoutubePlayerScreen({super.key, required this.dynamicTabs,required this.currentIndex});
//
//   @override
//   _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
// }
//
// class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
//   int _currentIndex = 0;
//
//   late YoutubePlayerController youtubePlayerController;
//   late YoutubeMetaData videoMetaData;
//   var isPlayerReady = false;
//
//   @override
//   void initState() {
//      _currentIndex = widget.currentIndex;
//      videoMetaData = const YoutubeMetaData();
//     youtubePlayerController = YoutubePlayerController(
//       initialVideoId: getVideoId(widget.dynamicTabs.data[_currentIndex].videos[0].url ?? ''),
//       flags: const YoutubePlayerFlags(
//         useHybridComposition: true,
//         mute: false,
//         autoPlay: true,
//       ),
//     )..addListener(listener);
//     super.initState();
//   }
//
//   String getVideoId(String url) {
//     final RegExp regExp = RegExp(r"[?&]v=([^&#]*)");
//     final match = regExp.firstMatch(url);
//     return match?.group(1) ?? '';
//   }
//
//   void listener() {
//     if (isPlayerReady && mounted && !youtubePlayerController.value.isFullScreen) {
//       setState(() {
//         videoMetaData = youtubePlayerController.metadata;
//       });
//     }
//   }
//
//   @override
//   void deactivate() {
//     // Pauses video while navigating to next page.
//     youtubePlayerController.pause();
//     super.deactivate();
//   }
//
//   @override
//   void dispose() {
//     youtubePlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     var screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//
//     return Scaffold(
//       body: SafeArea(
//         child: YoutubePlayerBuilder(
//           onExitFullScreen: () {
//             // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//            // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//           },
//           player: YoutubePlayer(controller: youtubePlayerController),
//           builder: (BuildContext context, Widget wid) {
//             return Column(
//               children: [
//                 AppBar(
//                 leading: GestureDetector(onTap: () {
//                   Navigator.pop(context);
//                 },child: Icon(Icons.arrow_back,color: CustomColors.clrblack,size: screenWidth * 0.07,)),
//                 automaticallyImplyLeading: false,
//                 title: Text(widget.dynamicTabs.data[_currentIndex].listType ?? '',style: TextStyle(fontSize: screenWidth * 0.06,color: CustomColors.clrorange,fontWeight: FontWeight.w500),)),
//
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: YoutubePlayer(
//                       //thumbnail: Image.network(widget.dynamicTabs.data[_currentIndex].videos[0].image),
//                       controller: youtubePlayerController,
//                       showVideoProgressIndicator: true,
//                       onReady: () {
//                         isPlayerReady = true;
//                         print('Player is ready.');
//                       },
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(7),
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Text(widget.dynamicTabs.data[_currentIndex].listType ?? '',style: const TextStyle(fontWeight: FontWeight.bold),)),
//
//                 Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GridView.builder(
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           childAspectRatio: 3.0,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 20,
//                           crossAxisCount: 1,
//                         ),
//                         itemCount: widget.dynamicTabs.data[_currentIndex].videos.length,
//                         itemBuilder: (context,videoIndex ){
//                           return InkWell(
//                             onTap: (){
//                               youtubePlayerController.load(getVideoId(widget.dynamicTabs.data[_currentIndex].videos[videoIndex].url ?? ''));
//                               },
//                             child: Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey.shade600),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     flex:1,
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius:
//                                         BorderRadius.circular(7),
//                                         image: DecorationImage(
//                                             image: NetworkImage(widget.dynamicTabs.data[_currentIndex].videos[videoIndex].image ?? ''),
//                                             fit: BoxFit.cover),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex:1,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
//                                       child: Text(widget.dynamicTabs.data[_currentIndex].videos[videoIndex].title,style: const TextStyle(fontWeight: FontWeight.w500),),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
