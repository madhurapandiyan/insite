import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class LogoutViewModel extends InsiteViewModel {
  Logger log;

  LogoutViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
