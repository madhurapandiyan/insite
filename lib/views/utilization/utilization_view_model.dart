import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/logger.dart';

import 'package:logger/logger.dart';

class UtilLizationViewModel extends InsiteViewModel {
  Logger log;

  bool _isMain = false;
  bool get isMain => _isMain;

  UtilLizationViewModel(value) {
    _isMain = value;
    this.log = getLogger(this.runtimeType.toString());
  }
}
