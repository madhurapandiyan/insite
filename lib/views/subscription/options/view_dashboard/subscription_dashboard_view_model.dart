import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/sub_dash_board_details/subscription_dashboard_details_view.dart';
import 'package:insite/views/subscription/sms-management/report_summary/report_summary_view.dart';
import 'package:insite/views/subscription/sms-management/sms-multi_asset/sms_schedule_multi_asset_view.dart';
import 'package:insite/views/subscription/sms-management/sms-single_asset/sms_schedule_single_asset_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:stacked_services/stacked_services.dart';

class SubscriptionDashboardViewModel extends InsiteViewModel {
  Logger? log;
  // var _navigationService = locator<NavigationService>();
  SubScriptionService? _subscriptionService = locator<SubScriptionService>();
  LocalService? _localService = locator<LocalService>();
  NavigationService? _navigationService = locator<NavigationService>();

  SubscriptionDashboardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  setUp();
    _subscriptionService!.setUp();
    _localService!.getToken();
    Future.delayed(Duration(seconds: 2), () {
      getSubscriptionDashboardData();
    });
  }

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  List<double?> _results = [];
  List<double?> get results => _results;

  List<String?> _modelNames = [];
  List<String?> get modelNames => _modelNames;
  List<double?> _modelCount = [];
  List<double?> get modelCount => _modelCount;

  List<String> _names = [
    "Total Devices supplied",
    "Active Subscriptions",
    "Yet to be activated",
    "Suscription Ended",
    "Subscription to be ending this month",
    "Plant Asset Count"
  ];
  List<String> get names => _names;

  List<String> _filters = [
    "total",
    "active",
    "inactive",
    "subscriptionendasset",
    "subscriptionendingasset_month",
    "plantasset"
  ];
  List<String> get filters => _filters;

  getSubscriptionDashboardData() async {
    Logger().i("getApplicationAccessData");
    SubscriptionDashboardResult? result =
        await _subscriptionService!.getResultsFromSubscriptionApi();
    if (result == null) {
      Logger().d('no results found');
      _loading = false;
    } else {
      final totalDeviceSupplied = result.result![3][0].totalDevice;
      final plantAssetCount = result.result![4][0].plantAssetCount;
      final activeSubScription = result.result![0][0].activeList;
      final yetToBeActivated = result.result![1][0].inActiveList;
      final subScriptionEnded = result.result![5][0].subscriptionAndAsset;
      final subScriptionEndingThisMOnth =
          result.result![9][0].subscriptionEndingAsset;

      _results.addAll([
        totalDeviceSupplied,
        activeSubScription,
        yetToBeActivated,
        subScriptionEnded,
        subScriptionEndingThisMOnth,
        plantAssetCount
      ]);
      //model names
      final ex70SuperPlus = result.result![2][9].modelName;
      final ex130SuperPlus = result.result![2][3].modelName;
      final shinRaiBx80 = result.result![2][11].modelName;
      final notMapped = "Not Mapped";
      final twl5 = result.result![2][1].modelName;
      final ex110 = result.result![2][2].modelName;
      final ex200lc = result.result![2][4].modelName;
      final ex200lcsuperplus = result.result![2][5].modelName;
      final ex210lc = result.result![2][6].modelName;
      final ex215 = result.result![2][7].modelName;
      final ex300 = result.result![2][8].modelName;
      final ptl340h = result.result![2][10].modelName;
      final shinraibx80Bviv = result.result![2][12].modelName;
      final shinraipro = result.result![2][13].modelName;
      final th76 = result.result![2][14].modelName;
      final tl340h = result.result![2][15].modelName;
      final th340hPrime = result.result![2][16].modelName;
      _modelNames.addAll([
        ex70SuperPlus,
        ex130SuperPlus,
        shinRaiBx80,
        notMapped,
        twl5,
        ex110,
        ex200lc,
        ex200lcsuperplus,
        ex210lc,
        ex215,
        ex300,
        ptl340h,
        shinraibx80Bviv,
        shinraipro,
        th76,
        tl340h,
        th340hPrime
      ]);
      //model count
      final ex70SuperPlusCount = result.result![2][9].modelCount;
      final ex130SuperPlusCount = result.result![2][3].modelCount;
      final shinRaiBx80Count = result.result![2][11].modelCount;
      final notMappedCount = result.result![2][0].modelCount;
      final twl5Count = result.result![2][1].modelCount;
      final ex110Count = result.result![2][2].modelCount;
      final ex200lcCount = result.result![2][4].modelCount;
      final ex200lcSuperPlusCount = result.result![2][5].modelCount;
      final ex210lcCount = result.result![2][6].modelCount;
      final ex215Count = result.result![2][7].modelCount;
      final ex300Count = result.result![2][8].modelCount;
      final ptl340hCount = result.result![2][10].modelCount;
      final shinraibx80BvivCount = result.result![2][12].modelCount;
      final shinraiproCount = result.result![2][13].modelCount;
      final th76Count = result.result![2][14].modelCount;
      final tl340hCount = result.result![2][15].modelCount;
      final th340hPrimeCount = result.result![2][16].modelCount;

      _modelCount.addAll([
        ex70SuperPlusCount,
        ex130SuperPlusCount,
        shinRaiBx80Count,
        notMappedCount,
        twl5Count,
        ex110Count,
        ex200lcCount,
        ex200lcSuperPlusCount,
        ex210lcCount,
        ex215Count,
        ex300Count,
        ptl340hCount,
        shinraibx80BvivCount,
        shinraiproCount,
        th76Count,
        tl340hCount,
        th340hPrimeCount
      ]);

      _loading = false;
    }

    notifyListeners();
  }

  gotoDetailsPage(String filter) {
    Logger().i("gotoDetailsPage $filter");
    _navigationService!.navigateToView(SubDashBoardDetailsView(
      filterKey: filter,
      detailType: PLANTSUBSCRIPTIONDETAILTYPE.DEVICE,
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.STATUS,
    ));
  }

  gotoModelsPage(String? filter) {
    Logger().i("gotoModelsPage $filter");
    _navigationService!.navigateToView(SubDashBoardDetailsView(
      filterKey: filter,
      detailType: PLANTSUBSCRIPTIONDETAILTYPE.DEVICE,
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.MODEL,
    ));
  }

  gotoCalendarDetailsPage(String filter) {
    Logger().i("gotoCalendarDetailsPage $filter");
    _navigationService!.navigateToView(SubDashBoardDetailsView(
      filterKey: filter,
      detailType: PLANTSUBSCRIPTIONDETAILTYPE.DEVICE,
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.DATE,
    ));
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.SMSSCHEDULEFORSINGLEASSET) {
      _navigationService!.navigateWithTransition(SmsScheduleSingleAssetView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.SMSSCHEDULEFORMUTLIPLEASSET) {
      _navigationService!.navigateWithTransition(SmsScheduleMultiAssetView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.REPORTSUMMARYFORSMS) {
      _navigationService!.navigateWithTransition(ReportSummaryView(),
          transition: "fade");
    }
  }
}
