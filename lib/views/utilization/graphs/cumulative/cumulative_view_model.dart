import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class CumulativeViewModel extends BaseViewModel {
  Logger log;

  CumulativeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
