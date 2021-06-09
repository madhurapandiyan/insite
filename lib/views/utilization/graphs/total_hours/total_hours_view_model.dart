import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class TotalHoursViewModel extends BaseViewModel {
  Logger log;

  TotalHoursViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
