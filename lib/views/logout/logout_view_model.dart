import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class LogoutViewModel extends BaseViewModel {
  Logger log;

  LogoutViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
