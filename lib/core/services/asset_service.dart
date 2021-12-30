import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_device.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import '../locator.dart';

class AssetService extends BaseService {
  LocalService? _localService = locator<LocalService>();

  Customer? accountSelected;
  Customer? customerSelected;

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e("setUp $e");
    }
  }

  Future<AssetSummaryResponse?> getAssetSummaryList(
      startDate,
      endDate,
      pageSize,
      pageNumber,
      menuFilterType,
      List<FilterData?>? appliedFilters,
      query) async {
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query,
         accountSelected?.CustomerUID,
          (await _localService!.getLoggedInUser())!.sub,
        );

        AssetSummaryResponse assetOperationData = AssetSummaryResponse.fromJson(
            data.data!["assetOperationsDailyTotals"]["assetOperations"]);

        Logger().wtf(assetOperationData.toJson());

        return assetOperationData;
      } else {
        if (isVisionLink) {
          AssetResponse assetResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetSummaryURLVL(
                      Urls.assetSummaryVL +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected!.CustomerUID,
                              menuFilterType,
                              appliedFilters!,
                              ScreenType.ASSET_OPERATION),
                      accountSelected!.CustomerUID)
                  : await MyApi().getClient()!.assetSummaryURLVL(
                        Urls.assetSummaryVL +
                            FilterUtils.getFilterURL(
                                startDate,
                                endDate,
                                pageNumber,
                                pageSize,
                                null,
                                menuFilterType,
                                appliedFilters!,
                                ScreenType.ASSET_OPERATION),
                        accountSelected!.CustomerUID,
                      );
          Logger().wtf(
              'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${assetResponse.assetOperations!.toJson()}');
          return assetResponse.assetOperations;
        } else {
          AssetResponse assetResponse =
              accountSelected != null && customerSelected != null
                  ? await MyApi().getClient()!.assetSummaryURL(
                      Urls.assetSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected!.CustomerUID,
                              menuFilterType,
                              appliedFilters!,
                              ScreenType.ASSET_OPERATION),
                      accountSelected!.CustomerUID,
                      "in-vutilization-utz-webapi")
                  : await MyApi().getClient()!.assetSummaryURL(
                      Urls.assetSummary +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              menuFilterType,
                              appliedFilters!,
                              ScreenType.ASSET_OPERATION),
                      accountSelected!.CustomerUID,
                      "in-vutilization-utz-webapi");
          return assetResponse.assetOperations;
        }
      }
    } catch (e) {
      Logger().e("getAssetSummaryList $e");
      return null;
    }
  }

  Future<AssetDetail?> getAssetDetail(assetUID) async {
    try {
      if (isVisionLink) {
        AssetDetail assetResponse = await MyApi().getClient()!.assetDetailVL(
              assetUID,
              accountSelected!.CustomerUID,
            );
        return assetResponse;
      } else {
        AssetDetail assetResponse = await MyApi().getClient()!.assetDetail(
            Urls.assetDetails,
            assetUID,
            accountSelected!.CustomerUID,
            Urls.vfleetPrefix);
        return assetResponse;
      }
    } catch (e) {
      Logger().e("getAssetDetail $e");
      return null;
    }
  }

  Future<List<AssetDevice>?> getAssetDevice(assetUID) async {
    try {
      AssetDeviceResponse assetResponse = await MyApi()
          .getClient()!
          .asset(assetUID, accountSelected!.CustomerUID);
      return assetResponse.Devices;
    } catch (e) {
      Logger().e("getAssetDevice $e");
      return [];
    }
  }

  Future<List<Note>?> getAssetNotes(assetUID) async {
    try {
      if (isVisionLink) {
        List<Note> notes = await MyApi().getClient()!.getAssetNotesVL(
              assetUID,
              accountSelected!.CustomerUID,
            );
        if (notes != null) {
          return notes;
        }
      } else {
        List<Note> notes = await MyApi().getClient()!.getAssetNotes(
              Urls.notes,
              assetUID,
              Urls.assetprefix,
              accountSelected!.CustomerUID,
              (await _localService!.getLoggedInUser())!.sub,
            );
        if (notes != null) {
          return notes;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  postNotes(assetUID, note) async {
    try {
      if (isVisionLink) {
        await MyApi().getClient()!.postNotesVL(
              PostNote(assetUID: assetUID, assetUserNote: note),
            );
      } else {
        await MyApi().getClient()!.postNotes(
            Urls.notes,
            PostNote(assetUID: assetUID, assetUserNote: note),
            Urls.assetprefix);
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
