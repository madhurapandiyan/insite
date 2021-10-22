import 'package:geocore/geocore.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/geofencemodel.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:wkt_parser/wkt_parser.dart';

class AddgeofenseViewModel extends InsiteViewModel {
  Logger log;
  final _localService = locator<LocalService>();

  AddgeofenseViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  bool setDefaultPreferenceToUser = false;
  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;
  String value = "Administrator";
  List<String> dropDownlist = [
    "Administrator",
    "Contributor",
    "Creator",
    "Viewer"
  ];
  change_checkboxstate() {
    setDefaultPreferenceToUser = !setDefaultPreferenceToUser;
    Logger().e(setDefaultPreferenceToUser);
    notifyListeners();
  }

  getdata() async {
    List<String> dat = [];
    Geometry testdata;

    Customer customer = await _localService.getAccountInfo();
    try {
      Geofence Data = await MyApi().getClientSeven().getgeofencedata(
          "Bearer ${_localService.getToken()}", customer.CustomerUID);
      for (var i = 0; i < Data.Geofences.length; i++) {
        String test;
        test = Data.Geofences[i].GeometryWKT;
        dat.add(test);
      }
      print(dat.first);
      testdata = wktGeographic.parse(dat.last);
      Logger().e(testdata);
      //Logger().i(dat);
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  notifyListeners();
}
