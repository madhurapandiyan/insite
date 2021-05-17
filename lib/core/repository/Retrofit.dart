import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_device.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/fuel_level.dart';
import 'package:insite/core/models/permission.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
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
  baseUrl: "https://unifiedfleet.myvisionlink.com",
)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/tasks")
  Future<List<Sample>> getTasks();

  @GET("/userinfo?schema=openid")
  Future<UserInfo> getUserInfo();

  @GET(
      "/t/trimble.com/authorization/1.0.0/users/organizations/{customerId}/permissions")
  Future<PermissionResponse> getPermission(
      @Query("limit") int limit,
      @Query("provider_id") String provider_id,
      @Path() String customerId,
      @Header("X-VisionLink-CustomerUid") xVisonLinkCustomerId);

  @GET("/t/trimble.com/vss-customerservice/1.0/accounthierarchy")
  Future<CustomersResponse> accountHierarchy(
      @Query("toplevelsonly") bool toplevelsonly);

  @GET("/t/trimble.com/vss-customerservice/1.0/accounthierarchy")
  Future<CustomersResponse> accountHierarchyChildren(
      @Query("targetcustomeruid") String targetcustomeruid);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2")
  Future<FleetSummaryResponse> fleetSummary(
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("sort") String sort,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET("/t/trimble.com/vss-assetutilization/1.1/AssetOperationDailyTotals")
  Future<AssetResponse> assetSummary(
      @Query("startdate") String startdate,
      @Query("enddate") String enddate,
      @Query("pagesize") int pagesize,
      @Query("pagenumber") int pagenumber,
      @Query("sort") String sort,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2")
  Future<FleetSummaryResponse> fleetSummaryCI(
      @Query("customerIdentifier") String customerIdentifier,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("sort") String sort,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET("/t/trimble.com/vss-assetutilization/1.1/AssetOperationDailyTotals")
  Future<AssetResponse> assetSummaryCI(
      @Query("customerUID") String customerUID,
      @Query("startdate") String startdate,
      @Query("enddate") String enddate,
      @Query("pagesize") int pagesize,
      @Query("pagenumber") int pagenumber,
      @Query("sort") String sort,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetDetails/v1")
  Future<AssetDetail> assetDetail(@Query("assetUID") String assetUID,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET("/t/trimble.com/vss-deviceservice/2.0/asset")
  Future<AssetDeviceResponse> asset(@Query("assetUID") String assetUID,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1")
  Future<SearchData> searchDetail(
      @Query("customerUID") String customerUID,
      @Query("snContains") String snContains,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET(
      "/t/trimble.com/vss-assethistory/1.0/AssetLocationHistory/64be6463-d8c1-11e7-80fc-065f15eda309/v2")
  Future<AssetLocationHistory> assetLocationHistoryDetail(
      @Query("endTimeLocal") String endTimeLocal,
      @Query("startTimeLocal") String startTimeLocal,
      @Header("X-VisionLink-CustomerUid") customerId);

  @GET(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/v1")
  Future<UtilizationSummaryResponse> utilLizationList(
      @Query("assetUid") String assetUID,
      @Query("startDate") String startDate,
      @Query("endDate") String endDate,
      @Header("x-visionlink-customeruid") customerId);

  @GET(
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/Aggregate/v1")
  Future<SingleAssetUtilization> singleAssetUtilization(
      @Query("assetUid") String assetUID,
      @Query("sort") String sort,
      @Query("endDate") String endDate,
      @Query("startDate") String startDate,
      @Header("x-visionlink-customeruid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization")
  Future<Utilization> utilization(
      @Query("startDate") String startDate,
      @Query("endDate") String endDate,
      @Query("pageNumber") int pageNumber,
      @Query("pageSize") int pageSize,
      @Query("sort") String sort,
      @Header("x-visionlink-customeruid") customerId);

  @GET("/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1")
  Future<AssetStatusData> assetStatus(@Query("grouping") String grouping,
      @Header("x-visionlink-customeruid") customerId);
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
  String email_verified;

  UserInfo(
      {this.email,
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
