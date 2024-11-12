// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/model/videotype_model.dart';
// import 'package:pravin_mspl/ui_helper/custom_colors.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/live_videos/live_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/playlist_videos/playlist_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/shorts_videos/shorts_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/all_videos/all_videos.dart';
// import '../../utils/api_service.dart';
// import '../myshots.dart';
//
// class TabsScreen extends StatefulWidget {
//   const TabsScreen({super.key,required this.categoryName,required this.subCategoryId});
//
//   final String categoryName;
//   final int subCategoryId;
//
//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }
//
// class _TabsScreenState extends State<TabsScreen> {
//
//   var videoTypes = <VideolistType>[];
//
//
//   @override
//   void initState() {
//     super.initState();
//     getTabsData().then((_) {
//     });
//   }
//
//   Future<void> refresh() async {
//     await getTabsData();
//     setState(() {
//      // _categoryFuture = getCategoryData();
//     });
//   }
//
//   Future<void> getTabsData() async {
//     final res = await ApiService().getVideoTabs('https://mahakal.rizrv.in/api/v1/video/video-list-type');
//
//     if (res != null) {
//       List cdata = res['videolistType'];
//       videoTypes = cdata.map((e) => VideolistType.fromJson(e)).toList();
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var screenWidth = MediaQuery.of(context).size.width;
//
//     List<VideolistType> filteredTabs = videoTypes.where((cat) => cat.status != 0).toList();
//
//     return FutureBuilder(
//       future: getTabsData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return DefaultTabController(
//                 //length: videoTypes.length,
//                  length: filteredTabs.length,
//                 child: Scaffold(
//                   backgroundColor: CustomColors.clrwhite,
//
//                   appBar: AppBar(
//                     title: Text(widget.categoryName,style: TextStyle(fontSize: screenWidth * 0.06,color: CustomColors.clrorange),),
//                     centerTitle: true,
//                     leading: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       }
//                     ,child: Icon(Icons.arrow_back,color: CustomColors.clrblack,size: screenWidth * 0.07)),
//
//                     actions: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//                         child: Icon(Icons.search,size: screenWidth * 0.07,color: CustomColors.clrblack,),
//                       )
//                     ],
//
//                     bottom: TabBar(
//                       labelStyle: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrblack,),
//                         dividerColor: Colors.transparent,
//                         indicatorColor: CustomColors.clrorange,
//                         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                         indicatorSize: TabBarIndicatorSize.tab,
//                         unselectedLabelColor: Colors.grey,
//                         labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
//                         tabAlignment: TabAlignment.start,
//                         isScrollable: true,
//
//                       tabs: List.generate(videoTypes.length, (int index)=> Tab(text: videoTypes[index].name ,)),
//
//                     ),
//                   ),
//                     body: TabBarView(children: <Widget>[
//
//                       //PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,),
//                       ShortsVideos(subCategoryIdd: widget.subCategoryId,categoryNamee: widget.categoryName,),
//                       LiveVideos(subCategoryIdd: widget.subCategoryId,categoryNamee: widget.categoryName,),
//                       AllVideos(subcategoryId: widget.subCategoryId, categoryName: widget.categoryName,)
//
//                    ]),
//
//               ));
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
//
//
//



