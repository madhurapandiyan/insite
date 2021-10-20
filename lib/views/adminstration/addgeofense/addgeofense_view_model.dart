import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddgeofenseViewModel extends InsiteViewModel {
  Logger log;

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
  notifyListeners();
}
