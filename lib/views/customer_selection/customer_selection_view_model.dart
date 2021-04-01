import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class CustomerSelectionViewModel extends BaseViewModel {
  Logger log;
  bool _isAccountSelected = false;
  bool get isAccountSelected => _isAccountSelected;

  bool _isCustomerSelected = false;
  bool get isCustomerSelected => _isCustomerSelected;

  String _accountSelected = "";
  String get accountSelected => _accountSelected;

  CustomerSelectionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  setAccountSelected(value) {
    _isAccountSelected = value;
    notifyListeners();
  }

  setCustomerSelected(value) {
    _isCustomerSelected = value;
    notifyListeners();
  }
}
