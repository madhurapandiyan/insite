import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class TabPageViewModel extends BaseViewModel {
  Logger log;

  TabPageViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
