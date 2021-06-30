import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/repository/db.dart';
import 'package:insite/core/repository/network.dart';
import 'package:logger/logger.dart';

class IdlingLevelService extends DataBaseService {
  Future<AssetCount> getIdlingLevel(startDate, endDate) async {
    try {
      AssetCount idlingLevelDataResponse = await MyApi()
          .getClient()
          .idlingLevel(startDate, "[0,10][10,15][15,25][25,]", endDate,
              accountSelected.CustomerUID);
      print('idlingdata:${idlingLevelDataResponse.countData[0].count}');
      return idlingLevelDataResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
