import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomerSelectionViewModel extends InsiteViewModel {
  var _localService = locator<LocalService>();
  var _loginService = locator<LoginService>();
  var _navigationService = locator<NavigationService>();

  Logger log;

  String _loggedInUserMail = "";
  String get loggedInUserMail => _loggedInUserMail;

  bool _loading = false;
  bool get loading => _loading;

  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;

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

  List<Permission> _permissions = [];
  List<Permission> get permissions => _permissions;

  CustomerSelectionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _loading = true;
    getLoggedInUserMail();
    getSelectedData();
    getCustomerList();
  }

  getSelectedData() async {
    Logger().i("getSelectedData");
    try {
      Customer account = await _localService.getAccountInfo();
      if (account != null) {
        Logger().i("selected account " + account.DisplayName);
        _accountSelected = account;
        notifyListeners();
      }
      Customer _subAccount = await _localService.getCustomerInfo();
      if (_subAccount != null) {
        Logger().i("selected sub account " + _subAccount.DisplayName);
        _subAccountSelected = _subAccount;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
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
    _loading = false;
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
      _subCustomers.add(Customer(
          CustomerUID: "",
          Name: "ALL ACCOUNTS",
          CustomerType: "ALL",
          DisplayName: "ALL ACCOUNTS",
          Children: []));
      _subCustomers.addAll(result);
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

  setSubAccountSelected(Customer value) {
    _subAccountSelected = value;
    _localService.saveAccountInfo(accountSelected);
    if (value.CustomerType != "ALL") {
      _localService.saveCustomerInfo(subAccountSelected);
    }
    Future.delayed(Duration(seconds: 1), () {
      notifyListeners();
    });
  }

  onCustomerSelected() {
    checkPermission();
  }

  onHomeSelected() {
    _navigationService.replaceWith(dashboardViewRoute);
  }

  checkPermission() async {
    List<Permission> list = await _loginService.getPermissions();
    if (list.isNotEmpty) {
      _localService.setHasPermission(true);
      _navigationService.replaceWith(dashboardViewRoute);
    } else {
      _youDontHavePermission = true;
      _localService.setHasPermission(false);
    }
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
