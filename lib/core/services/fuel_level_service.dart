import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fuel_level.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class FuelLevelService {
  var _localService = locator<LocalService>();

  Customer accountSelected;

  FuelLevelService() {
    setup();
  }
  setup() async {
    try {
      accountSelected = await _localService.getAccountInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<FuelLevelData> getfuelLevel() async {
    try {
      FuelLevelData fuelLevelDatarespone = await MyApi()
          .getClient()
          .fuelLevel("fuellevel", "25-50-75-100", accountSelected.CustomerUID);
      print('data:${fuelLevelDatarespone.countData[0].countOf}');
      return fuelLevelDatarespone;
    } catch (e) {
      Logger().e(e);
    }
  }
}
