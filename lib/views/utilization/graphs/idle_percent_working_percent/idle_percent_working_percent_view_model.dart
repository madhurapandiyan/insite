import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class IdlePercentWorkingPercentViewModel extends BaseViewModel {
  Logger log;

  IdlePercentWorkingPercentViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
