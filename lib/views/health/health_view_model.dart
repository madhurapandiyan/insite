import 'package:insite/core/base/insite_view_model.dart';

class HealthViewModel extends InsiteViewModel {
  HealthViewModel() {
    setUp();
    Future.delayed(Duration(seconds: 1), () async {
      await refresh();
    });
  }

  refresh() async {
    await getSelectedFilterData();
  }
}
