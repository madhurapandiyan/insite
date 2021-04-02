import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class FleetViewModel extends BaseViewModel {
  Logger log;

  FleetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
