import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class RuntimeHoursViewModel extends BaseViewModel {
  Logger log;

  RuntimeHoursViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
