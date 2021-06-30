import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/repository/db.dart';
import 'package:insite/core/repository/network.dart';
import 'package:logger/logger.dart';

class FuelLevelService extends DataBaseService {

  Future<AssetCount> getFuellevel() async {
    try {
      AssetCount fuelLevelDatarespone = await MyApi()
          .getClient()
          .fuelLevel("fuellevel", "25-50-75-100", accountSelected.CustomerUID);
      print('data:${fuelLevelDatarespone.countData[0].countOf}');
      return fuelLevelDatarespone;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
