import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/account.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';

import '../../core/services/local_service.dart';

class AccountSearchViewModel extends InsiteViewModel {
  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  LocalStorageService? _localStorageService = locator<LocalStorageService>();
  TextEditingController textEditingController = TextEditingController();
  LocalService? _localService = locator<LocalService>();
  LoginService? _loginService = locator<LoginService>();
  AccountData? selected;
  List<AccountData>? list = [];
  List<AccountData>? displayList = [];
  AccountType? selectionType;

  deSelect() {
    for (var i = 0; i < displayList!.length; i++) {
      displayList![i].isSelected = false;
    }
  }

  ScrollController? scrollController;
  int start = 0;
  int limit = 99;

  AccountSearchViewModel(
      AccountData? accountSelected, List<AccountData>? data, selectionType) {
    selectionType = selectionType;
    selected = accountSelected != null ? accountSelected : null;
    list!.clear();
    list = data;
    Logger().i("total list length ${list!.length}");
    if (selected != null) {
      Logger().i(selected!.value!.Name);
    }
    // textEditingController.addListener(() {
    //   onSearchTextChanged(textEditingController.text);
    // });
    list?.sort((a, b) {
      return a.value!.Name
          .toString()
          .toLowerCase()
          .compareTo(b.value!.Name.toString().toLowerCase());
    });
    selectionType == AccountType.CUSTOMER
        ? list?.insert(
            0,
            AccountData(
                isSelected: false,
                selectionType: AccountType.ACCOUNT,
                value: Customer(
                    CustomerUID: "",
                    Name: "ALL ACCOUNTS",
                    CustomerType: "ALL",
                    DisplayName: "ALL ACCOUNTS",
                    Children: [])))
        : null;
    displayList = list;

    Future.delayed(Duration(seconds: 2), () {
      notifyListeners();
    });
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        limit = limit + 100;
        start = start + 100;
        notifyListeners();
        // loadMoreAccount();
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
  loadMoreAccount() async {
    showLoadingDialog();
    var accountSelected = await _localService!.getAccountInfo();
    List<Customer>? result = await _loginService!.getSubCustomers(
        limit: textEditingController.text.isEmpty ? limit : 100,
        start: textEditingController.text.isEmpty ? start : displayList!.length,
        searchKey: textEditingController.text.isEmpty
            ? ""
            : textEditingController.text,
        customerId: accountSelected?.CustomerUID ?? "",
        isFromPagination: true);
    result?.sort((a, b) {
      return a.Name.toString()
          .toLowerCase()
          .compareTo(b.Name.toString().toLowerCase());
    });
    if (result!.isNotEmpty) {
      result.forEach((element) {
        displayList!.add(AccountData(
            isSelected: false,
            selectionType: AccountType.CUSTOMER,
            value: element));
      });
    }

    notifyListeners();
    hideLoadingDialog();
  }

  onSearchValueEmpty() {
    displayList = list;
    notifyListeners();
  }

  Timer? deBounce;
  onChange() {
    Logger().w(textEditingController.text);
    if (textEditingController.text.length >= 4) {
      if (deBounce?.isActive ?? false) {
        deBounce!.cancel();
      }
      deBounce = Timer(Duration(seconds: 2), () {
        onSearchingTextChanged();
      });
    } else {
      displayList = list;
      notifyListeners();
    }
  }

  onSearchingTextChanged() async {
    try {
      if (textEditingController.text.length >= 4) {
        showLoadingDialog();
        var accountSelected = await _localService!.getAccountInfo();
        Logger().d("getCustomerList");
        List<AccountData> searchList = [];
        List<Customer>? result = await _loginService!.getSubCustomers(
            limit: 100,
            start: 0,
            searchKey: textEditingController.text,
            isFromPagination: textEditingController.text.isEmpty ? false : true,
            customerId: accountSelected!.CustomerUID);
        searchList.clear();
        result?.sort((a, b) {
          return a.Name.toString()
              .toLowerCase()
              .compareTo(b.Name.toString().toLowerCase());
        });
        result!.forEach((element) {
          searchList.add(AccountData(
              isSelected: false,
              selectionType: AccountType.CUSTOMER,
              value: element));
        });
        searchList.insert(
            0,
            AccountData(
                isSelected: false,
                selectionType: AccountType.CUSTOMER,
                value: Customer(
                    CustomerUID: "",
                    Name: "ALL ACCOUNTS",
                    CustomerType: "ALL",
                    DisplayName: "ALL ACCOUNTS",
                    Children: [])));
        displayList = searchList;
        Logger().d("getCustomerList " + displayList!.length.toString());

        notifyListeners();
        hideLoadingDialog();
      } else {
        displayList = list;
        notifyListeners();
        hideLoadingDialog();
      }
    } catch (e) {
      Logger().e(e.toString());
      hideLoadingDialog();
    }
  }

  onSearchTextChanged(String text) async {
    Logger().i("query typeed " + text);
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<AccountData> tempList = [];
        tempList.clear();
        list!.forEach((item) {
          if (item.value!.Name!.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        displayList = tempList;
        Logger().i("total list size " + list!.length.toString());
        Logger().i("searched list size " + displayList!.length.toString());
        notifyListeners();
      } else {
        displayList = list;
        notifyListeners();
      }
    }
  }
}
