import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/filter_notification.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart' as notification;
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationViewModel extends InsiteViewModel {
  Logger? log;
 NotificationService? _notificationService = locator<NotificationService>();
  NotificationService? _mainNotificationService =
      locator<NotificationService>();
  NavigationService? _navigationService = locator<NavigationService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();
  FleetService? _fleetService = locator<FleetService>();
  LocalService? _localService = locator<LocalService>();

  int? _totalCount = 0;
  int get totalCount => _totalCount!;

  int? _totalFleetCount = 0;
  int get totalFleetCount => _totalFleetCount!;

  // List<notification.Notification> _assets = [];
  // List<notification.Notification> get assets => _assets;
  List<NotificationRow> _assets = [];
  List<NotificationRow> get assets => _assets;

  Users? _user;
  Users? get userData => _user;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String _serialNo = "";
  String get serialNo => _serialNo;

  bool _showMenu = false;
  bool get showMenu => _showMenu;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showDelete = false;
  bool get showDelete => _showDelete;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;
 
 bool isNotificationResolved=false;
  bool _isDateRangeSelected = false;
  bool get isDateRangeSelected => _isDateRangeSelected;
  set isDateRangeSelected(bool value) {
    this._isDateRangeSelected = value;
  }

  int pageNumber = 1;
  int pageCount = 50;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  ScrollController? scrollController;

  bool _loading = true;
  bool get loading => _loading;

  bool isStatusFilterSelected=false;
  List<String>? filterValue = [];
  String? productFamilyFilterData;

  NotificationViewModel({String? value, String? filterData}) {
    //Logger().e(filterData);
    productFamilyFilterData = filterData;
    this.log = getLogger(this.runtimeType.toString());
    if (value != null && value.isNotEmpty) {
      filterValue!.add(value);
    }
    _mainNotificationService!.setUp();
    setUp();

    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (assets.length != totalCount) {
          _loadMore();
        }
      }
    });
    Future.delayed(Duration(seconds: 1), () async {
      await getNotificationData(true);
    });
  }
  onItemDeselect() {
    try {
      for (int i = 0; i < _assets.length; i++) {
        _assets[i].isSelected = false;
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }


 onResolveSelected(context, index)async{
   _refreshing = true;
      _shouldLoadmore = true;
      notifyListeners();
 List item=[];
 
 var  notificationSelected =
          _assets.where((element) => element.isSelected).toList();
          Logger().wtf("NotificationSelected:$notificationSelected");
   
     item=   notificationSelected.map((e) => e.selectednotifications?.notificationUID).toList();
      Logger().wtf("item:$item");
 
//  _assets.forEach((element) {
// if(element.isSelected){
//   item.add(element.selectednotifications?.notificationUID);
// }
//     });
   var result =
            await _mainNotificationService!.getNotificationStatusData(payLoad:{
  "notificationUID":item
} );



if(result?.status=="SUCCESS"){
 onResolveClicked(context, index,true);
  
_refreshing=false;
  
}else{
  onResolveClicked(context, index,false);
  _refreshing=false;
}

 }

onResolveClicked(BuildContext context, int? index, bool isResolved) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child:InsiteInfoDialog(
              title: "Notification Status",
              message: isResolved? "Notifications are Resolved Successfully":"Notifications are UnResolved",
              onOkClicked:(){
                _assets.clear();
                if(isDateRangeSelected){
               getNotificationData(false);
               _showEdit=false;
                notifyListeners();
                }else{
                  getNotificationData(true);
                  _showEdit=false;
                notifyListeners();
                }
                   
                 Navigator.pop(context, true);
              } ,
            )
           
             );
      },
      
    );
   
  }

  refresh() async {
    try {
      await getSelectedFilterData();
      await getDateRangeFilterData();
      pageNumber = 1;
    //  pageCount = 50;
      _refreshing = true;
      _shouldLoadmore = true;
      notifyListeners();
      Logger().wtf("start date " + startDate!);
      Logger().wtf("end date " + endDate!);
  
     List<int>? notificationStatus=[1];
      //await getNotificationData();
     
      var notificationFilter=appliedFilters!.where((element) => element!.type==FilterType.NOTIFICATION_TYPE||element.type==FilterType.NOTIFICATION_STATUS);
      
      var data=notificationFilter.map((e) {
        if(e!.type==FilterType.NOTIFICATION_STATUS){
       isStatusFilterSelected=true;
       notificationStatus.clear();
       
       if(e.title=="Unresolved"){
        if( isDateRangeSelected)
         notificationStatus.add(1);
       }else{
        if( isDateRangeSelected)
        notificationStatus.add(2);
       }
          
        }else{
        isStatusFilterSelected=false;
         notificationStatus.clear();
         if( isDateRangeSelected)
         isDateRangeSelected?  notificationStatus.add(0): notificationStatus.add(1);
        }
         return e.title;
      }).toList();

  
 //var notificationFilter=appliedFilters!.where((element) => element!.type==FilterType.NOTIFICATION_TYPE||element.type==FilterType.NOTIFICATION_STATUS);
     Logger().wtf("notificationFilters:$notificationFilter");
     
   
      notification.NotificationsData? response =
          await _mainNotificationService!.getNotificationsData(
              "0",
              "0",
              startDate!,
              endDate!,
              _graphqlSchemaService!.seeAllNotification(), {
                          "fromDate":isDateRangeSelected?
                           startDate == null
                        ? ""
                        : Utils().getStartDateTimeInGMTFormatForHealth(startDate.toString(),zone):"",
  "toDate": isDateRangeSelected? endDate == null
                        ? ""
                        : Utils().getEndDateTimeInGMTFormatForNotification(endDate.toString(),zone):"",
  "pageNumber":  pageNumber,
  "notificationType": isStatusFilterSelected?[]:data,
  "notificationStatus":notificationStatus,
  "notificationUserStatus": 0,
  "productFamily":  productFamilyFilterData??""
                        }
);
      if (response != null) {
        _assets.clear();
        if (response.total!.items != null) {
          _totalCount = response.total!.items;
            Logger().wtf("_totalCount:$_totalCount");
        }
        if (response.notifications != null &&
            response.notifications!.isNotEmpty) {
                // _assets.clear();
            // _assets.addAll(response.notifications!);
             for (var selectedItem in response.notifications!) {
            _assets.add(NotificationRow(selectednotifications: selectedItem, isSelected: false));
          
          }
          
        }
       
      _refreshing=false;
      
        notifyListeners();
      } else {
        
        _refreshing=false;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onRemovedSelectedNotification(int index) {
    try {
      _assets.removeAt(index);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onDeleteClicked(BuildContext context, int? index) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Delete User",
              message:
                  "Are you sure you want to permanently remove this notification?",
              onPositiveActionClicked: () {
                Navigator.pop(context, true);
                 _showEdit=false;
                  _assets[index!].isSelected=! _assets[index].isSelected;
                   notifyListeners();
              },
              onNegativeActionClicked: () {
                Navigator.pop(context, false);
                 _showEdit=false;
                 _assets[index!].isSelected=! _assets[index].isSelected;
                 notifyListeners();
              },
            ));
      },
    );
    if (value != null && value) {
      deleteSelectedNotification();
    }
   
  }

  deleteSelectedNotification() async {
    try {
      var result;
      List<String>? ids = [];
      String doubleQuote = "\"";
   var selectedData=  _assets.where((element) => element.isSelected).toList();
 
   if(selectedData.isNotEmpty){
      ids=selectedData.map((e) => e.selectednotifications!.notificationUID!).toList();
       if (ids != null) {
        showLoadingDialog();
        if(enableGraphQl){
         result =await _mainNotificationService!.deleteNotification(payload: {"notificationUID":ids} );
        }else{
          result =
            await _mainNotificationService!.deleteMainNotification(ids);
        }
         
        if (result != null) {
          await deleteNotificationFromList(ids);
          snackbarService!.showSnackbar(message: "Deleted successfully");
        } else {
          snackbarService!.showSnackbar(message: "Deleting failed");
        }

        hideLoadingDialog();
      }
   }
     
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  deleteNotificationFromList(List<String> ids)async {
    Logger().i("deleteReportFromList");
    _assets.clear();
    if(_isDateRangeSelected){
    await  getNotificationData(false);
    }else{
     await getNotificationData(true);
    }
    
    notifyListeners();
  //   ids.forEach((id) {
  //  //   _assets.removeWhere((element) => element.notificationUID == id);
  //   _assets.removeWhere((element) => element.selectednotifications?.notificationUID == id);
  //   });

  //   _totalCount = _totalCount! - ids.length;
  //   notifyListeners();
  //   checkEditAndDeleteVisibility();
  }

  getNotificationData(bool isFirst) async {
    if(!isFirst){
      filterValue!.clear();
    }
    
     List<int>? notificationStatus=[1];
     var notificationFilter=appliedFilters!.where((element) => element!.type==FilterType.NOTIFICATION_TYPE||element.type==FilterType.NOTIFICATION_STATUS);
    
      // var data=notificationFilter.map((e) {
      //   if(e!.type==FilterType.NOTIFICATION_STATUS){
      //  isStatusFilterSelected=true;
      //  notificationStatus.clear();
       
      //  if(e.title=="Unresolved"){
      //    notificationStatus.add(1);
      //  }else{
      //   notificationStatus.add(2);
      //  }
          
      //   }else{
      //   isStatusFilterSelected=false;
      //    notificationStatus.clear();
      //     notificationStatus.add(0);
      //   }
      //    return e.title;
      // }).toList();
 var data=notificationFilter.map((e) {
        if(e!.type==FilterType.NOTIFICATION_STATUS){
       isStatusFilterSelected=true;
       notificationStatus.clear();
       
       if(e.title=="Unresolved"){
        if( isDateRangeSelected)
         notificationStatus.add(1);
       }else{
        if( isDateRangeSelected)
        notificationStatus.add(2);
       }
          
        }else{
        isStatusFilterSelected=false;
         notificationStatus.clear();
         if( isDateRangeSelected)
         isDateRangeSelected?  notificationStatus.add(0): notificationStatus.add(1);
        }
         return e.title;
      }).toList();

    notification.NotificationsData? response =
        await _mainNotificationService!.getNotificationsData(
            "0",
            "0",
            startDate,
            endDate,
            _graphqlSchemaService!.seeAllNotification(
               ), {
                          "fromDate": isFirst
                    ? ""
                    : startDate == null
                        ? ""
                        :  Utils().getStartDateTimeInGMTFormatForHealth(startDate.toString(),zone),
  "toDate":  isFirst
                    ? ""
                    : endDate == null
                        ? ""
                        : Utils().getEndDateTimeInGMTFormatForNotification(endDate.toString(),zone),
  "pageNumber":  pageNumber,
  "notificationType":filterValue!.isNotEmpty?filterValue: isStatusFilterSelected?[]:data,
  "notificationStatus": notificationStatus,
  "notificationUserStatus": 0,
  "productFamily":  productFamilyFilterData
                        });
    if (response != null) {
      if (response.total!.items != null) {
        _totalCount = response.total!.items;
      }
      if (response.notifications != null &&
          response.notifications!.isNotEmpty) {
             for (var selectedItem in response.notifications!) {
            _assets.add(NotificationRow(selectednotifications: selectedItem, isSelected: false));
          }
      //  _assets.addAll(response.notifications!);

        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
         for (var selectedItem in response.notifications!) {
            _assets.add(NotificationRow(selectednotifications: selectedItem, isSelected: false));
          }
      //  _assets.addAll(response.notifications!);
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }
  }

  onItemSelected(index) {
    try {
      _assets[index].isSelected = !_assets[index].isSelected;
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  onDetailPageSelected(notification.NotificationRow? notification) {
    _navigationService!.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
          fleet: Fleet(
             assetSerialNumber: notification!.selectednotifications!.serialNumber,
              // assetSerialNumber: notification!.serialNumber,
              assetId: null,
              // assetIdentifier: notification.assetUID
               assetIdentifier: notification.selectednotifications!.assetUID
              ),
          index: 0,
        ));
  }

  checkEditAndDeleteVisibility() {
    try {
      var count = 0;

      for (int i = 0; i < _assets.length; i++) {
        var data = _assets[i];
        if (data.isSelected!) {
          count++;
        }
      }

      if (count > 0) {
        if (count > 1) {
          _showMenu = true;
          _showDeSelect = true;
          _showEdit = true;
        } else {
          _showMenu = true;
          _showDeSelect = true;
          _showEdit = true;
        }
      } else {
        _showEdit = false;
        _showEdit = false;
        _showDeSelect = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  _loadMore() {
    if (_shouldLoadmore && !_loadingMore) {
      pageNumber++;
      _loadingMore = true;

      notifyListeners();
      // await getSelectedFilterData();
      // await getDateRangeFilterData();
      if (_isDateRangeSelected) {
        getNotificationData(false);
      } else {
        getNotificationData(true);
      }
    }
  }

  onSelectedItemClicK(String value, BuildContext context, int? index) {
    if (value == "deselect") {
      onItemDeselect();
    } else if (value == "Resolve") {
      onResolveSelected(context, index);
     // onItemDeselect();
    } else if (value == "Delete") {
      onDeleteClicked(context, index);
    }
  }
}
