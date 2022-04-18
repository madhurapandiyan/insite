import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_view.dart';
import 'package:insite/views/adminstration/asset_settings_configure/model/configure_grid_view_model.dart';
import 'package:logger/logger.dart';

import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AssetSettingsConfigureViewModel extends InsiteViewModel {
  Logger? log;
  TextEditingController textEditingController = TextEditingController();

  bool _isSort = false;
  bool get isSort => _isSort;

  NavigationService? _navigationservice = locator<NavigationService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _assetConfigureAssetUId;
  String? get assetConfigureAssetUid => _assetConfigureAssetUId;

  int? selectedIndex;

  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();

  List<ConfigureGridViewModel> displayList = [];

  AssetSettingsConfigureViewModel(String? assetUid) {
    _assetConfigureAssetUId = assetUid;
    if (isVisionLink) {
      displayList = staticTranspotDataVl;
    } else {
      getDisplayList();
    }
    this.log = getLogger(this.runtimeType.toString());
    // textEditingController.addListener(() {
    //   onSearchTextChanged(textEditingController.text);
    // });
  }
  // var items = ["Select", "Asset Icon", "Asset ID", "CO2 Emissions", "Meters"];
  var items = [
    "Select",
    "Asset Icon",
  ];

  getDisplayList() {
    List<ConfigureGridViewModel> staticTranspotData = [
      ConfigureGridViewModel(
          image: "assets/images/10001.png",
          modelName: "01-all-1",
          assetIconKey: 10001),
      ConfigureGridViewModel(
          image: "assets/images/10002.png",
          modelName: "01-all-1",
          assetIconKey: 10002),
    ];
    displayList = staticTranspotData;
    notifyListeners();
  }

  List<ConfigureGridViewModel> staticTranspotDataVl = [
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "01-all-1"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "02-all-2"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "04-dragline-21-35-cy"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "05-compactor-cat-816"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "06-scraper-cat-623"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "07-blade-dozer"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "08-ripper"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "10-crane-barge-"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "11-crane-rt-20t"),
    ConfigureGridViewModel(image: "assets/images/EX70.png", modelName: "1190"),
    ConfigureGridViewModel(image: "assets/images/EX70.png", modelName: "1190D"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Watertruck"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Dozer"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Dozer"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "wheel dozer"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Excavator"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Excavator"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Loader"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Loader"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Loader"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Tractor Scraper"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Tractor Scraper"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Tractor Scrapers"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Tractor Scraper"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Tractor Scraper"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "Wheel Tractor Scraper"),
    ConfigureGridViewModel(
        image: "assets/images/EX70.png", modelName: "WL-9020"),
  ];
  getSortData() {
    _isSort = !isSort;
    notifyListeners();
  }

  void onSearchTextChanged(String text) {
    if (isVisionLink) {
      Logger().i("query typeed " + text);
      if (text.trim().isNotEmpty) {
        List<ConfigureGridViewModel> tempList = [];

        staticTranspotDataVl.forEach((item) {
          if (item.modelName!.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        displayList = tempList;
        Logger().i("total list size " + staticTranspotDataVl.length.toString());

        notifyListeners();
      } else {
        displayList = staticTranspotDataVl;
        Logger().i("else");

        notifyListeners();
      }
    } else {}
  }

  void buttontap(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  getAssetIconData() async {
    _isLoading = true;
    var iconKey = displayList[selectedIndex!].assetIconKey;
    notifyListeners();
    var data =
        await _manageUserService!.getAssetListData(assetConfigureAssetUid!);
    var result = await _manageUserService!.getAssetIconData(
        DateTime.now().toIso8601String(),
        assetConfigureAssetUid,
        iconKey,
        data!.assetListSettings!.first.legacyAssetID!,
        data.assetListSettings!.first.modelYear,
        data.assetListSettings!.first);
    Logger().i(result.toString());
    _isLoading = false;
    notifyListeners();
    //  gotoAssetingSettingsPage();
  }

  gotoAssetingSettingsPage() {
    _navigationservice!.clearTillFirstAndShowView(AssetSettingsView());
  }
}
