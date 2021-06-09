import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class FuelBurnRateTrendViewModel extends BaseViewModel {
  Logger log;

  FuelBurnRateTrendViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
