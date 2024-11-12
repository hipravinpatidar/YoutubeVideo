// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/utils/api_service.dart';
//
// import 'model/newtabs_model.dart';
//
// class MyfixedTab extends StatefulWidget {
//   const MyfixedTab({super.key, required this.subCategoryIdd, required this.categoryNamee, required this.tabType});
//
//
//   final int subCategoryIdd;
//   final String categoryNamee;
//   final String tabType;
//
//
//   @override
//   State<MyfixedTab> createState() => _MyfixedTabState();
// }
//
// class _MyfixedTabState extends State<MyfixedTab> {
//
//
//   DynamicTabs? dynamicTabs;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     getTabs();
//   }
//
//   Future<void> refresh() async {
//     await getTabs();
//   }
//
//   Future<void> getTabs() async {
//     try {
//       final jsonData = await ApiService().getTabs("https://mahakal.rizrv.in/api/v1/astro?subcategory_id=${widget.subCategoryIdd}&list_type=${widget.tabType}");
//
//       setState(() {
//         dynamicTabs = DynamicTabs.fromJson(jsonData);
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching tabs: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     var screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
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
//         //itemCount: playListModel!.data.length,
//         itemBuilder: (BuildContext ctx, int index) {
//           playlist.Datum video = playListModel!.data[index];
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       YoutubePlayerScreen(playListModel: playListModel!,currentIndex: index,),
//                 ),
//               );
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
//           title: const Text('No Videos Found'),
//           content: const Text('There is no video available.'),
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


import 'package:flutter/material.dart';
import 'package:pravin_mspl/utils/api_service.dart';
import 'package:pravin_mspl/model/newtabs_model.dart' as playlist; // Adjust import based on your project structure
import 'package:pravin_mspl/ui_helper/custom_colors.dart';
import 'package:pravin_mspl/view/youtube_player_screen/youtube_player_screen.dart';

import 'model/newtabs_model.dart';

class MyfixedTab extends StatefulWidget {
  const MyfixedTab({
    super.key,
    required this.subCategoryIdd,
    required this.categoryNamee,
    required this.tabType,
  });

  final int subCategoryIdd;
  final String categoryNamee;
  final String tabType;

  @override
  State<MyfixedTab> createState() => _MyfixedTabState();
}

class _MyfixedTabState extends State<MyfixedTab> {
  DynamicTabs? dynamicTabs;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getTabs();
  }

  Future<void> refresh() async {
    await getTabs();
  }

  Future<void> getTabs() async {
    try {
      final jsonData = await ApiService().getTabs("https://mahakal.rizrv.in/api/v1/astro?subcategory_id=${widget.subCategoryIdd}&list_type=${widget.tabType}");

      setState(() {
        dynamicTabs = DynamicTabs.fromJson(jsonData);
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching tabs: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Ensure dynamicTabs is not null and has data
    if (dynamicTabs == null || dynamicTabs!.data.isEmpty) {
      return Center(
        child: Text("No data available."),
      );
    }

    // Filter videos with status == 1
    List<playlist.Datum> filteredVideos = dynamicTabs!.data.where((video) => video.status == 1).toList();

    if (filteredVideos.isEmpty) {
      return Center(
        child: Text("No videos available."),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.02,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          crossAxisCount: 1,
        ),
        itemCount: filteredVideos.length,
        itemBuilder: (BuildContext ctx, int index) {
          playlist.Datum video = filteredVideos[index];

          return InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => YoutubePlayerScreen(
              //       playListModel: dynamicTabs.data[index].videos,
              //       currentIndex: index,
              //     ),
              //   ),
              // );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
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
                        image: NetworkImage(video.videos[0].image ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: SizedBox(
                      width: screenWidth * 0.4,
                      child: Text(video.videos[index].title,
                       // video.playlistName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
          title: const Text('No Videos Found'),
          content: const Text('There are no videos available.'),
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
