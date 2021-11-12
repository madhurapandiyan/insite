import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SmsManagementViewModel extends InsiteViewModel {
  Logger log;

  SmsManagementViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
