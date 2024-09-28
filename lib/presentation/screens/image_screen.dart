import 'package:cached_network_image/cached_network_image.dart';
import 'package:easemydeal/data/model/stroy_model.dart';
import 'package:easemydeal/presentation/screens/video_description.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final Stories? story;
  final StoryData? data;

  const ImageScreen({Key? key, this.story, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: story!.mediaUrl!,
          fit: BoxFit.cover,
        ),
        OptionsScreen(story!, data),
      ],
    );
  }
}
