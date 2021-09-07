import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_device.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/models/asset_location.dart' as location;
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/core/models/idling_level.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/models/single_asset_fault_response.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/models/token.dart';
import 'package:insite/core/models/total_fuel_burned.dart';
import 'package:insite/core/models/total_hours.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'Retrofit.g.dart';

// RUN THIS TO GENERATE FILES
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs

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

  @GET("/tasks")
  Future<List<Sample>> getTasks();

  @GET("/userinfo?schema=openid")
  Future<UserInfo> getUserInfo(@Header("content-type") String contentType,
      @Header("Authorization") String authorization);

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

  @GET('{url}')
  Future<CustomersResponse> accountHierarchy(
      @Path() String url,
      @Query("toplevelsonly") bool toplevelsonly,
      @Header("service") String serviceHeader);

  @GET('{url}')
  Future<CustomersResponse> accountHierarchyChildren(
      @Path() String url,
      @Query("targetcustomeruid") String targetcustomeruid,
      @Header("service") String serviceHeader);

  @GET('{url}')
  Future<FleetSummaryResponse> fleetSummaryURL(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetResponse> assetSummaryURL(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

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

  @GET('{url}')
  Future<location.AssetLocationData> assetLocationSummary(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetDetail> assetDetail(
      @Path() String url,
      @Query("assetUID") String assetUID,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

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
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @POST('{url}')
  Future<dynamic> postNotes(@Path() String url, @Body() PostNote postnote,
      @Header("service") serviceHeader);

  @POST("/npulse-masterdataapi-in/1.0/v1/ping")
  Future<dynamic> ping(@Body() PingPostDeviceData postnote);

  @GET("/npulse-masterdataapi-in/1.0/v1/ping")
  Future<PingDeviceData> getPingData(
      @Query("AssetUID") String assetUID, @Query("DeviceUID") String deviceUID);

  @GET("/t/trimble.com/vss-deviceservice/2.0/asset")
  Future<AssetDeviceResponse> asset(@Query("assetUID") String assetUID,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET('{url}')
  Future<SearchData> searchByAllWithCI(
      @Path() String url,
      @Query("snContains") String snContains,
      @Query("assetIDContains") String assetIDContains,
      @Query("customerUID") String customerUID,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SearchData> searchByIDWithCI(
      @Path() String url,
      @Query("assetIDContains") String assetIDContains,
      @Query("customerUID") String customerUID,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SearchData> searchBySNWithCI(
      @Path() String url,
      @Query("snContains") String snContains,
      @Query("customerUID") String customerUID,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SearchData> searchByAll(
      @Path() String url,
      @Query("assetIDContains") String assetIDContains,
      @Query("snContains") String snContains,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SearchData> searchByID(
      @Path() String url,
      @Query("assetIDContains") String assetIDContains,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<SearchData> searchBySN(
      @Path() String url,
      @Query("snContains") String snContains,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetLocationHistory> assetLocationHistory(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET("/npulse-utilization-in/1.0/api/v1/Utilization/Details")
  Future<UtilizationSummaryResponse> utilLizationList(
      @Query("assetUid")
          String assetUID,
      @Query("startDate")
          String startDate,
      @Query("endDate")
          String endDate,
      @Query("sort")
          String sort,
      @Header("x-visionlink-customeruid")
          customerId,
      @Query("includeNonReportedDays")
          bool includeNonReportedDays,
      @Query("includeOutsideLastReportedDay")
          bool includeOutsideLastReportedDay,
      @Header("service")
          serviceHeader);

  @GET("/npulse-utilization-in/1.0/api/v1/Utilization/Details/Aggregate")
  Future<SingleAssetUtilization> singleAssetUtilization(
      @Query("assetUid") String assetUID,
      @Query("sort") String sort,
      @Query("startDate") String startDate,
      @Query("endDate") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

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
  Future<AssetCount> assetCount(
      @Path() String url,
      @Query("grouping") String grouping,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> assetCountAll(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> assetCountcustomerUID(
      @Path() String url,
      @Query("grouping") String grouping,
      @Query("customerUID") String customerUID,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> assetCountAllcustomerUID(
      @Path() String url,
      @Query("customerUID") String customerUID,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> assetCountByFilter(
      @Path() String url,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<location.AssetLocationData> assetLocationWithOutFilter(
      @Path() String url,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("sort") String sort,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<location.AssetLocationData> assetLocationWithOutFilterCustomerUID(
      @Path() String url,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("sort") String sort,
      @Query("customerIdentifier") String customerIdentifier,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> fuelLevel(
      @Path() String url,
      @Query("grouping") String grouping,
      @Query("thresholds") String thresholds,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> fuelLevelCustomerUID(
      @Path() String url,
      @Query("grouping") String grouping,
      @Query("thresholds") String thresholds,
      @Query("customerUID") String customerUID,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetUtilization> assetUtilGraphData(
      @Path() String url,
      @Query("assetUid") String assetUID,
      @Query("date") String date,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> idlingLevel(
      @Path() String url,
      @Query("startDate") String startDate,
      @Query("idleEfficiencyRanges") String idleEfficiencyRanges,
      @Query("endDate") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetCount> idlingLevelCustomerUID(
      @Path() String url,
      @Query("startDate") String startDate,
      @Query("idleEfficiencyRanges") String idleEfficiencyRanges,
      @Query("endDate") String endDate,
      @Query("customerUID") String customerUID,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET("/t/trimble.com/vss-notification/1.0/Notification/Count")
  Future<IdlingLevelData> notificationData(
    @Query("notificationStatus") int status,
    @Query("notificationUserStatus") int userStatus,
  );

  @GET("/npulse-utilization-in/1.0/assetoperationsegments")
  Future<SingleAssetOperation> singleAssetOperation(
      @Query("startDate") String startDate,
      @Query("endDate") String endDate,
      @Query("assetUid") String assetUID,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/hours/cumulatives")
  Future<RunTimeCumulative> runtimeCumulative(
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/fuelburned/cumulatives")
  Future<FuelBurnedCumulative> fuelBurnedCumulative(
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/hours/cumulatives/intervals")
  Future<TotalHours> getTotalHours(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST(
      "/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/fuelburned/cumulatives/intervals")
  Future<TotalFuelBurned> getTotalFuelBurned(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST("/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/idlepercent")
  Future<IdlePercentTrend> getIdlePercentTrend(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @POST("/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/fuelburnrate")
  Future<FuelBurnRateTrend> getFuelBurnRateTrend(
      @Query("interval") String interval,
      @Query("startdatelocal") String startDate,
      @Query("enddatelocal") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("includepagination") bool includepagination,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET("/ww/api/search")
  Future<LocationSearchResponse> getLocations(
      @Query("query") String query,
      @Query("maxResults") int maxResults,
      @Query("authToken") String authToken);

  @GET('{url}')
  Future<UtilizationSummary> getAssetUtilization(
      @Path() String url,
      @Query("date") String date,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<UtilizationSummary> getAssetUtilizationcustomerUID(
      @Path() String url,
      @Query("date") String date,
      @Query("customerUID") String customerUID,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

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

  @POST('{url}')
  Future<FaultSummaryResponse> faultViewSummaryURL(
      @Path() String url,
      @Body() dynamic fitlers,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @POST('{url}')
  Future<AssetFaultSummaryResponse> assetViewSummaryURL(
      @Path() String url,
      @Body() dynamic fitlers,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<FaultSummaryResponse> assetViewDetailSummaryURL(
      @Path() String url,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<HealthListResponse> assetViewLocationSummaryURL(
      @Path() String url,
      @Query("assetUid") String assetUid,
      @Header("X-VisionLink-CustomerUid") customerId,
      @Header("service") serviceHeader);

  @GET("/npulse-unifiedservice-in/1.0/health/FaultDetails/v1")
  Future<HealthListResponse> getHealthListData(
      @Query("assetUid") String assetUid,
      @Query("endDateTime") String endDateTime,
      @Query("langDesc") String langDesc,
      @Query("limit") int limit,
      @Query("page") int page,
      @Query("startDateTime") String startDateTime,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET("/npulse-unifiedservice-in/1.0/health/faultSummary/v1")
  Future<SingleAssetFaultResponse> getDashboardListData(
      @Query("assetUid") String assetUid,
      @Query("endDateTime") String endDate,
      @Query("startDateTime") String startDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") serviceHeader);

  @GET('{url}')
  Future<AssetCount> faultCountcustomerUID(
      @Path() String url,
      @Query("startDateTime") String startDate,
      @Query("endDateTime") String endDate,
      @Query("customerUid") String customerUid,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> faultCount(
      @Path() String url,
      @Query("startDateTime") String startDate,
      @Query("endDateTime") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> assetStatusFilterData(
      @Path() String url,
      @Query("grouping") String grouping,
      @Query("productfamily") String productfamily,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> fuelLevelFilterData(
      @Path() String url,
      @Query("grouping") String grouping,
      @Query("productfamily") String productfamily,
      @Query("thresholds") String thresholds,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetCount> idlingLevelFilterData(
      @Path() String url,
      @Query("startDate") String startDate,
      @Query("idleEfficiencyRanges") String idleEfficiencyRanges,
      @Query("productfamily") String productfamily,
      @Query("endDate") String endDate,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<UtilizationSummary> utilizationSummaryFilterData(
      @Path() String url,
      @Query("date") String endDate,
      @Query("productfamily") String productfamily,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);

  @GET('{url}')
  Future<AssetLocationData> locationFilterData(
      @Path() String url,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("productfamily") String productfamily,
      @Query("sort") String sort,
      @Header("x-visionlink-customeruid") customerId,
      @Header("service") service);
}

@JsonSerializable()
class Sample {
  bool status;
  String msg;
  bool logout;
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
  String email;
  String accountUserName;
  String uuid;
  String lastPwdSetTimeStamp;
  String lastLoginTimeStamp;
  String lastUpdateTimeStamp;
  String accountName;
  String sub;
  String firstname;
  String lastname;
  bool email_verified;
  String given_name;
  String family_name;

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
  String env;
  String grant_type;
  String code;
  String redirect_uri;
  String client_key;
  String client_secret;
  String tenantDomain;

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
  String access_token;
  String token_type;
  int expires_in;
  AuthenticationResponse({this.access_token, this.token_type, this.expires_in});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
