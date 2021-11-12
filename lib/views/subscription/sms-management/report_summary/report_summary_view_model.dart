import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class ReportSummaryViewModel extends InsiteViewModel {
  Logger log;

  ReportSummaryViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
