import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';

import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:logger/logger.dart';

class Geofenceservice extends BaseService {
  final _localService = locator<LocalService>();

  Future<Geofence> getgeoencedata() async {
    Customer customer = await _localService.getAccountInfo();
    Geofence Data = await MyApi().getClientSeven().getgeofencedata(
        "Bearer ${_localService.getToken()}", customer.CustomerUID);
    return Data;
  }

  Future<Materialmodel> getmaterialmodeldata() async {
    Customer customer = await _localService.getAccountInfo();
    Materialmodel data = await MyApi().getClientSeven().getmaterialmodel(
        "Bearer ${_localService.getToken()}", customer.CustomerUID);
    return data;
  }
}
