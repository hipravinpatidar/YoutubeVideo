import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../model/newtabs_model.dart'; // Adjust import as necessary
import '../../../ui_helper/custom_colors.dart';
import '../../../utils/api_service.dart';
import '../shorts_videos/shorts_video_player.dart';

class AllVideos extends StatefulWidget {
  const AllVideos({
    super.key,
    required this.subcategoryId,
    required this.categoryName,
  });

  final String categoryName;
  final int subcategoryId;

  @override
  State<AllVideos> createState() => _AllVideosState();
}

class _AllVideosState extends State<AllVideos> {
  bool _isLoading = false;
  DynamicTabs? dynamicTabs;

  List<Video> allVideos = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }


  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await getList(widget.subcategoryId);
      setState(() {
        dynamicTabs = data;
        _isLoading = false;

        // Extract videos from dynamicTabs and add to allVideos
        allVideos = _extractVideos(dynamicTabs);

        print("All Videos length is ${allVideos.length}");
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  List<Video> _extractVideos(DynamicTabs? dynamicTabs) {
    List<Video> videos = [];

    if (dynamicTabs != null) {
      for (var category in dynamicTabs.data) {
        // Check if playlistName and listType are null at the category level
        if (category.playlistName == null && category.listType == null) {
          for (var video in category.videos) {
            videos.add(Video(
              title: video.title,
              url: video.url,
              image: video.image,
              urlStatus: video.urlStatus, // Assuming urlStatus is a property in the Video class
            ));
          }
        }
      }
    }

    return videos;
  }

  Future<DynamicTabs> getList(int subCategory) async {
    final url =
        'https://mahakal.rizrv.in/api/v1/video/video-by-listType?subcategory_id=$subCategory';

    var response = await ApiService().getPlayList(url);

    print(response);

    return DynamicTabs.fromJson(response);
  }

  // Future<void> _fetchData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final data = await getList(widget.subcategoryId);
  //     setState(() {
  //       dynamicTabs = data;
  //       _isLoading = false;
  //
  //       // Extract videos from dynamicTabs and add to allVideos
  //       allVideos = _extractVideos(dynamicTabs);
  //
  //       print("All Videos length is ${allVideos.length}");
  //
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print('Error fetching data: $e');
  //   }
  // }
  //
  // List<Video> _extractVideos(DynamicTabs? dynamicTabs) {
  //   List<Video> videos = [];
  //
  //   if (dynamicTabs != null) {
  //     for (var category in dynamicTabs.data) {
  //       for (var video in category.videos) {
  //         videos.add(Video(
  //           title: video.title,
  //           url: video.url,
  //           image: video.image, urlStatus: video.urlStatus,
  //         ));
  //       }
  //     }
  //   }
  //
  //   return videos;
  // }
  //
  // Future<DynamicTabs> getList(int subCategory) async {
  //   final url =
  //       'https://mahakal.rizrv.in/api/v1/video/video-by-listType?subcategory_id=$subCategory';
  //
  //   var response = await ApiService().getPlayList(url);
  //
  //   print(response);
  //
  //   return DynamicTabs.fromJson(response);
  // }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: CustomColors.clrwhite,
        body: Center(
          child: CircularProgressIndicator(
            color: CustomColors.clrblack,
            backgroundColor: CustomColors.clrwhite,
          ),
        ),
      );
    }

    final regularVideos = dynamicTabs?.data
        ?.where((datum) =>
    datum.status == 1 && datum.listType?.toLowerCase() != 'shorts')
        .toList();
    final shortsVideos = dynamicTabs?.data
        ?.where((datum) =>
    datum.status == 1 && datum.listType?.toLowerCase() == 'shorts')
        .toList();

    return RefreshIndicator(
      onRefresh: _fetchData,
      color: CustomColors.clrblack,
      backgroundColor: CustomColors.clrwhite,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
        child: dynamicTabs == null || dynamicTabs!.data.isEmpty
            ? _buildEmptyState(screenWidth)
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlaylistAndDirectVideos(regularVideos, screenWidth,allVideos),
              const SizedBox(height: 20),
              _buildShortsVideoSection(shortsVideos, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(double screenWidth) {
    return Scaffold(
      backgroundColor: CustomColors.clrwhite,
      body: Column(
        children: [
          SizedBox(
            height: screenWidth * 0.3,
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 330,
              child: Card(
                shadowColor: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/image/connection.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'O',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'ops!',
                            style: TextStyle(
                                fontSize: 27,
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "No Internet connection found \n Check your connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: screenWidth * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        _fetchData();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red.withOpacity(0.7),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.2,
                              vertical: screenWidth * 0.03),
                          child: Text(
                            "Try Again",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      "Or",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      "Empty Data",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaylistAndDirectVideos(List<Datum>? regularVideos, double screenWidth, List<Video> allVideos) {
    if (regularVideos == null || regularVideos.isEmpty) {
      return Container();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: regularVideos.length,
      itemBuilder: (BuildContext ctx, int index) {
        final datum = regularVideos[index];
        final playlistName = datum.playlistName;

        if (playlistName != null) {
          // Show playlist as a single entry
          return _buildPlaylistTile(datum, screenWidth);
        } else {
          // Show single videos directly
          return _buildDirectVideosList(datum.videos, screenWidth,datum,allVideos);
        }
      },
    );
  }

  Widget _buildPlaylistTile(Datum datum, double screenWidth) {

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayListPlayer(playlist: datum),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: screenWidth * 0.02),
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
                height: screenWidth * 0.26,
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: NetworkImage(datum.videos.first.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5),
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        datum.playlistName ?? '',
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

                          Text("${datum.videos.length} Videos",
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
      ),
    );
  }

  Widget _buildDirectVideosList(List<Video> videos, double screenWidth,Datum datum, List<Video> allVideos) {
    return Column(
      children: videos.map((video) {
        return _buildVideoTile(screenWidth, video,datum,allVideos);
      }).toList(),
    );
  }

  Widget _buildVideoTile(double screenWidth, Video video,Datum datum, List<Video> allVideos) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SingleVideoPlayer(playlist:datum,allVideos: allVideos,),),);
        },
        child:
        Container(
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
                height: screenWidth * 0.26,
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: NetworkImage(video.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5),
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [

                          Text(
                            video.title ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * 0.04,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),

                          SizedBox(height: screenWidth * 0.03,),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }

  Widget _buildShortsVideoSection(List<Datum>? shortsVideos, double screenWidth) {
    if (shortsVideos == null || shortsVideos.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shorts',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

             GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shortsVideos.length.clamp(0, 4), // Limit to 4 shorts
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (BuildContext ctx, int index) {
                    return _buildShortsLayout(screenWidth,shortsVideos[index].videos, index,widget.subcategoryId);
                  },
                ),

      ],
    );
  }

  Widget _buildShortsLayout(double screenWidth,List<Video> video, int myIndex, int subCategoryId) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //   AllShortsPlayer()));
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShortVideoPlayer(subCategoryId: widget.subcategoryId,),));
            //ShortsPlayer(dynamicTabs: dynamicTabs!, currentIndex: myIndex),));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(video[myIndex].image), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: screenWidth * 0.5, left: screenWidth * 0.02),
          child: Stack(
            children: [
              Text(
                video[myIndex].title,
                style: TextStyle(color: CustomColors.clrwhite, fontSize: screenWidth * 0.04),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildShortsLayout(double screenWidth, Video video) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Play shorts video
  //     //  Navigator.push(context, MaterialPageRoute(builder: (context) => ShortsVideoPlayer(videoUrl: video.url),),);
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey.shade600),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             height: screenWidth * 0.45,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey),
  //               borderRadius: BorderRadius.circular(7),
  //               image: DecorationImage(
  //                 image: NetworkImage(video.image ?? ''),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           Text(
  //             video.title ?? '',
  //             style: TextStyle(
  //               fontSize: screenWidth * 0.04,
  //               fontWeight: FontWeight.w600,
  //             ),
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class PlayListPlayer extends StatefulWidget {

  final Datum playlist;

   PlayListPlayer({super.key, required this.playlist,});

  @override
  _PlayListPlayerState createState() => _PlayListPlayerState();
}

class _PlayListPlayerState extends State<PlayListPlayer> {

  late YoutubePlayerController youtubePlayerController;
  late YoutubeMetaData videoMetaData;
  var isPlayerReady = false;

  int _selectedVideoIndex = 0;


  @override
  void initState() {
    videoMetaData = const YoutubeMetaData();

   // final videoId = YoutubePlayer.convertUrlToId(widget.playlist.videos.first.url);

    youtubePlayerController = YoutubePlayerController(
      initialVideoId: getVideoId(widget.playlist.videos[0].url),
      flags: const YoutubePlayerFlags(
        useHybridComposition: true,
        mute: false,
        autoPlay: true,
      ),
    )..addListener(listener);
    super.initState();
  }

  String getVideoId(String url) {
    final RegExp regExp = RegExp(r"[?&]v=([^&#]*)");
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  void listener() {
    if (isPlayerReady && mounted && !youtubePlayerController.value.isFullScreen) {
      setState(() {
        videoMetaData = youtubePlayerController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SafeArea(
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(controller: youtubePlayerController),
          builder: (BuildContext context, Widget wid) {
            return Column(
              children: [
                AppBar(
                    leading: GestureDetector(onTap: () {
                      Navigator.pop(context);
                    },child: Icon(Icons.arrow_back,color: CustomColors.clrblack,size: screenWidth * 0.07,)),
                    automaticallyImplyLeading: false,
                    title: Text(widget.playlist.playlistName ?? 'Playlist',style: TextStyle(fontSize: screenWidth * 0.06,color: CustomColors.clrorange,fontWeight: FontWeight.w500),)),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: YoutubePlayer(
                      //thumbnail: Image.network(widget.dynamicTabs.data[_currentIndex].videos[0].image),
                      controller: youtubePlayerController,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        isPlayerReady = true;
                        print('Player is ready.');
                      },
                    ),
                  ),
                ),

                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(widget.playlist.videos[_selectedVideoIndex].title,style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,)),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3.0,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 1,
                        ),
                        itemCount: widget.playlist.videos.length,
                        itemBuilder: (context,videoIndex ){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                _selectedVideoIndex = videoIndex;
                              });
                              youtubePlayerController.load(getVideoId(widget.playlist.videos[videoIndex].url));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(7),
                                        image: DecorationImage(
                                            image: NetworkImage(widget.playlist.videos[videoIndex].image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
                                      child: Text(widget.playlist.videos[videoIndex].title,style: const TextStyle(fontWeight: FontWeight.w500),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


class SingleVideoPlayer extends StatefulWidget {

  //final List<Video> videos;

  List<Video> allVideos;
  final Datum playlist;

  SingleVideoPlayer({super.key, required this.playlist,required this.allVideos});

  @override
  _SingleVideoPlayerState createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {

  late YoutubePlayerController youtubePlayerController;
  late YoutubeMetaData videoMetaData;
  var isPlayerReady = false;

  int _selectedVideoIndex = 0;


  @override
  void initState() {
    videoMetaData = const YoutubeMetaData();

    youtubePlayerController = YoutubePlayerController(
      initialVideoId: getVideoId(widget.allVideos[0].url),
      flags: const YoutubePlayerFlags(
        useHybridComposition: true,
        mute: false,
        autoPlay: true,
      ),
    )..addListener(listener);
    super.initState();
  }

  String getVideoId(String url) {
    final RegExp regExp = RegExp(r"[?&]v=([^&#]*)");
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  void listener() {
    if (isPlayerReady && mounted && !youtubePlayerController.value.isFullScreen) {
      setState(() {
        videoMetaData = youtubePlayerController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SafeArea(
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(controller: youtubePlayerController),
          builder: (BuildContext context, Widget wid) {
            return Column(
              children: [
                AppBar(
                    leading: GestureDetector(onTap: () {
                      Navigator.pop(context);
                    },child: Icon(Icons.arrow_back,color: CustomColors.clrblack,size: screenWidth * 0.07,)),
                    automaticallyImplyLeading: false,
                    title: Text('Video Player',style: TextStyle(fontSize: screenWidth * 0.06,color: CustomColors.clrorange,fontWeight: FontWeight.w500),)),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: YoutubePlayer(
                      //thumbnail: Image.network(widget.dynamicTabs.data[_currentIndex].videos[0].image),
                      controller: youtubePlayerController,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        isPlayerReady = true;
                        print('Player is ready.');
                      },
                    ),
                  ),
                ),

                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(widget.allVideos[_selectedVideoIndex].title,style: const TextStyle(fontWeight: FontWeight.bold),)),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3.0,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          crossAxisCount: 1,
                        ),
                        itemCount: widget.allVideos.length,
                        itemBuilder: (context,videoIndex ){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                _selectedVideoIndex = videoIndex;
                              });
                              youtubePlayerController.load(getVideoId(widget.allVideos[videoIndex].url));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(7),
                                        image: DecorationImage(
                                            image: NetworkImage(widget.allVideos[videoIndex].image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
                                      child: Text(widget.allVideos[videoIndex].title,style: const TextStyle(fontWeight: FontWeight.w500),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


