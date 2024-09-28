import 'package:cached_network_image/cached_network_image.dart';
import 'package:easemydeal/core/utils_lib/check_internet_connectvity.dart';
import 'package:easemydeal/data/model/stroy_model.dart';
import 'package:easemydeal/logic/story_provider.dart';
import 'package:easemydeal/presentation/screens/content_screen.dart';
import 'package:easemydeal/presentation/screens/image_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // Add this package in pubspec.yaml

import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // For caching videos

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StoryProvider _myTaskProvider = StoryProvider();
  ScrollController _scrollController = ScrollController();
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    _myTaskProvider = Provider.of<StoryProvider>(context, listen: false);
    _myTaskProvider.getMyUserStory();
    _pageController =
        PageController(initialPage: _myTaskProvider.selectedIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
   
    super.dispose();
  }

  void _scrollToSelectedIndex(int index) {
    double offset = index * 80.0;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _jumpToPage(int index) {
    _pageController.jumpToPage(index);
  }


  @override
  Widget build(BuildContext context) {
    return Provider.of<InternetConnectionStatus>(context) ==
            InternetConnectionStatus.disconnected
        ? InternetNotAvailable()
        : Consumer<StoryProvider>(builder: (context, provider, child) {
            if (provider.storyDataList.isNotEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Container(
                      height: 100,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.storyDataList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                               
                                provider.selectUser(index);
                                _scrollToSelectedIndex(
                                    index);
                                _jumpToPage(index);
                              },
                              child:
                                  _buildStory(provider.storyDataList[index]));
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController, 
                        itemCount: provider.storyDataList.length,
                        onPageChanged: (index) {
                        
                          provider.selectUser(index);
                          _scrollToSelectedIndex(
                              index); 
                        },
                        itemBuilder: (context, index) {
                          final data = provider.storyDataList[index];
                          return PageView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data.stories!.length,
                            itemBuilder: (context, storyIndex) {
                              final story = data.stories![storyIndex];
                              return _buildStoryView(story, data);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              if (!provider.datanotfound) {
                return const SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: Colors.white,
                )));
              } else {
                return Scaffold(
                  body: Center(
                    child: Container(
                      color: Colors.red,
                      child: const Text(
                        "Sorry! Don't have a story",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                );
              }
            }
          });
  }

  Widget _buildStory(StoryData storyData) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage:
              CachedNetworkImageProvider(storyData.profilePicture.toString()),
        ),
        SizedBox(height: 5),
        Text(
          storyData.userName.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildStoryView(Stories story, StoryData data) {
    return Stack(
      children: [
      
        Positioned.fill(
          child: 
          story.mediaType == "image"
              ?ImageScreen(
                  story: story, data: data)
               
              :
               ContentScreen(
                  story: story, data: data),
        ),
       
      ],
    );
  }

}
