import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class CustomerSelectionViewModel extends BaseViewModel {
  var _localService = locator<LocalService>();
  var _loginService = locator<LoginService>();

  Logger log;

  String _loggedInUserMail = "";
  String get loggedInUserMail => _loggedInUserMail;

  bool _loading = false;
  bool get loading => _loading;

  bool _onAccountSelected = false;
  bool get onAccountSelected => _onAccountSelected;

  Customer _accountSelected;
  Customer get accountSelected => _accountSelected;

  Customer _subAccountSelected;
  Customer get subAccountSelected => _subAccountSelected;

  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  List<Customer> _subCustomers = [];
  List<Customer> get subCustomers => _subCustomers;

  CustomerSelectionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getLoggedInUserMail();
    getCustomerList();
  }

  getLoggedInUserMail() async {
    UserInfo userInfo = await _localService.getLoggedInUser();
    _loggedInUserMail = userInfo.email;
    notifyListeners();
  }

  getCustomerList() async {
    Logger().d("getCustomerList");
    List<Customer> result = await _loginService.getCustomers();
    Logger().d("getCustomerList " + result.length.toString());
    _customers = result;
    notifyListeners();
  }

  getSubCustomerList() async {
    Logger().d("getSubCustomerList");
    List<Customer> result =
        await _loginService.getSubCustomers(_accountSelected.CustomerUID);
    Logger().d("getSubCustomerList " + result.length.toString());
    if (result.isEmpty) {
      _onAccountSelected = true;
      _localService.saveAccountInfo(accountSelected);
      _localService.saveCustomerInfo(null);
      Future.delayed(Duration(seconds: 1), () {
        notifyListeners();
      });
    } else {
      _subCustomers = result;
      notifyListeners();
    }
  }

  setAccountSelected(value) {
    _accountSelected = value;
    notifyListeners();
    if (accountSelected != null) {
      getSubCustomerList();
    }
  }

  setSubAccountSelected(value) {
    _subAccountSelected = value;
    _localService.saveAccountInfo(accountSelected);
    _localService.saveCustomerInfo(subAccountSelected);
    Future.delayed(Duration(seconds: 1), () {
      notifyListeners();
    });
  }

  showLoader() {
    _loading = true;
    notifyListeners();
  }

  hideLoader() {
    _loading = false;
    notifyListeners();
  }
}
