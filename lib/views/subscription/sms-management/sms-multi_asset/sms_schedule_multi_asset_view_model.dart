import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SmsScheduleMultiAssetViewModel extends InsiteViewModel {
  Logger log;

  SmsScheduleMultiAssetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
