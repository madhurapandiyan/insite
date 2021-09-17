import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AdminstrationViewModel extends BaseViewModel {
  Logger log;

  AdminstrationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
