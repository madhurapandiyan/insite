import 'package:get_it/get_it.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/asset_location_history_service.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/date_range_service.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/core/services/native_service.dart';
import 'package:insite/core/services/plant_hierachy_service.dart';
import 'package:insite/core/services/preference_service.dart';
import 'package:insite/core/services/replacement_service.dart';
import 'package:insite/core/services/search_service.dart';
import 'package:insite/core/services/single_asset_operation_service.dart';
import 'package:insite/core/services/sms_management_service.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/core/services/utilization_graph_service.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logger.dart';

final GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setUpLocator() async {
    Logger log = getLogger('Locator Injector');
    log.d('Registering Navigation Service');
    locator.registerLazySingleton(() => NavigationService());
    log.d('Registering Dialog Service');
    locator.registerLazySingleton(() => DialogService());
    // log.d('Registering Dialog Service');
    // locator.registerLazySingleton(() => clearDialogService());
    log.d('Registering Snackbar Service');
    locator.registerLazySingleton(() => SnackbarService());
    log.d('Registering shared preferences  Service');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locator.registerLazySingleton(() => prefs);
    log.d('Registering Local storage Service');
    locator.registerLazySingleton(() => LocalService(locator()));
    log.d('Registering login  Service');
    locator.registerLazySingleton(() => LoginService());
    log.d('Registering native  Service');
    locator.registerLazySingleton(() => NativeService(locator()));
    log.d('Registering fleet  Service');
    locator.registerLazySingleton(() => FleetService());
    log.d('Registering asset  Service');
    locator.registerLazySingleton(() => AssetService());
    log.d('Registering Search Service');
    locator.registerLazySingleton(() => SearchService());
    log.d('Registering Asset Location History Service');
    locator.registerLazySingleton(() => AssetLocationHistoryService());
    log.d("Registering Asset Utilization Service");
    locator.registerLazySingleton(() => AssetUtilizationService());
    log.d("Registering Asset Status Service");
    locator.registerLazySingleton(() => AssetStatusService());
    log.d("Registering Asset Location Service");
    locator.registerLazySingleton(() => AssetLocationService());
    log.d("Registering Single Asset Operation Service");
    locator.registerLazySingleton(() => SingleAssetOperationService());
    log.d("Registering Filter Service");
    locator.registerLazySingleton(() => FilterService());
    log.d("Registering Utilization Graphs Service");
    locator.registerLazySingleton(() => UtilizationGraphsService());
    log.d("Registering DateRangeService Service");
    locator.registerLazySingleton(() => DateRangeService());
    log.d("Registering LocalStorage Service");
    locator.registerLazySingleton(() => LocalStorageService());
    log.d("Registering Fault Service");
    locator.registerLazySingleton(() => FaultService());
    log.d("Registering ManageUserService");
    locator.registerLazySingleton(() => AssetAdminManagerUserService());
    log.d("Registering GEOFENCESERVICE");
    locator.registerLazySingleton(() => Geofenceservice());
    log.d(" Registering SubscriptionService");
    locator.registerLazySingleton(() => SubScriptionService());
    log.d('Registering PlantHierachyService');
    locator.registerLazySingleton(() => PlantHeirarchyAssetService());
    log.d('Registering SmsManagementService');
    locator.registerLazySingleton(() => SmsManagementService());
    log.d('Registering SmsManagementService');
    locator.registerLazySingleton(() => ReplacementService());
    log.d('GraphQl schema Service');
    locator.registerLazySingleton(() => GraphqlSchemaService());
    log.d('Registering Notification Service');
    locator.registerLazySingleton(() => NotificationService());
    log.d("Registering Maintenance Service ");
    locator.registerLazySingleton(() => MaintenanceService());
    log.d("Registering Preference Service ");
    locator.registerLazySingleton(() => PreferenceService());
  }
}
