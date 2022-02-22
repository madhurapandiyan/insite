import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/add_asset_transfer.dart';
import 'package:insite/core/models/add_group_data_response.dart';
import 'package:insite/core/models/add_notification_payload.dart';
import 'package:insite/core/models/add_report_payload.dart';

import 'package:insite/core/models/edit_group_payload.dart';
import 'package:insite/core/models/add_group_payload.dart';
import 'package:insite/core/models/add_user.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/application.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_creation_payload.dart';
import 'package:insite/core/models/asset_creation_reset_data.dart';
import 'package:insite/core/models/asset_creation_response.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_device.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings_list_data.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/models/asset_location.dart' as location;
import 'package:insite/core/models/asset_mileage_settings_list_data.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/device_details_per_id.dart';
import 'package:insite/core/models/device_type.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/edit_report_response.dart';
import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/estimated_cycle_volume_payload.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/core/models/get_asset_details_by_serial_no.dart';
import 'package:insite/core/models/get_single_transfer_device_id.dart';
import 'package:insite/core/models/favorite_payload.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/models/hierarchy_model.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/core/models/idling_level.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';

import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/models/manage_report_delete_asset_response.dart';
import 'package:insite/core/models/manage_report_response.dart';

import 'package:insite/core/models/note.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/prefill_customer_details.dart';
import 'package:insite/core/models/refresh_token_payload.dart';
import 'package:insite/core/models/role_data.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/models/single_asset_fault_response.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_serial_number_results.dart';
import 'package:insite/core/models/template_response.dart';
import 'package:insite/core/models/token.dart';
import 'package:insite/core/models/total_fuel_burned.dart';
import 'package:insite/core/models/total_hours.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/models/user.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/asset_icon_payload.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_status_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model_response.dart';
import 'package:insite/views/subscription/replacement/model/replace_deviceId_model.dart';
import 'package:insite/views/subscription/replacement/model/replacement_deviceId_download.dart';
import 'package:insite/views/subscription/replacement/model/replacement_model.dart';
import 'package:insite/views/subscription/sms-management/model/delete_sms_management_schedule.dart';
import 'package:insite/views/subscription/sms-management/model/saving_sms_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_reportSummary_responce_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_model.dart';
import 'package:insite/views/subscription/sms-management/model/sms_single_asset_responce_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/models/asset_mileage_settings.dart';
part 'Retrofit.g.dart';

//part 'Retrofit.g.dart';

// RUN THIS TO GENERATE FILES
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs

// RUN THIS TO GENERATE FILES WITH FVM
// fvm flutter pub run build_runner build
// fvm flutter pub run build_runner build --delete-conflicting-outputs

// Run this command to take build with split apks and share v7 architecture build
// flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
// Run this command to take debug build with split apks
// flutter build apk --debug --target-platform android-arm,android-arm64,android-x64 --split-per-abi
// Run this command to take build for uploading to playstore
// flutter build appbundle

// use this user name & password in this application for testing purpose
// link to the samples web application equavalent of this mobile app 1 -> https://unifiedfleet.myvisionlink.com  , 2 ->
// abdul_kareem@trimble.com
// Abdul123$

