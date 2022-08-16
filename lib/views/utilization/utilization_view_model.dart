import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/models/filter_data.dart';

class UtilLizationViewModel extends InsiteViewModel {
  UtilLizationViewModel() {
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      refresh();
    });
  }

  refresh() async {
    await getSelectedFilterData();
    notifyListeners();
  }
}
