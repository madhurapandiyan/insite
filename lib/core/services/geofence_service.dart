import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/geofencemodel.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';

class Geofenceservice extends BaseService {
  final _localService = locator<LocalService>();

  Future<Geofence> getgeoencedata() async {
    Customer customer = await _localService.getAccountInfo();
    Geofence Data = await MyApi().getClientSeven().getgeofencedata(
        "Bearer ${_localService.getToken()}", customer.CustomerUID);
    return Data;
  }
  
  
}