@RestApi(
  baseUrl: "https://cloud.api.trimble.com/CTSPulseIndiastg",
)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  // https://cloud.stage.api.trimblecloud.com/osg-frame/frame-api/2.0/oemdetails?OEM=VEhD

  @GET("/tasks")
  Future<List<Sample>> getTasks();

  @GET("/userinfo?schema=openid")
  Future<UserInfo> getUserInfo(@Header("content-type") String? contentType,
      @Header("Authorization") String? authorization);

  @GET("/oauth/userinfo")
  Future<UserInfo> getUserInfoVl(@Header("content-type") String? contentType,
      @Header("Authorization") String? authorization);

  @POST("/oauth/userinfo")
  Future<UserInfo> getUserInfoV4(
      @Header("content-type") String contentType,
      @Header("Authorization") String authorization,
      @Body() AccessToken accessToken);

  @GET(
      "/t/trimble.com/authorization/1.0.0/users/{user_guid}/organizations/{customerId}/permissions")
  Future<PermissionResponse> getPermission(
    @Query("limit") int limit,
    @Query("provider_id") String provider_id,
    @Header("X-VisionLink-CustomerUid") xVisonLinkCustomerId,
    @Path() String customerId,
    @Path() String user_guid,
  );

  @GET(
      "/t/trimble.com/authorization/1.0.0/users/organizations/{customerId}/permissions")
  Future<PermissionResponse> getPermissionVL(
      @Query("limit") int limit,
      @Query("provider_id") String? provider_id,
      @Path() String? customerId,
      @Header("X-VisionLink-CustomerUid") xVisonLinkCustomerId);

  @GET('{url}')
  Future<CustomersResponse> accountHierarchy(
      @Path() String url,
      @Query("toplevelsonly") bool toplevelsonly,
      @Header("service") String serviceHeader);

  @GET("/t/trimble.com/vss-customerservice/1.0/accounthierarchy")
  Future<CustomersResponse> accountHierarchyVL(
      @Query("toplevelsonly") bool toplevelsonly);

  @GET('{url}')
  Future<CustomersResponse> accountHierarchyChildren(
      @Path() String url,
      @Query("targetcustomeruid") String targetcustomeruid,
      @Header("service") String serviceHeader);

  @GET("/t/trimble.com/vss-customerservice/1.0/accounthierarchy")
  Future<CustomersResponse> accountHierarchyChildrenVL(
      @Query("targetcustomeruid") String targetcustomeruid);

  @GET('{url}')
  Future<FleetSummaryResponse> fleetSummaryURL(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<FleetSummaryResponse> fleetSummaryURLVL(
      @Path() String url, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<AssetResponse> assetSummaryURL(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetResponse> assetSummaryURLVL(
      @Path() String url, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<AssetLocationData> assetLocationWithCluster(
      @Path() String url,
      @Query("latitude") double latitude,
      @Query("longitude") double longitude,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("radiuskm") double radiusKm,
      @Query("sort") String sort,
      @Header("x-visionlink-customeruid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleetmap/1.0/location/maps/v1")
  Future<AssetLocationData> assetLocationWithClusterVL(
      @Query("latitude") double latitude,
      @Query("longitude") double longitude,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("radiuskm") double radiusKm,
      @Query("sort") String sort,
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<location.AssetLocationData> assetLocationSummary(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<location.AssetLocationData> assetLocationSummaryVL(
      @Path() String url, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<AssetDetail> assetDetail(
      @Path() String url,
      @Query("assetUID") String? assetUID,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetDetails/v1")
  Future<AssetDetail> assetDetailVL(@Query("assetUID") String? assetUID,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<AssetDetail> assetDetailCI(
      @Path() String url,
      @Query("assetUID") String assetUID,
      @Query("customerUID") String customerUID,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<List<Note>> getAssetNotes(
    @Path() String url,
    @Query("assetUID") String assetUID,
    @Header("service") serviceHeader,
    @Header("X-VisionLink-CustomerUid") customerId,
    @Header("X-VisionLink-UserUid") userId,
  );

  @GET("/t/trimble.com/VSS-AssetMetadata/1.0/AssetMetadata/Notes/v1/")
  Future<List<Note>> getAssetNotesVL(@Query("assetUID") String? assetUID,
      @Header("X-VisionLink-CustomerUid") customerId);

  @POST('{url}')
  Future<dynamic> postNotes(@Path() String url, @Body() PostNote postnote,
      @Header("service") serviceHeader);

  @POST("/t/trimble.com/VSS-AssetMetadata/1.0/AssetMetadata/Notes/v1")
  Future<dynamic> postNotesVL(@Body() PostNote postnote);

  @POST("/npulse-masterdataapi-in/1.0/v1/ping")
  Future<dynamic> ping(@Body() PingPostDeviceData postnote);

  @GET("/npulse-masterdataapi-in/1.0/v1/ping")
  Future<PingDeviceData> getPingData(
      @Query("AssetUID") String assetUID, @Query("DeviceUID") String deviceUID);

  @GET("/t/trimble.com/vss-deviceservice/2.0/asset")
  Future<AssetDeviceResponse> asset(@Query("assetUID") String assetUID,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<SearchData> search(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SearchData> searchVL(
      @Path() String url, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<AssetLocationHistory> assetLocationHistory(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetLocationHistory> assetLocationHistoryVL(
      @Path() String url, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<UtilizationSummaryResponse> utilLizationList(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<UtilizationSummaryResponse> utilLizationListVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<SingleAssetUtilization> singleAssetUtilization(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SingleAssetUtilization> singleAssetUtilizationVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET("/npulse-utilization-in/1.0/api/v1/Utilization/Details/Aggregate/v1")
  Future<SingleAssetUtilization> singleAssetUtilizationGraph(
      @Query("AssetUid") String assetUID,
      @Query("startDate") String startDate,
      @Query("endDate") String endDate);

  @GET('{url}')
  Future<Utilization> utilization(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<Utilization> utilizationVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetCount> assetCount(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> assetCountVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetCount> userCount(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> userCountVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<location.AssetLocationData> assetLocationVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetCount> fuelLevel(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> fuelLevelVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetUtilization> assetUtilGraphData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetUtilization> assetUtilGraphDataVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetCount> idlingLevel(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetCount> idlingLevelVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET("/t/trimble.com/vss-notification/1.0/Notification/Count")
  Future<IdlingLevelData> notificationData(
    @Query("notificationStatus") int status,
    @Query("notificationUserStatus") int userStatus,
  );

  @GET('{url}')
  Future<SingleAssetOperation> singleAssetOperation(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SingleAssetOperation> singleAssetOperationVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<RunTimeCumulative> runtimeCumulative(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/hours/cumulatives")
  Future<RunTimeCumulative> runtimeCumulativeVL(
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<FuelBurnedCumulative> fuelBurnedCumulative(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburned/cumulatives")
  Future<FuelBurnedCumulative> fuelBurnedCumulativeVL(
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<TotalHours> getTotalHours(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/hours/cumulatives/intervals")
  Future<TotalHours> getTotalHoursVL(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<TotalFuelBurned> getTotalFuelBurned(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburned/cumulatives/intervals")
  Future<TotalFuelBurned> getTotalFuelBurnedVL(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<IdlePercentTrend> getIdlePercentTrend(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/idlepercent")
  Future<IdlePercentTrend> getIdlePercentTrendVL(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<FuelBurnRateTrend> getFuelBurnRateTrend(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburnrate")
  Future<FuelBurnRateTrend> getFuelBurnRateTrendVL(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId);

  @GET("/ww/api/search")
  Future<LocationSearchResponse> getLocations(
      @Query("query") String query,
      @Query("maxResults") int maxResults,
      @Query("authToken") String authToken);

  @GET('{url}')
  Future<UtilizationSummary> getAssetUtilization(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<UtilizationSummary> getAssetUtilizationcustomerUID(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<UtilizationSummary> getAssetUtilizationVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<UtilizationSummary> getAssetUtilizationcustomerUIDVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @POST("/token")
  Future<LoginResponse> getToken(
      @Query("username") String username,
      @Query("password") String password,
      @Query("grant_type") String granttype,
      @Query("client_id") String clientid,
      @Query("client_secret") String clientsecret,
      @Query("scope") String scope,
      @Header("content-type") String contentType);

  @POST("/oauth/token")
  Future<LoginResponse> getTokenV4(@Body() GetTokenData tokenData,
      @Header("content-type") String contentType);

  @POST("/oauth/token")
  Future<LoginResponse> getRefreshLoginData(
      @Header("content-type") String contentType,
      @Body() RefreshTokenPayload refreshToken);

  @POST("/oauth/token?grant_type=client_credentials")
  Future<LoginResponse> getTokenWithoutLogin(
      @Header("Authorization") String authorization,
      @Header("content-type") String contentType);

  @POST('{url}')
  Future<FaultSummaryResponse> faultViewSummaryURL(
      @Path() String url,
      @Body() dynamic fitlers,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @POST('{url}')
  Future<FaultSummaryResponse> faultViewSummaryURLVL(@Path() String url,
      @Body() dynamic fitlers, @Header("X-VisionLink-CustomerUid") customerId);

  @POST('{url}')
  Future<AssetFaultSummaryResponse> assetViewSummaryURL(
      @Path() String url,
      @Body() dynamic fitlers,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @POST('{url}')
  Future<AssetFaultSummaryResponse> assetViewSummaryURLVL(@Path() String url,
      @Body() dynamic fitlers, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<FaultSummaryResponse> assetViewDetailSummaryURL(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<FaultSummaryResponse> assetViewDetailSummaryURLVL(
      @Path() String url, @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<HealthListResponse> assetViewLocationSummaryURL(
      @Path() String url,
      @Query("assetUid") String? assetUid,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<HealthListResponse> assetViewLocationSummaryURLVL(
      @Path() String url,
      @Query("assetUid") String? assetUid,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<HealthListResponse> getHealthListData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET("/t/trimble.com/vss-service/1.0/health/FaultDetails/v1")
  Future<HealthListResponse> getHealthListDataVL(
    @Query("assetUid") String? assetUid,
    @Query("endDateTime") String endDateTime,
    @Query("langDesc") String langDesc,
    @Query("limit") int limit,
    @Query("page") int page,
    @Query("startDateTime") String startDateTime,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<SingleAssetFaultResponse> getDashboardListData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET("/t/trimble.com/vss-service/1.0/health/faultSummary/v1")
  Future<SingleAssetFaultResponse> getDashboardListDataVL(
    @Query("assetUid") String? assetUid,
    @Query("endDateTime") String endDate,
    @Query("startDateTime") String startDate,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<AssetCount> faultCount(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> faultCountVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1")
  Future<AssetCount> assetStatusFilterDataVL(
      @Query("grouping") String grouping,
      @Query("productfamily") String productfamily,
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetCount> idlingLevelFilterData(
      @Path() String url,
      @Query("startDate") String startDate,
      @Query("idleEfficiencyRanges") String idleEfficiencyRanges,
      @Query("productfamily") String productfamily,
      @Query("endDate") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1")
  Future<AssetCount> idlingLevelFilterDataVL(
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<UtilizationSummary> utilizationSummary(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<UtilizationSummary> utilizationSummaryVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<AssetLocationData> locationFilterData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetLocationData> locationFilterDataVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AdminManageUser> getAdminManagerUserListDataVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<ManageUser> getUser(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<ApplicationData> getApplicationsData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<UpdateResponse> updateUserData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Body() UpdateUserData updateUserData);

  @PUT('{url}')
  Future<UpdateResponse> deleteUsersData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Body() Map<String, dynamic> updateUserData);

  @PUT('{url}')
  Future<UpdateResponse> deleteUsers(
      @Path() String url,
      @Body() Map<String, dynamic> updateUserData,
      @Header("x-visionlink-customeruid") customerId,
      @Header("X-VisionLink-UserUid") userId,
      @Header("service") String serviceHeader);

  @POST("{url}")
  Future<AddUser> addUserData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Body() AddUserData updateUserData);

  @POST("{url}")
  Future<AddUser> inviteUser(
      @Path() String url,
      @Body() AddUserDataIndStack updateUserData,
      @Header("x-visionlink-customeruid") customerId,
      @Header("X-VisionLink-UserUid") userId,
      @Header("service") String serviceHeader);

  @GET("{url}")
  Future<RoleDataResponse> roles(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<AdminManageUser> getAdminManagerUserListData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") String serviceHeader);

  @GET('{url}')
  Future<ManageAssetConfiguration> getAssetSettingsListDataVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET('{url}')
  Future<ManageAssetConfiguration> getAssetSettingsListData(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") String serviceHeader);

  @GET('{url}')
  Future<SubscriptionDashboardResult> getSubscriptionDashboardResults(
    @Path() String url,
  );

  @GET('{url}')
  Future<SingleAssetRegistrationSearchModel> getSubscriptionDeviceResults(
    @Path() String url,
  );

  @GET("{url}")
  Future<SubscriptionDashboardDetailResult> getSubcriptionDeviceListData(
      @Path() String url);

  @GET('{url}')
  Future<HierarchyAssets> getPlantHierarchyAssetsDetails(
    @Path() String url,
  );

  @PUT('{url}')
  Future<AddSettings> getassetSettingsFuelBurnRateDataVL(
      @Path() String url,
      @Body() AssetFuelBurnRateSetting assetFuelBurnRateSetting,
      @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<AddSettings> getassetSettingsFuelBurnRateData(
      @Path() String url,
      @Body() AssetFuelBurnRateSetting assetFuelBurnRateSetting,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @PUT('{url}')
  Future<EstimatedAssetSetting> getAssetTargetSettingsDataVL(
      @Path() String url,
      @Body() EstimatedAssetSetting estimatedAssetSetting,
      @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<EstimatedAssetSetting> getAssetTargetSettingsData(
      @Path() String url,
      @Body() EstimatedAssetSetting estimatedAssetSetting,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST('{url}')
  Future<dynamic> postGeofenceAnotherData(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Body() Addgeofencemodel geofencepayload);

  @PUT('{url}')
  Future<dynamic> putGeofenceAnotherData(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Body() GeofenceModelWithMaterialData geofencepayload);

  @GET("{url}")
  Future<Materialmodel> getMaterialModel(@Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid);

  @PUT("{url}")
  Future<dynamic> putGeofencePayLoadVL(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Body() Geofencepayload geofencepayload);

  @POST("{url}")
  Future<AuthenticatedUser> authenticateUser(
      @Path() String url, @Body() AuthenticatePayload authenticatePayload);

  @PUT("{url}")
  Future<dynamic> putGeofencePayLoad(
    @Path() String url,
    @Header("x-visionlink-customeruid") String? customeruid,
    @Body() Geofencepayload geofencepayload,
    @Header("service") String serviceHeader,
  );

  @POST("{url}")
  Future<dynamic> postGeofencePayLoadVL(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Body() Geofencepayload geofencepayload);

  @POST("{url}")
  Future<dynamic> postGeofencePayLoad(
    @Path() String url,
    @Header("x-visionlink-customeruid") String? customeruid,
    @Body() Geofencepayload geofencepayload,
    @Header("service") String serviceHeader,
  );

  @GET("{url}")
  Future<Geofence> getGeofenceDataVL(@Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid);

  @GET("{url}")
  Future<Geofence> getGeofenceData(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Header("service") String service);

  @DELETE("{url}")
  Future<dynamic> deleteGeofenceVL(@Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid);

  @DELETE("{url}")
  Future<dynamic> deleteGeofence(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Header("service") String service);

  @GET("{url}")
  Future<Geofencemodeldata> getSingleGeofenceVL(@Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid);

  @GET("{url}")
  Future<Geofencemodeldata> getSingleGeofence(
      @Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid,
      @Header("service") String service);

  @PUT('{url}')
  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadDataVL(
      @Path() String url,
      @Body() EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadData(
      @Path() String url,
      @Body() EstimatedCycleVolumePayLoad estimatedCycleVolumePayLoad,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") String serviceHeader);

  @PUT('{url}')
  Future<AssetMileageSettingData> getMileageDataVL(
      @Path() String url,
      @Body() AssetMileageSettingData assetMileageSettingData,
      @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<dynamic> markFavouriteVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<dynamic> markFavourite(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") String service);

  @PUT('{url}')
  Future<AssetMileageSettingData> getMileageData(
      @Path() String url,
      @Body() AssetMileageSettingData assetMileageSettingData,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") String serviceHeader);

  @GET('{url}')
  Future<GetAddgeofenceModel> getGeofenceInputData(@Path() String url,
      @Header("x-visionlink-customeruid") String? customeruid);

  @POST('{url}')
  Future<SingleAssetResponce> postSingleAssetSmsSchedule(
      @Path() String url, @Body() List<SingleAssetSmsSchedule> singleAssetData);

  @POST('{url}')
  Future<EstimatedAssetSetting> getEstimatedTagetListDataVL(
      @Path() String url,
      @Body() List<String> assetUid,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<EstimatedAssetSetting> getEstimatedTagetListData(@Path() String url,
      @Body() List<String?>? assetUid, @Header("service") service);

  @POST('{url}')
  Future<EstimatedCycleVolumePayLoad> getEstimatedCyclePayLoadVoumeListData(
      @Path() String url,
      @Body() List<String>? assetUid,
      @Header("x-visionlink-customeruid") customerId);

  @POST("{url}")
  Future<SavingSmsResponce> savingSms(
      @Path() String url, @Body() List<SavingSmsModel?> singleAssetData);

  @GET('{url}')
  Future<SmsReportSummaryModel> gettingReportSummary(@Path() String url);

  @GET('{url}')
  Future<SmsReportSummaryModel> gettingScheduleReportSummary(
      @Path() String url);

  @PUT('{url}')
  Future<dynamic> getAssetIconDataVL(
      @Path() String url,
      @Body() AssetIconPayLoad assetIconPayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<dynamic> getAssetIconData(
      @Path() String url,
      @Body() AssetIconPayLoad assetIconPayLoad,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<SerialNumberResults> getModelNameFromMachineSerialNumber(
    @Path() String url,
  );

  @POST("{url}")
  Future<AddAssetRegistrationData> getSingleAssetRegistrationData(
      @Path() String url,
      @Body() AddAssetRegistrationData addAssetRegistrationData);

  @POST("{url}")
  Future<AddAssetRegistrationData?> postSingleAssetTransferRegistration(
      @Path() String url, @Body() AssetTransfer data);

  @POST("{url}")
  Future<AssetTransferData> getSingleAssetTransferData(
      @Path() String url, @Body() AssetTransferData assetTransferData);

  @GET("{url}")
  Future<DeviceSearchModel> getDeviceSearchModel(@Path() String url);

  @GET("{url}")
  Future<DeviceSearchModelResponse> getDeviceSearchModelResponse(
      @Path() String url);

  @GET("{url}")
  Future<ReplaceDeviceModel> getReplaceDeviceModel(@Path() String url);

  @POST("{url}")
  Future<dynamic> postNewDeviceId(
      @Path() String url, @Body() ReplacementModel replacementModel);

  @GET("{url}")
  Future<TotalDeviceReplacementStatusModel> getRepalcementDeviceStatus(
      @Path() String url);

  @GET("{url}")
  Future<ReplacementDeviceIdDownload> getReplacementDeviceIdDownload(
      @Path() String url);

  @GET('{url}')
  Future<SingleTransferDeviceId> getSingleAssetTransfersDeviceIds(
    @Path() String url,
  );

  @GET('{url}')
  Future<DeviceDetailsPerId> getDeviceDetailsPerDeviceId(
    @Path() String url,
  );

  @GET('{url}')
  Future<AssetDetailsBySerialNo> getDeviceDetailsPerSerialNo(
    @Path() String url,
  );

  @GET('{url}')
  Future<CustomerDetails> getExitingCustomerDetails(
    @Path() String url,
  );

  @GET('{url}')
  Future<AssetCreationResponse> getAssetCreationData(
    @Path() String url,
  );

  @POST('{url}')
  Future<AssetFuelBurnRateSettingsListData>
      getAssetFuelBurnRateSettingsListDataVL(
          @Path() String url,
          @Body() List<String?>? assetUid,
          @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<AssetFuelBurnRateSettingsListData>
      getAssetFuelBurnRateSettingsListData(
          @Path() String url,
          @Body() List<String?>? assetUid,
          @Header("x-visionlink-customeruid") customerId,
          @Header("service") service);

  @POST('{url}')
  Future<AssetMileageSettingsListData> getAssetMileageSettingsListDataVL(
      @Path() String url,
      @Body() List<String?>? assetUId,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<AssetMileageSettingsListData> getAssetMileageSettingsListData(
      @Path() String url,
      @Body() List<String?>? assetUId,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @POST("{url}")
  Future<dynamic> deleteSmsSchedule(
      @Path() String url, @Body() List<DeleteSmsReport> data);

  @GET("{url}")
  Future<SubscriptionDashboardDetailResult> getFleetStatusData(
      @Path() String url);

  @POST("{url}")
  Future<ListDeviceTypeResponse> getDeviceTypeVL(
    @Path() String url,
    @Body() DeviceTypeRequest assetUId,
    @Header("x-visionlink-customeruid") customerId,
  );

  @POST("{url}")
  Future<ListDeviceTypeResponse> getDeviceType(
    @Path() String url,
    @Body() DeviceTypeRequest assetUId,
    @Header("service") service,
    @Header("x-visionlink-customeruid") customerId,
  );

  @POST('{url}')
  Future<AssetCreationResetData> submitAssetCreationData(
    @Path() String url,
    @Body() AssetCreationPayLoad assetCreationPayLoad,
  );

  @GET('{url}')
  Future<AssetCreationResetData> downloadAssetCreationData(
    @Path() String url,
  );

  @GET("{url}")
  Future<CheckUserResponse> checkUserVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET("{url}")
  Future<CheckUserResponse> checkUser(
    @Path() String url,
    @Header("service") service,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET("{url}")
  Future<NotificationsData> mainNotificationsData(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
    @Header("service") String service,
  );

  @GET("{url}")
  Future<NotificationsData> mainNotificationsDataVL(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );
  @GET('{url}')
  Future<AssetGroupSummaryResponse> getGroupListData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetCount> getGeoFenceCountData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<ManageGroupSummaryResponse> getManageGroupSummaryListData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<UpdateResponse> getGroupFavoriteData(
      @Path() String url,
      @Body() FavoritePayLoad groupFavoritePayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @DELETE('{url}')
  Future<UpdateResponse> getDeleteFavoriteData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @DELETE('{url}')
  Future<UpdateResponse> deleteNotification(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetGroupSummaryResponse> getAdminProductFamilyFilterData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<AssetGroupSummaryResponse> getManufacturerFilterData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<AddGroupDataResponse> getAddGroupSaveData(
      @Path() String url,
      @Body() AddGroupPayLoad addGroupPayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<EditGroupResponse> getEditGroupResponseData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<UpdateResponse> getAddGroupEditData(
      @Path() String url,
      @Body() EditGroupPayLoad addGroupEditPayload,
      @Header("x-visionlink-customeruid") customerId);

  @GET("{url}")
  Future<ManageNotificationsData> manageNotificationsData(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET("{url}")
  Future<AlertTypes> getNotificationTypesData(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );
  @POST("{url}")
  Future<dynamic> loginAudit(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") service,
      @Body() dynamic loginAuditPayload);
  @GET('{url}')
  Future<ManageReportResponse> getManageReportListDataVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<ManageReportDeleteAssetResponse> getDeleteManageReportAssetVL(
    @Path() String url,
    @Body() List<String> reqId,
    @Header("x-visionlink-customeruid") customerId,
  );
  @GET('{url}')
  Future<TemplateResponse> getTemplateReportAssetDataVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<TemplateResponse> getTemplateReportAssetData(
      @Path() String url,
      @Header("service") service,
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<SearchContactReportListResponse> getSearchContactReportDataVL(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<SearchContactReportListResponse> getSearchContactReportData(
      @Path() String url,
      @Header("service") service,
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<EditReportResponse> getEditReportData(
      @Path() String url, @Header("x-visionlink-customeruid") customerId);
  @POST('{url}')
  Future<ManageReportResponse> getAddReportSaveDataVL(
      @Path() String url,
      @Body() AddReportPayLoad addReportPayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @PUT('{url}')
  Future<ManageReportResponse> getEditReportSaveData(
      @Path() String url,
      @Body() AddReportPayLoad addReportPayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @POST('{url}')
  Future<ManageReportResponse> getAddReportSaveData(
      @Path() String url,
      @Body() AddReportPayLoad addReportPayLoad,
      @Header("x-visionlink-customeruid") customerId);

  @GET('{url}')
  Future<ManageReportResponse> getManageReportListData(
    @Path() String url,
    @Header('service') service,
    @Header("x-visionlink-customeruid") customerId,
    @Header('X-VisionLink-UserUid') userId,
  );

  @PUT('{url}')
  Future<ManageReportDeleteAssetResponse> getDeleteManageReportAsset(
    @Path() String url,
    @Body() List<String> reqId,
    @Header("service") service,
    @Header("x-visionlink-customeruid") customerId,
  );

  @PUT('{url}')
  Future<UpdateResponse> deleteMainNotification(
      @Path() String url,
      @Body() Map<String, dynamic> notifictionIds,
      @Header("x-visionlink-customeruid") customerId);

  @GET("{url}")
  Future<ZoneValues> getCustomerInclusionExclusion(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @GET("{url}")
  Future<NotificationExist> checkNotificationExist(
    @Path() String url,
    @Header("x-visionlink-customeruid") customerId,
  );

  @POST('{url}')
  Future<NotificationAdded> addNotificationSaveData(
      @Path() String url,
      @Body() AddNotificationPayLoad addNotificationPayLoad,
      @Header("x-visionlink-customeruid") customerId);
}

@JsonSerializable()
class Sample {
  bool? status;
  String? msg;
  bool? logout;
  Sample({this.status, this.logout, this.msg});

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);

  Map<String, dynamic> toJson() => _$SampleToJson(this);
}

// {
//   "email": "abdul_kareem@trimble.com",
//   "accountUserName": "abdul_kareem",
//   "uuid": "f40023ea-050e-47ad-9a39-40443e4ad3a2",
//   "lastPwdSetTimeStamp": "2020-09-26T06:22:55.602Z",
//   "lastLoginTimeStamp": "2021-03-30T20:18:40.958Z",
//   "lastUpdateTimeStamp": "2021-03-30T20:18:40.98Z",
//   "accountName": "trimble.com",
//   "sub": "abdul_kareem@trimble.com",
//   "firstname": "Abdulkareem",
//   "lastname": "AL",
//   "email_verified": "true"
// }

@JsonSerializable()
class UserInfo {
  String? email;
  String? accountUserName;
  String? uuid;
  String? lastPwdSetTimeStamp;
  String? lastLoginTimeStamp;
  String? lastUpdateTimeStamp;
  String? accountName;
  String? sub;
  String? firstname;
  String? lastname;
  dynamic email_verified;
  String? given_name;
  String? family_name;

  UserInfo(
      {this.email,
      this.family_name,
      this.given_name,
      this.accountUserName,
      this.uuid,
      this.lastPwdSetTimeStamp,
      this.lastLoginTimeStamp,
      this.lastUpdateTimeStamp,
      this.accountName,
      this.sub,
      this.firstname,
      this.lastname,
      this.email_verified});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class UserPayLoad {
  String? env;
  String? grant_type;
  String? code;
  String? redirect_uri;
  String? client_key;
  String? client_secret;
  String? tenantDomain;

  UserPayLoad(
      {this.env,
      this.grant_type,
      this.code,
      this.redirect_uri,
      this.client_key,
      this.client_secret,
      this.tenantDomain});

  factory UserPayLoad.fromJson(Map<String, dynamic> json) =>
      _$UserPayLoadFromJson(json);

  Map<String, dynamic> toJson() => _$UserPayLoadToJson(this);
}

@JsonSerializable()
class AuthenticationResponse {
  String? access_token;
  String? token_type;
  int? expires_in;
  AuthenticationResponse({this.access_token, this.token_type, this.expires_in});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class AuthenticatedUser {
  String? code;
  String? status;
  String? result;
  AuthenticatedUser({this.code, this.status, this.result});

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedUserToJson(this);
}

@JsonSerializable()
class AuthenticatePayload {
  String? env;
  String? grantType;
  String? code;
  String? redirectUri;
  String? client_key;
  String? clientSecret;
  String? tenantDomain;
  String? mobile;
  String? uuid;
  String? email;
  String codeverifier = randomAlphaNumeric(43);

  AuthenticatePayload({
    this.env = "THC",
    this.grantType = "authorization_code",
    this.code,
    this.redirectUri = "https://dev-oem.frame-oesolutions.com/auth",
    this.client_key = "130510bd-8a90-4278-b97a-d811df44ef10",
    this.clientSecret = "testSecret",
    this.tenantDomain = "trimble.com",
    this.mobile = "0000000000",
    this.uuid,
    this.email,
  });

  factory AuthenticatePayload.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatePayloadToJson(this);
}
