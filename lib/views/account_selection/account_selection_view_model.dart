import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/widgets/smart_widgets/customer_selection_dropdown.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountSelectionViewModel extends InsiteViewModel {
  var _localService = locator<LocalService>();
  var _loginService = locator<LoginService>();
  var _navigationService = locator<NavigationService>();
  var _localStorageService = locator<LocalStorageService>();

  Logger log;

  String _loggedInUserMail = "";
  String get loggedInUserMail => _loggedInUserMail;

  bool _loading = true;
  bool get loading => _loading;

  bool _secondaryLoading = false;
  bool get secondaryLoading => _secondaryLoading;

  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;

  Customer _accountSelected;
  Customer get accountSelected => _accountSelected;

  Customer _subAccountSelected;
  Customer get subAccountSelected => _subAccountSelected;

  List<AccountData> _customers = [];
  List<AccountData> get customers => _customers;

  List<AccountData> _subCustomers = [];
  List<AccountData> get subCustomers => _subCustomers;

  List<Permission> _permissions = [];
  List<Permission> get permissions => _permissions;

  AccountSelectionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _localStorageService.setUp();
    setUp();
    getLoggedInUserMail();
    getSelectedData();
    getCustomerList();
    Future.delayed(Duration(seconds: 1), () {
      if (_subAccountSelected != null) {
        getSubCustomerList();
      }
    });
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
    for (Customer customer in result) {
      if (_accountSelected != null &&
          _accountSelected.DisplayName == customer.DisplayName) {
        _customers.add(AccountData(
            isSelected: true,
            selectionType: AccountType.ACCOUNT,
            value: customer));
      } else {
        _customers.add(AccountData(
            isSelected: false,
            selectionType: AccountType.ACCOUNT,
            value: customer));
      }
    }
    _loading = false;
    notifyListeners();
  }

  Future<List<Customer>> getSubCustomerList() async {
    Logger().d("getSubCustomerList");
    List<Customer> result =
        await _loginService.getSubCustomers(_accountSelected.CustomerUID);
    Logger().d("getSubCustomerList result " + result.length.toString());
    if (result.isNotEmpty) {
      _subCustomers.clear();
      if (_subAccountSelected != null &&
          _subAccountSelected.DisplayName == "ALL") {
        _subCustomers.add(AccountData(
            isSelected: true,
            selectionType: AccountType.CUSTOMER,
            value: Customer(
                CustomerUID: "",
                Name: "ALL ACCOUNTS",
                CustomerType: "ALL",
                DisplayName: "ALL ACCOUNTS",
                Children: [])));
      } else {
        _subCustomers.add(AccountData(
            isSelected: false,
            selectionType: AccountType.CUSTOMER,
            value: Customer(
                CustomerUID: "",
                Name: "ALL ACCOUNTS",
                CustomerType: "ALL",
                DisplayName: "ALL ACCOUNTS",
                Children: [])));
      }
      for (Customer customer in result) {
        if (_subAccountSelected != null &&
            _subAccountSelected.DisplayName == customer.DisplayName) {
          _subCustomers.add(AccountData(
              isSelected: true,
              selectionType: AccountType.CUSTOMER,
              value: customer));
        } else {
          _subCustomers.add(AccountData(
              isSelected: false,
              selectionType: AccountType.CUSTOMER,
              value: customer));
        }
      }
    }
    _loading = false;
    notifyListeners();
    return result;
  }

  resetSelection() {
    _accountSelected = null;
    _subAccountSelected = null;
    notifyListeners();
  }

  setAccountSelected(value) async {
    Logger().d("setAccountSelected $value");
    _accountSelected = value;
    _subAccountSelected = null;
    _subCustomers.clear();
    _secondaryLoading = true;
    notifyListeners();
    if (accountSelected != null) {
      List<Customer> subCustomerlist = await getSubCustomerList();
      if (subCustomerlist.isEmpty) {
        await _localService.saveAccountInfo(accountSelected);
        await _localService.saveCustomerInfo(null);
        onCustomerSelected();
      } else {
        _secondaryLoading = false;
        notifyListeners();
      }
    }
  }

  setSubAccountSelected(Customer value) {
    Logger().d("setSubAccountSelected " + value.CustomerUID);
    _subAccountSelected = value;
    _localService.saveAccountInfo(accountSelected);
    if (value.CustomerType != "ALL") {
      _localService.saveCustomerInfo(value);
    } else {
      _localService.saveCustomerInfo(null);
    }
    Future.delayed(Duration(seconds: 2), () {
      notifyListeners();
    });
  }

  onCustomerSelected() {
    Logger().d("onCustomerSelected");
    checkPermission();
  }

  onHomeSelected() async {
    Logger().d("onHomeSelected");
    await _localStorageService.clearAll();
    _navigationService.replaceWith(dashboardViewRoute);
  }

  checkPermission() async {
    Logger().d("checkPermission");
    _secondaryLoading = true;
    notifyListeners();
    List<Permission> list = await _loginService.getPermissions();
    if (list.isNotEmpty) {
      _localService.setHasPermission(true);
      clearDb();
      _secondaryLoading = false;
      notifyListeners();
      onHomeSelected();
    } else {
      _youDontHavePermission = true;
      _secondaryLoading = false;
      notifyListeners();
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
