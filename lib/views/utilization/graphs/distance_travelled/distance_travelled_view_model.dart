import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class DistanceTravelledViewModel extends BaseViewModel {
  Logger log;

  DistanceTravelledViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
