import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/logger.dart';
import 'package:logger/logger.dart';

class UtilLizationViewModel extends InsiteViewModel {
  Logger log;

  bool _isFilterApplied = false;
  bool get isFilterApplied => _isFilterApplied;

  UtilLizationViewModel(value) {
    _isFilterApplied = value;
    this.log = getLogger(this.runtimeType.toString());
  }

  void refresh() {}
}
