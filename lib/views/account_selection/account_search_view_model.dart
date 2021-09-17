import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/account.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:logger/logger.dart';

class AccountSearchViewModel extends InsiteViewModel {
  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  var _localStorageService = locator<LocalStorageService>();
  TextEditingController textEditingController = TextEditingController();
  AccountData selected;
  List<AccountData> list = [];
  List<AccountData> displayList = [];

  deSelect() {
    for (var i = 0; i < displayList.length; i++) {
      displayList[i].isSelected = false;
    }
  }

  ScrollController scrollController;

  AccountSearchViewModel(AccountData accountSelected, List<AccountData> data) {
    selected = accountSelected != null ? accountSelected : null;
    list.clear();
    list = data;
    displayList = list;
    Logger().i("total list length ${list.length}");
    if (selected != null) {
      Logger().i(selected.value.DisplayName);
    }
    textEditingController.addListener(() {
      onSearchTextChanged(textEditingController.text);
    });
    Future.delayed(Duration(seconds: 2), () {
      notifyListeners();
    });
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  _loadMore() {
    Logger().i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      Logger().i("load more called");
      _loadingMore = true;
      notifyListeners();
      getSubcustomersList();
    }
  }

  getSubcustomersList() {
    // if (list.length == totallist.length) {
    //   Future.delayed(Duration(seconds: 1), () {
    //     _loading = false;
    //     _loadingMore = false;
    //     _shouldLoadmore = false;
    //     notifyListeners();
    //   });
    // } else {
    //   Logger().i("pageCount $pageCount");
    //   pageCount += 500;
    //   list = totallist.take(pageCount).toList();
    //   displayList = list;
    //   Future.delayed(Duration(seconds: 2), () {
    //     _loading = false;
    //     _loadingMore = false;
    //     notifyListeners();
    //   });
    // }
  }

  onSearchTextChanged(String text) async {
    Logger().i("query typeed " + text);
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<AccountData> tempList = [];
        tempList.clear();
        list.forEach((item) {
          if (item.value.DisplayName.toLowerCase().contains(text))
            tempList.add(item);
        });
        displayList = tempList;
        Logger().i("total list size " + list.length.toString());
        Logger().i("searched list size " + displayList.length.toString());
        notifyListeners();
      } else {
        displayList = list;
        notifyListeners();
      }
    }
  }
}
