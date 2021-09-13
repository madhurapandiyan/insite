import 'package:insite/core/base/insite_view_model.dart';

class UtilLizationViewModel extends InsiteViewModel {
  UtilLizationViewModel() {
    setUp();
    Future.delayed(Duration(seconds: 1), () {
      refresh();
    });
  }

  void refresh() async {
    await getSelectedFilterData();
    notifyListeners();
  }
}
