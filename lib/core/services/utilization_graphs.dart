import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class UtilizationGraphsService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  UtilizationGraphsService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<RunTimeCumulative> getRunTimeCumulative(
      String startDate, String endDate) async {
    try {
      if (startDate != null &&
          startDate.isNotEmpty &&
          endDate != null &&
          endDate.isNotEmpty) {
        RunTimeCumulative response = await MyApi()
            .getClient()
            .runtimeCumulative(
                startDate, endDate, 'd7ac4554-05f9-e311-8d69-d067e5fd4637');
        return response;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<FuelBurnedCumulative> getFuelBurnedCumulative(
      String startDate, String endDate) async {
    try {
      if (startDate != null &&
          startDate.isNotEmpty &&
          endDate != null &&
          endDate.isNotEmpty) {
        FuelBurnedCumulative response = await MyApi()
            .getClient()
            .fuelBurnedCumulative(
                startDate, endDate, 'd7ac4554-05f9-e311-8d69-d067e5fd4637');
        return response;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
