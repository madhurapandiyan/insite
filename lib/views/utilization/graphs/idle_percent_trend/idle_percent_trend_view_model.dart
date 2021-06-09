import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class IdlePercentTrendViewModel extends BaseViewModel {
  Logger log;

  IdlePercentTrendViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
