import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class IdlingLevelService {
  var _localService = locator<LocalService>();
  Customer accountSelected;

  IdlingLevelService() {
    setup();
  }

  setup() async {
    try {
      accountSelected = await _localService.getAccountInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetCountData> getIdlingLevel(startDate, endDate) async {
    try {
      AssetCountData idlingLevelDataResponse = await MyApi()
          .getClient()
          .idlingLevel(startDate, "[0,10][10,15][15,25][25,]", endDate,
              accountSelected.CustomerUID);
      print('idlingdata:${idlingLevelDataResponse.countData[0].count}');
      return idlingLevelDataResponse;
    } catch (e) {
      Logger().e(e);
    }
  }
}
