import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class TestRouterViewModel extends BaseViewModel {
  Logger log;

  TestRouterViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
