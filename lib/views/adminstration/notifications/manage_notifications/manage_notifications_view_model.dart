import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:logger/logger.dart';

class ManageNotificationsViewModel extends InsiteViewModel {
  late Logger log;

  NotificationService? _notificationService = locator<NotificationService>();

  ManageNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    setUp();
    getManageNotificationsData();
  }

  List<ConfiguredAlerts> _notifications = [];
  List<ConfiguredAlerts> get assets => _notifications;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  getManageNotificationsData() async {
    ManageNotificationsData? response =
        await _notificationService!.getManageNotificationsData();

    if (response != null) {
      if (response.configuredAlerts != null &&
          response.configuredAlerts!.isNotEmpty) {
        _notifications.addAll(response.configuredAlerts!);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _notifications.addAll(response.configuredAlerts!);
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }

    Logger().wtf(response);
  }
}
