import 'package:flutter/material.dart';
import 'package:pravin_mspl/ui_helper/custom_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../model/playlist_model.dart';
import '../../../utils/api_service.dart';
import '../../example_shorts/video_shorts_service.dart'; // Ensure this service is available

class ShortVideoPlayer extends StatefulWidget {
  ShortVideoPlayer({Key? key, required this.subCategoryId}) : super(key: key);

  final int subCategoryId;
  @override
  ShortVideoPlayerState createState() => ShortVideoPlayerState();
}

class ShortVideoPlayerState extends State<ShortVideoPlayer> {
  List<Video> items = []; // List to hold all videos
  bool _isLoading = true;
  bool _hasData = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await getList(widget.subCategoryId); // Fetch data from API
      setState(() {
        items = data.data.expand((item) => item.videos).toList(); // Flatten the list of videos
        _hasData = items.isNotEmpty;
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

  Future<PlayListModel> getList(int subCategory) async {
    final url = 'https://mahakal.rizrv.in/api/v1/video/video-by-listType?subcategory_id=$subCategory&list_type=shorts';
    var response = await ApiService().getPlayList(url);
    print('API Response: $response'); // Debug print
    return PlayListModel.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: CustomColors.clrblack,backgroundColor: Colors.white,));
    }

    if (!_hasData) {
      return Center(child: Text('No videos available'));
    }

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final video = items[index];
        final isYouTubeUrl = YoutubePlayer.convertUrlToId(video.url) != null;

        return Container(
          height: 800,
          margin: const EdgeInsets.all(2),
          child: isYouTubeUrl
              ? YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(video.url)!,
              flags: YoutubePlayerFlags(autoPlay: true),
            ),
            showVideoProgressIndicator: true,
          )
              : Center(
            child: Text("Unsupported video type"),
          ),
        );
      },
    );
  }
}
