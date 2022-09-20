import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/models/filter_data.dart';

class UtilLizationViewModel extends InsiteViewModel {
   bool isListSelected = true;
  UtilLizationViewModel() {
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      refresh();
    });
  }

  refresh() async {
    isListSelected=true;
    await getSelectedFilterData();
    notifyListeners();
  }
}
