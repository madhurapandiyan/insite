import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_device.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:logger/logger.dart';
import '../locator.dart';

class AssetService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;

  AssetService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e("setUp $e");
    }
  }

  Future<AssetSummaryResponse> getAssetSummaryList(
    startDate,
    endDate,
    pageSize,
    pageNumber,
    menuFilterType,
    List<FilterData> appliedFilters,
  ) async {
    try {
      AssetResponse assetResponse =
          accountSelected != null && customerSelected != null
              ? await MyApi().getClient().assetSummaryURL(
                  Urls.assetSummary +
                      FilterUtils.getFilterURL(
                          startDate,
                          endDate,
                          pageNumber,
                          pageSize,
                          customerSelected.CustomerUID,
                          menuFilterType,
                          appliedFilters,
                          ScreenType.ASSET_OPERATION),
                  accountSelected.CustomerUID)
              : await MyApi().getClient().assetSummaryURL(
                  Urls.assetSummary +
                      FilterUtils.getFilterURL(
                          startDate,
                          endDate,
                          pageNumber,
                          pageSize,
                          null,
                          menuFilterType,
                          appliedFilters,
                          ScreenType.ASSET_OPERATION),
                  accountSelected.CustomerUID);
      return assetResponse.assetOperations;
    } catch (e) {
      Logger().e("getAssetSummaryList $e");
      return null;
    }
  }

  Future<AssetDetail> getAssetDetail(assetUID) async {
    try {
      AssetDetail assetResponse = await MyApi()
          .getClient()
          .assetDetail(assetUID, accountSelected.CustomerUID);
      return assetResponse;
    } catch (e) {
      Logger().e("getAssetDetail $e");
      return null;
    }
  }

  Future<List<AssetDevice>> getAssetDevice(assetUID) async {
    try {
      AssetDeviceResponse assetResponse = await MyApi()
          .getClient()
          .asset(assetUID, accountSelected.CustomerUID);
      return assetResponse.Devices;
    } catch (e) {
      Logger().e("getAssetDevice $e");
      return [];
    }
  }

  Future<List<Note>> getAssetNotes(assetUID) async {
    try {
      List<Note> notes = await MyApi()
          .getClient()
          .getAssetNotes(assetUID, accountSelected.CustomerUID);
      return notes;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  postNotes(assetUID, note) async {
    try {
      await MyApi()
          .getClient()
          .postNotes(PostNote(assetUID: assetUID, assetUserNote: note));
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
