import 'package:geocore/geocore.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/geofencemodel.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class ManageGeofenceViewModel extends InsiteViewModel {
  final _localService = locator<LocalService>();
  Logger log;
  List<Polygon> _dat = [];
  List<Polygon> get dat => _dat;
  ManageGeofenceViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  getdata() async {
    Polygon testdata;

    Customer customer = await _localService.getAccountInfo();
    try {
      Geofence Data = await MyApi().getClientSeven().getgeofencedata(
          "Bearer ${_localService.getToken()}", customer.CustomerUID);
      for (var i = 0; i < Data.Geofences.length; i++) {
        String test;
        test = Data.Geofences[i].GeometryWKT;
        testdata = wktGeographic.parse(dat[i]);
        dat.add(testdata);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    notifyListeners();
  }

  notifyListeners();
}
