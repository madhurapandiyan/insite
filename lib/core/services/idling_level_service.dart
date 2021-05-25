import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/idling_level.dart';
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

  Future<IdlingLevelData> getidlingLevelService() async {
    try {
      IdlingLevelData idlingLevelDataResponse = await MyApi()
          .getClient()
          .idlingLevel("05/24/21", "[0,10][10,15][15,25][25,]", "05/24/21",
              accountSelected.CustomerUID);
      print('idlingdata:${idlingLevelDataResponse.countData[0].count}');
      return idlingLevelDataResponse;
    } catch (e) {
      Logger().e(e);
    }
  }
}