//
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/model/videotype_model.dart';
// import 'package:pravin_mspl/ui_helper/custom_colors.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/live_videos/live_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/playlist_videos/playlist_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/shorts_videos/shorts_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/all_videos/all_videos.dart';
// import '../../utils/api_service.dart';
// import '../myshots.dart';
//
// class TabsScreen extends StatefulWidget {
//   const TabsScreen({super.key, required this.categoryName, required this.subCategoryId});
//
//   final String categoryName;
//   final int subCategoryId;
//
//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }
//
// class _TabsScreenState extends State<TabsScreen> {
//   var videoTypes = <VideolistType>[];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     getTabsData();
//   }
//
//   Future<void> refresh() async {
//     await getTabsData();
//   }
//
//   Future<void> getTabsData() async {
//     final res = await ApiService().getVideoTabs('https://mahakal.rizrv.in/api/v1/video/video-list-type');
//     if (res != null) {
//       List cdata = res['videolistType'];
//       setState(() {
//         videoTypes = cdata.map((e) => VideolistType.fromJson(e)).toList();
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//
//     List<VideolistType> filteredTabs = videoTypes.where((cat) => cat.status != 0).toList();
//
//
//     bool isTabIdAvailable = filteredTabs.length > 1 && filteredTabs[2].id != null;
//
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return DefaultTabController(
//       length: filteredTabs.length,
//       child: Scaffold(
//         backgroundColor: CustomColors.clrwhite,
//         appBar: AppBar(
//           title: Text(
//             widget.categoryName,
//             style: TextStyle(fontSize: screenWidth * 0.06, color: CustomColors.clrorange),
//           ),
//           centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back, color: CustomColors.clrblack, size: screenWidth * 0.07),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//               child: Icon(Icons.search, size: screenWidth * 0.07, color: CustomColors.clrblack),
//             )
//           ],
//           bottom: TabBar(
//             labelStyle: TextStyle(fontSize: screenWidth * 0.05, color: CustomColors.clrblack),
//             dividerColor: Colors.transparent,
//             indicatorColor: CustomColors.clrorange,
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//             indicatorSize: TabBarIndicatorSize.tab,
//             unselectedLabelColor: Colors.grey,
//             labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
//             tabAlignment: TabAlignment.start,
//             isScrollable: true,
//             tabs: List.generate(filteredTabs.length, (int index) => Tab(text: filteredTabs[index].name)),
//           ),
//         ),
//         body: RefreshIndicator(
//         onRefresh: refresh,
//         child: TabBarView(
//
//            children: filteredTabs.map((tab,) {
//              return PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName, myTabIndex: filteredTabs[2].id);
//           //   return isTabIdAvailable ? ShortsVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,)
//           //       : PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,myTabIndex: filteredTabs[0].id,);
//           }).toList(),
//         ),
//        )
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:pravin_mspl/model/videotype_model.dart';
// import 'package:pravin_mspl/ui_helper/custom_colors.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/playlist_videos/playlist_videos.dart';
// import 'package:pravin_mspl/view/tabsscreenviews/shorts_videos/shorts_videos.dart';
// import '../../model/newtabs_model.dart';
// import '../../utils/api_service.dart';
//
// class TabsScreen extends StatefulWidget {
//   const TabsScreen({super.key, required this.categoryName, required this.subCategoryId});
//
//   final String categoryName;
//   final int subCategoryId;
//
//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }
//
// class _TabsScreenState extends State<TabsScreen> {
//   var videoTypes = <VideolistType>[];
//   bool _isLoading = true;
//
//   DynamicTabs? dynamicTabs;
//   //List<Datum> filteredTabs = [];
//
//
//   @override
//   void initState() {
//     super.initState();
//    // getTabsData();
//     getTabs();
//   }
//
//   Future<void> refresh() async {
//    // await getTabsData();
//     await getTabs();
//     setState(() {
//      // getTabsData();
//       getTabs();
//     });
//   }
//
//
//   //
//   // Future<void> getTabsData() async {
//   //   final res = await ApiService().getVideoTabs('https://mahakal.rizrv.in/api/v1/video/video-list-type');
//   //   if (res != null) {
//   //     List cdata = res['videolistType'];
//   //     setState(() {
//   //       videoTypes = cdata.map((e) => VideolistType.fromJson(e)).toList();
//   //       _isLoading = false;
//   //     });
//   //   }
//   // }
//
//   Future<void> getTabs() async {
//     try {
//       final jsonData = await ApiService().getTabs("https://mahakal.rizrv.in/api/v1/astro?subcategory_id=${widget.subCategoryId}&list_type=live");
//
//         setState(() {
//           dynamicTabs = DynamicTabs.fromJson(jsonData);
//         print(dynamicTabs?.data.length);
//
//       });
//     } catch (e) {
//       print("Error fetching tabs: $e");
//     }
//   }
//
//
//   List<Datum> filteredTabs = dynamicTabs!.availableListTypes
//       .where((datum) => datum.status == 1).cast<Datum>()
//       .toList();
//
//
//   final List<Widget> tabs = [
//
//     Tab(text: "All",),
//
//     ...filteredTabs
//         .map(
//           (cat) => Tab(cat.)
//     ),
//
//
//   ];
//
//   @override
//   Widget build(BuildContext context)  {
//     var screenWidth = MediaQuery.of(context).size.width;
//
//     List<VideolistType> filteredTabs = videoTypes.where((cat) => cat.status != 0).toList();
//
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return DefaultTabController(
//       length: filteredTabs.length,
//       child: Scaffold(
//         backgroundColor: CustomColors.clrwhite,
//         appBar: AppBar(
//           title: Text(
//             widget.categoryName,
//             style: TextStyle(fontSize: screenWidth * 0.06, color: CustomColors.clrorange),
//           ),
//           centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back, color: CustomColors.clrblack, size: screenWidth * 0.07),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//               child: Icon(Icons.search, size: screenWidth * 0.07, color: CustomColors.clrblack),
//             )
//           ],
//           bottom: TabBar(
//             labelStyle: TextStyle(fontSize: screenWidth * 0.05, color: CustomColors.clrblack),
//             dividerColor: Colors.transparent,
//             indicatorColor: CustomColors.clrorange,
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//             indicatorSize: TabBarIndicatorSize.tab,
//             unselectedLabelColor: Colors.grey,
//             labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
//             tabAlignment: TabAlignment.start,
//             isScrollable: true,
//             tabs: tabs
//
//             // List.generate(filteredTabs.length, (int index) => Tab(text: filteredTabs[index].name)),
//
//
//
//           ),
//         ),
//
//         // body: RefreshIndicator(
//         //   onRefresh: refresh,
//         //   child: TabBarView(
//         //     children: filteredTabs.map((tab) {
//         //       if (tab.name.toLowerCase() == 'shorts') {
//         //         return ShortsVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName);
//         //       } else {
//         //         return PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,);
//         //       }
//         //     }).toList(),
//         //   ),
//         // ),
//
//
//         body: TabBarView(children: [
//
//           Center(child: Text("Hello Pravin"))
//         ])
//
//         // TabBarView(
//         //  children: filteredTabs.map((tab) {
//         //  return RefreshIndicator(
//         //  onRefresh: refresh,
//         //  color: CustomColors.clrblack,
//         //  backgroundColor: CustomColors.clrwhite,
//         //
//         //  child: tab.name.toLowerCase() == 'playlist'
//         //   ? PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,tabType: 'playlist',)
//         //      : tab.name.toLowerCase() == 'shorts'
//         //   ? ShortsVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,videoType: 'shorts',)
//         //      : tab.name.toLowerCase() == 'live'
//         //   ? PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,tabType: 'live')
//         //      : PlaylistVideos(subCategoryIdd: widget.subCategoryId, categoryNamee: widget.categoryName,tabType:''),
//         //     );
//         //
//         //   }).toList(),
//         // ),
//
//        ),
//      );
//    }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pravin_mspl/ui_helper/custom_colors.dart';
import 'package:pravin_mspl/view/tabsscreenviews/all_videos/all_videos.dart';
import 'package:pravin_mspl/view/tabsscreenviews/playlist_videos/playlist_videos.dart';
import '../../model/newtabs_model.dart';
import '../../utils/api_service.dart';
import 'shorts_videos/shorts_video_player.dart';

class TabsScreen extends StatefulWidget {

   TabsScreen({super.key, required this.categoryName, required this.subCategoryId,});

  final String categoryName;
  final int subCategoryId;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  DynamicTabs? dynamicTabs;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getTabs();
  }

  Future<void> refresh() async {
    await getTabs();
  }

  Future<void> getTabs() async {

    setState(() {
      _isLoading = true;
    });
    try {
      final jsonData = await ApiService().getTabs(
          "https://mahakal.rizrv.in/api/v1/video/video-by-listType?subcategory_id=${widget.subCategoryId}"
      );

      print(jsonData);

      setState(() {
        dynamicTabs = DynamicTabs.fromJson(jsonData);
        _isLoading = false;

        print(dynamicTabs!.data.length);
        print(dynamicTabs!.availableListTypes.length);

      });
    } catch (e) {
      print("Error fetching tabs: $e");
      setState(() {
        _isLoading = false;
      });
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    List<Widget> tabs = [

      Tab(text: "All"),
      // Generate tabs based on the available list types

      if (dynamicTabs != null) ...[
        ...List.generate(
          dynamicTabs!.availableListTypes.length,
              (index) {
            final datum = dynamicTabs!.availableListTypes[index];
            return Tab(
              text: (datum != null && datum.isNotEmpty) ? datum : 'Default Tab', // Fallback for null or empty
            );
          },
        ),
      ]
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: CustomColors.clrwhite,
        appBar: AppBar(
          title: Text(
            widget.categoryName,
            style: TextStyle(fontSize: screenWidth * 0.06, color: CustomColors.clrorange),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: CustomColors.clrblack, size: screenWidth * 0.07),
          ),

          bottom: TabBar(
            labelStyle: TextStyle(fontSize: screenWidth * 0.05, color: CustomColors.clrblack),
            dividerColor: Colors.transparent,
            indicatorColor: CustomColors.clrorange,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body:
            _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) :

            RefreshIndicator(
          onRefresh: refresh,
          color: CustomColors.clrblack,
          backgroundColor: CustomColors.clrwhite,
          child:
          TabBarView(
            children: [

              AllVideos(subcategoryId: widget.subCategoryId, categoryName: widget.categoryName),

              ...List.generate(
                dynamicTabs?.availableListTypes.length ?? 0,
                    (index) {
                  final datum = dynamicTabs!.availableListTypes[index]?.toLowerCase();

                  if (datum == 'shorts') {
                    return
                      ShortVideoPlayer(subCategoryId: widget.subCategoryId,);
                      //ShortVideoHomePage();

                    //   ShortsScreen(
                    //   subCategoryIdd: widget.subCategoryId,
                    //   categoryNamee: widget.categoryName,
                    //    tabType: 'shorts',
                    // );


                  } else if (datum == 'playlist') {
                    return PlaylistVideos(
                      subCategoryIdd: widget.subCategoryId,
                      categoryNamee: widget.categoryName,
                      tabType: 'playlist',
                    );
                  } else if (datum == 'live') {
                    return PlaylistVideos(
                      subCategoryIdd: widget.subCategoryId,
                      categoryNamee: widget.categoryName,
                      tabType: 'live',
                    );
                  } else {
                    // Handle any other unexpected tab types, or return an empty widget
                    return SizedBox.shrink(); // Or you can return a default widget
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
