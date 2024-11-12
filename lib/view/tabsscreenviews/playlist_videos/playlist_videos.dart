// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/model/playlist_model.dart'as playlist;
// import '../../../model/playlist_model.dart';
// import '../../../ui_helper/custom_colors.dart';
// import '../../../utils/api_service.dart';
// import '../../youtube_player_screen/youtube_player_screen.dart';
//
// class PlaylistVideos extends StatefulWidget {
//   const PlaylistVideos({super.key, required this.subCategoryIdd, required this.categoryNamee, required this.tabType,});
//
//   final int subCategoryIdd;
//   final String categoryNamee;
//   final String tabType;
//
//   @override
//   State<PlaylistVideos> createState() => _PlaylistVideosState();
// }
//
// class _PlaylistVideosState extends State<PlaylistVideos> {
//   bool _hasData = false;
//   Timer? _timer;
//
//   PlayListModel? playListModel;
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     print("${widget.tabType}");
//     _fetchData();
//     _timer = Timer(const Duration(seconds: 5), () {
//       if (!mounted) return;
//       if (!_hasData) {
//         _showDialog();
//       }
//     });
//   }
//
//   Future<void> _fetchData() async {
//     try {
//       final data = await getList(widget.subCategoryIdd);
//       setState(() {
//         playListModel = data;
//         _hasData = true;
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
//
//
//   Future<PlayListModel> getList(int subCategory) async {
//    // final url = 'https://mahakal.rizrv.in/api/v1/astro?subcategory_id=$subCategory&list_type=${widget.tabType}';
//     final url = 'https://mahakal.rizrv.in/api/v1/astro?subcategory_id=${widget.subCategoryIdd}&listtype=${widget.tabType}';
//     var response = await ApiService().getPlayList(url);
//     return PlayListModel.fromJson(response);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     var screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//
//     if (!_hasData) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//
//   //  List<playlist.Datum> filteredVideos = playListModel!.data.where((video) => video. == 1).toList();
//
//     // Assuming `status` is the property used to filter videos
//    // List<playlist.Datum> filteredVideos = playListModel!.data.where((video) => video.status == 1).toList();
//
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: 3.0,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 20,
//           crossAxisCount: 1,
//         ),
//         itemCount: playListModel!.data.length,
//         itemBuilder: (BuildContext ctx, int index) {
//           playlist.Datum video = playListModel!.data[index];
//
//           return InkWell(
//             onTap: () {
//              // Navigator.push(context, MaterialPageRoute(builder: (context) => YoutubePlayerScreen(playListModel: playListModel!, currentIndex: index, dynamicTabs: null,),),);
//             },
//             child: Container(
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade600),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: screenWidth * 0.5,
//                     width: screenWidth * 0.4,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(7),
//                       image: DecorationImage(
//                         image: NetworkImage(video.videos[0].image),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
//                     child: SizedBox(
//                       width: screenWidth * 0.4
//                       , child: Text(
//                       video.playlistName,
//                       style: const TextStyle(fontWeight: FontWeight.w500,
//                           overflow: TextOverflow.ellipsis), maxLines: 2,
//                     ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: CustomColors.clrwhite,
//           title: const Text('No Playlist Found'),
//           content: const Text('There is no playlist available.'),
//           actions: [
//             ElevatedButton(
//               child: const Text(
//                 'Go Back', style: TextStyle(color: CustomColors.clrblack),),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pravin_mspl/model/newtabs_model.dart';
import 'package:pravin_mspl/model/playlist_model.dart'; // Adjust import as necessary
import 'package:pravin_mspl/view/youtube_player_screen/player_screen.dart';
import '../../../ui_helper/custom_colors.dart';
import '../../../utils/api_service.dart';
import '../../youtube_player_screen/youtube_player_screen.dart';

class PlaylistVideos extends StatefulWidget {
  const PlaylistVideos({
    super.key,
    required this.subCategoryIdd,
    required this.categoryNamee,
    required this.tabType,
  });

  final int subCategoryIdd;
  final String categoryNamee;
  final String tabType;

  @override
  State<PlaylistVideos> createState() => _PlaylistVideosState();
}

class _PlaylistVideosState extends State<PlaylistVideos> {
  bool _hasData = false;
  bool _isLoading = true;
  late Future<void> _fetchDataFuture;
  PlayListModel? playListModel;
  DynamicTabs? dynamicTabs;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await getList(widget.subCategoryIdd);
     // print('Fetched Data: ${data.toJson()}'); // Debug print
      setState(() {
        playListModel = data;
        _hasData = playListModel!.data.isNotEmpty;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
        _hasData = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _fetchData();
  }

  Future<PlayListModel> getList(int subCategory) async {
    final url =
        'https://mahakal.rizrv.in/api/v1/video/video-by-listType?subcategory_id=$subCategory&list_type=${widget.tabType}';
    var response = await ApiService().getPlayList(url);
    print('API Response: $response'); // Debug print
    return PlayListModel.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      onRefresh: _refreshData,
      color: CustomColors.clrblack,
      backgroundColor: CustomColors.clrwhite,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: CustomColors.clrblack,
                backgroundColor: CustomColors.clrwhite,
              ),
            )
          : _hasData
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenWidth * 0.02),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      //childAspectRatio: 3.0,
                      childAspectRatio: 3.3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      crossAxisCount: 1,
                    ),
                    itemCount: playListModel!.data.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      final video = playListModel!.data[index];

                      // Filter out videos with status other than 1
                      if (video.status != 1) {
                        return SizedBox.shrink(); // Skip this item
                      }

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayerScreen(
                                      currentIndex: index,
                                      playListModel: playListModel!)));
                          //YoutubePlayerScreen(dynamicTabs: dynamicTabs!, currentIndex: index, playListModel: playListModel!,),),);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: screenWidth * 0.5,
                                width: screenWidth * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                    image: NetworkImage(video.videos[0].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10),
                                child: SizedBox(
                                  width: screenWidth * 0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        video.playlistName ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: screenWidth * 0.04,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                      ),

                                      Row(
                                        children: [

                                          Icon(Icons.playlist_add_check,size: screenWidth * 0.05,color: Colors.grey,),

                                          Text("${video.videos.length} Videos",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenWidth * 0.03,
                                              color: Colors.grey
                                            ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: Colors.orange,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenWidth * 0.02),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Play Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                              SizedBox(width: screenWidth * 0.04,),
                                              ImageIcon(AssetImage("assets/image/music.png"),size: 20,color: Colors.white,)
                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No data available'),
                ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: CustomColors.clrwhite,
          title: const Text('No Playlist Found'),
          content: const Text('There is no playlist available.'),
          actions: [
            ElevatedButton(
              child: const Text(
                'Go Back',
                style: TextStyle(color: CustomColors.clrblack),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
