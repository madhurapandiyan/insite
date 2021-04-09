import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;

  LoginViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
