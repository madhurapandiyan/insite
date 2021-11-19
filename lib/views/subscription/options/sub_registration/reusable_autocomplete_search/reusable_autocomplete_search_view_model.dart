// import 'package:flutter/material.dart';
// import 'package:insite/core/base/insite_view_model.dart';
// import 'package:insite/core/locator.dart';
// import 'package:insite/core/models/subscription_dashboard_details.dart';
// import 'package:insite/core/services/subscription_service.dart';
// import 'package:insite/utils/enums.dart';
// import 'package:logger/logger.dart';
// import 'package:stacked/stacked.dart';
// import 'package:insite/core/logger.dart';

// class ReusableAutocompleteSearchViewModel extends InsiteViewModel {
//   Logger log;
//   var _subscriptionService = locator<SubScriptionService>();

//   String _filter;
//   String get filter => _filter;

//   PLANTSUBSCRIPTIONFILTERTYPE _filterType;
//   PLANTSUBSCRIPTIONFILTERTYPE get filterType => _filterType;
//   TextEditingController autocustomTextFieldController;

//   bool _loading = true;
//   bool get loading => _loading;

//   bool _loadingMore = false;
//   bool get loadingMore => _loadingMore;

//   bool _shouldLoadmore = true;
//   bool get shouldLoadmore => _shouldLoadmore;

//   bool _refreshing = false;
//   bool get refreshing => _refreshing;

//   int pageNumber = 1;
//   int pageSize = 100;

//   List<DetailResult> _devices = [];
//   List<DetailResult> get devices => _devices;

//   List<String> _gpsDeviceId = [];
//   List<String> get gpsDeviceId => _gpsDeviceId;

//   ReusableAutocompleteSearchViewModel(
//       String filterKey, PLANTSUBSCRIPTIONFILTERTYPE type) {
//     this.log = getLogger(this.runtimeType.toString());
//     this._filter = filterKey;
//     this._filterType = type;
//     autocustomTextFieldController = TextEditingController();

//     Future.delayed(Duration(seconds: 1), () {
//       getSubcriptionDeviceListData();
//     });
//   }

//   getSubcriptionDeviceListData() async {
//     SubscriptionDashboardDetailResult result =
//         await _subscriptionService.getSubscriptionDevicesListData(
//             filterType: filterType,
//             fitler: filter,
//             start: pageNumber,
//             limit: pageSize);

//     if (result != null) {
//       if (result.result.isNotEmpty) {
//         devices.addAll(result.result[1]);
//         _loading = false;
//         _loadingMore = false;

//         devices.forEach((element) {
//           gpsDeviceId.add(element.GPSDeviceID);
//         });

//         notifyListeners();
//       } else {
//         _loading = false;
//         _loadingMore = false;
//         _shouldLoadmore = false;
//         notifyListeners();
//       }
//       _loading = false;
//       _loadingMore = false;
//       notifyListeners();
//     }
//   }
// }
