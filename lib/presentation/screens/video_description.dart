import 'package:easemydeal/data/model/stroy_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; 

import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; 

class OptionsScreen extends StatelessWidget {
  final Stories? stories;
  final StoryData? data;

  OptionsScreen(this.stories, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 110),
                  Row(children: [
                    CircleAvatar(
                      child:  Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          padding: EdgeInsets.all(1),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    data!.profilePicture.toString(),
                                    fit: BoxFit.fill)),
                          )),
                      radius: 16,
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        '${data!.userName},',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      '${stories!.text!}',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      stories!.textDescription!,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
