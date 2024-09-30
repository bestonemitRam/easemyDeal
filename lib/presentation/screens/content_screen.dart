import 'package:easemydeal/data/model/stroy_model.dart';
import 'package:easemydeal/presentation/screens/home_sceen.dart';
import 'package:easemydeal/presentation/screens/video_description.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ContentScreen extends StatefulWidget {

  final Stories? story;
  final StoryData? data;

  const ContentScreen({Key? key, this.story, this.data}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isAudioOn = true;
  bool _isVideoInitialized = false;

  bool _isShow = true;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    final fileInfo = await DefaultCacheManager().getFileFromCache(widget.story!.mediaUrl!);
    File videoFile;

    if (fileInfo != null && fileInfo.file != null) {
      videoFile = fileInfo.file;
    } else {
      videoFile = await DefaultCacheManager().getSingleFile(widget.story!.mediaUrl!);
    }

    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoPlayerController.play();
        _videoPlayerController.setVolume(1.0);
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _toggleAudio() {
    setState(() {
      _isShow = !_isShow;
      _isAudioOn = !_isAudioOn;
      if (_isAudioOn) {
        _videoPlayerController.setVolume(1.0);
      } else {
        _videoPlayerController.setVolume(0.0);
      }
    });
  }

  void _pauseVideo() {
    setState(() {
      _videoPlayerController.pause();
    });
  }

  void _resumeVideo() {
    setState(() {
      _videoPlayerController.play();
    });
  }

  Widget _buildVideoPlayer() {
    if (_isVideoInitialized) {
      return GestureDetector(
        onTap: _toggleAudio,
        onLongPress: _pauseVideo,
        onLongPressUp: _resumeVideo, // Resume video on long press release
        child: VideoPlayer(_videoPlayerController),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [

      
        _buildVideoPlayer(),
        if (!_isShow)
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            child: InkWell(
              onTap: _toggleAudio,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    _isAudioOn ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ),
        OptionsScreen(widget.story!, widget.data),
      ],
    );
  }
}
