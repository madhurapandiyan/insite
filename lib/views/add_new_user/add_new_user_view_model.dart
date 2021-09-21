import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddNewUserViewModel extends BaseViewModel {
  Logger log;

  AddNewUserViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
