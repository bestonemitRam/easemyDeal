import 'package:easemydeal/core/constant/apiConstant.dart';
import 'package:easemydeal/data/model/stroy_model.dart';
import 'package:easemydeal/network/service.dart';
import 'package:flutter/material.dart';

class StoryProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectUser(int index) {
   
    _selectedIndex = index;
    notifyListeners(); 
  }

  StoryModel storyModel = StoryModel();

  List<StoryData> allDatalist = [];
  List<StoryData> get storyDataList => allDatalist;

  bool datanotfound = false;

  Future getMyUserStory() async {
    var url = APIURL.user_story;

    ServiceWithHeader service = ServiceWithHeader(url);
    final response = await service.data();
    storyModel = StoryModel.fromJson(response);

    if (storyModel.data != null) {
      if (storyModel.data != null) {
        if (storyModel.data!.isNotEmpty) {
          for (int i = 0; i < storyModel.data!.length; i++) {
            allDatalist.add(storyModel.data![i]);
          }
        }
      }
    }
    datanotfound = true;
    notifyListeners();
    return;
  }
}
