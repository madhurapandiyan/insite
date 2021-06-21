// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Retrofit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sample _$SampleFromJson(Map<String, dynamic> json) {
  return Sample(
    status: json['status'] as bool,
    logout: json['logout'] as bool,
    msg: json['msg'] as String,
  );
}

Map<String, dynamic> _$SampleToJson(Sample instance) => <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'logout': instance.logout,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    email: json['email'] as String,
    accountUserName: json['accountUserName'] as String,
    uuid: json['uuid'] as String,
    lastPwdSetTimeStamp: json['lastPwdSetTimeStamp'] as String,
    lastLoginTimeStamp: json['lastLoginTimeStamp'] as String,
    lastUpdateTimeStamp: json['lastUpdateTimeStamp'] as String,
    accountName: json['accountName'] as String,
    sub: json['sub'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    email_verified: json['email_verified'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'email': instance.email,
      'accountUserName': instance.accountUserName,
      'uuid': instance.uuid,
      'lastPwdSetTimeStamp': instance.lastPwdSetTimeStamp,
      'lastLoginTimeStamp': instance.lastLoginTimeStamp,
      'lastUpdateTimeStamp': instance.lastUpdateTimeStamp,
      'accountName': instance.accountName,
      'sub': instance.sub,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email_verified': instance.email_verified,
    };

UserPayLoad _$UserPayLoadFromJson(Map<String, dynamic> json) {
  return UserPayLoad(
    env: json['env'] as String,
    grant_type: json['grant_type'] as String,
    code: json['code'] as String,
    redirect_uri: json['redirect_uri'] as String,
    client_key: json['client_key'] as String,
    client_secret: json['client_secret'] as String,
    tenantDomain: json['tenantDomain'] as String,
  );
}

Map<String, dynamic> _$UserPayLoadToJson(UserPayLoad instance) =>
    <String, dynamic>{
      'env': instance.env,
      'grant_type': instance.grant_type,
      'code': instance.code,
      'redirect_uri': instance.redirect_uri,
      'client_key': instance.client_key,
      'client_secret': instance.client_secret,
      'tenantDomain': instance.tenantDomain,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
    Map<String, dynamic> json) {
  return AuthenticationResponse(
    access_token: json['access_token'] as String,
    token_type: json['token_type'] as String,
    expires_in: json['expires_in'] as int,
  );
}

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://unifiedfleet.myvisionlink.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Sample>> getTasks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/tasks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Sample.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<UserInfo> getUserInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/userinfo?schema=openid',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserInfo.fromJson(_result.data);
    return value;
  }

  @override
  Future<PermissionResponse> getPermission(
      limit, provider_id, customerId, xVisonLinkCustomerId) async {
    ArgumentError.checkNotNull(limit, 'limit');
    ArgumentError.checkNotNull(provider_id, 'provider_id');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(xVisonLinkCustomerId, 'xVisonLinkCustomerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'provider_id': provider_id
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/authorization/1.0.0/users/organizations/$customerId/permissions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': xVisonLinkCustomerId
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PermissionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchy(toplevelsonly) async {
    ArgumentError.checkNotNull(toplevelsonly, 'toplevelsonly');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'toplevelsonly': toplevelsonly};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-customerservice/1.0/accounthierarchy',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomersResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchyChildren(targetcustomeruid) async {
    ArgumentError.checkNotNull(targetcustomeruid, 'targetcustomeruid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'targetcustomeruid': targetcustomeruid
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-customerservice/1.0/accounthierarchy',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomersResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FleetSummaryResponse> fleetSummary(queries, customerId) async {
    ArgumentError.checkNotNull(queries, 'queries');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FleetSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FleetSummaryResponse> fleetSummaryURL(url, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FleetSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetResponse> assetSummaryURL(url, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetResponse> assetSummary(queries, customerId) async {
    ArgumentError.checkNotNull(queries, 'queries');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-assetutilization/1.1/AssetOperationDailyTotals',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocation(queries, customerId) async {
    ArgumentError.checkNotNull(queries, 'queries');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleetmap/1.0/location/maps/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationSummary(url, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetDetail> assetDetail(assetUID, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetDetails/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetDetail.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetDetail> assetDetailCI(assetUID, customerUID, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUID': assetUID,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetDetails/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetDetail.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Note>> getAssetNotes(assetUID, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/t/trimble.com/VSS-AssetMetadata/1.0/AssetMetadata/Notes/v1/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Note.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<dynamic> postNotes(postnote) async {
    ArgumentError.checkNotNull(postnote, 'postnote');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postnote?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request(
        '/t/trimble.com/VSS-AssetMetadata/1.0/AssetMetadata/Notes/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> ping(postnote) async {
    ArgumentError.checkNotNull(postnote, 'postnote');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postnote?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request(
        '/t/trimble.com/vss-deviceservice/1.0/ping',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<PingDeviceData> getPingData(assetUID, deviceUID) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(deviceUID, 'deviceUID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'AssetUID': assetUID,
      r'DeviceUID': deviceUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-deviceservice/1.0/ping',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PingDeviceData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetDeviceResponse> asset(assetUID, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-deviceservice/2.0/asset',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetDeviceResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByAllWithCI(
      snContains, assetIDContains, customerUID, customerId) async {
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'snContains': snContains,
      r'assetIDContains': assetIDContains,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByIDWithCI(
      assetIDContains, customerUID, customerId) async {
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetIDContains': assetIDContains,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchBySNWithCI(
      snContains, customerUID, customerId) async {
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'snContains': snContains,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByAll(
      assetIDContains, snContains, customerId) async {
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetIDContains': assetIDContains,
      r'snContains': snContains
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByID(assetIDContains, customerId) async {
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetIDContains': assetIDContains
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchBySN(snContains, customerId) async {
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'snContains': snContains};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationHistory> assetLocationHistoryDetail(
      endTimeLocal, startTimeLocal, customerId) async {
    ArgumentError.checkNotNull(endTimeLocal, 'endTimeLocal');
    ArgumentError.checkNotNull(startTimeLocal, 'startTimeLocal');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'endTimeLocal': endTimeLocal,
      r'startTimeLocal': startTimeLocal
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-assethistory/1.0/AssetLocationHistory/64be6463-d8c1-11e7-80fc-065f15eda309/v2',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationHistory.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummaryResponse> utilLizationList(
      assetUID, startDate, endDate, sort, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'startDate': startDate,
      r'endDate': endDate,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetUtilization> singleAssetUtilization(
      assetUID, sort, startDate, endDate, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'sort': sort,
      r'startDate': startDate,
      r'endDate': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/Aggregate/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<Utilization> utilization(
      startDate, endDate, pageNumber, pageSize, sort, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'endDate': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Utilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<Utilization> utilizationCustomer(startDate, endDate, pageNumber,
      pageSize, sort, customerUID, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'endDate': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Utilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCountData> assetCount(grouping, customerId) async {
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'grouping': grouping};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCountData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationWithOutFilter(
      pageNumber, pageSize, sort, customerId) async {
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleetmap/1.0/location/maps/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCountData> fuelLevel(grouping, thresholds, customerId) async {
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(thresholds, 'thresholds');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'thresholds': thresholds
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCountData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetUtilization> assetUtilGraphData(
      assetUID, date, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'date': date
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/Summary/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCountData> idlingLevel(
      startDate, idleEfficiencyRanges, endDate, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(idleEfficiencyRanges, 'idleEfficiencyRanges');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'endDate': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCountData.fromJson(_result.data);
    return value;
  }

  @override
  Future<IdlingLevelData> notificationData(status, userStatus) async {
    ArgumentError.checkNotNull(status, 'status');
    ArgumentError.checkNotNull(userStatus, 'userStatus');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'notificationStatus': status,
      r'notificationUserStatus': userStatus
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-notification/1.0/Notification/Count',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = IdlingLevelData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetOperation> singleAssetOperation(
      startDate, endDate, assetUID, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'endDate': endDate,
      r'assetUid': assetUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-assetutilization/1.1/assetoperationsegments',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetOperation.fromJson(_result.data);
    return value;
  }

  @override
  Future<RunTimeCumulative> runtimeCumulative(
      startDate, endDate, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdatelocal': startDate,
      r'enddatelocal': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/hours/cumulatives',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RunTimeCumulative.fromJson(_result.data);
    return value;
  }

  @override
  Future<FuelBurnedCumulative> fuelBurnedCumulative(
      startDate, endDate, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdatelocal': startDate,
      r'enddatelocal': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburned/cumulatives',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FuelBurnedCumulative.fromJson(_result.data);
    return value;
  }

  @override
  Future<TotalHours> getTotalHours(interval, startDate, endDate, pageNumber,
      pageSize, includepagination, customerId) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/hours/cumulatives/intervals',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TotalHours.fromJson(_result.data);
    return value;
  }

  @override
  Future<TotalFuelBurned> getTotalFuelBurned(interval, startDate, endDate,
      pageNumber, pageSize, includepagination, customerId) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburned/cumulatives/intervals',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TotalFuelBurned.fromJson(_result.data);
    return value;
  }

  @override
  Future<IdlePercentTrend> getIdlePercentTrend(interval, startDate, endDate,
      pageNumber, pageSize, includepagination, customerId) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/idlepercent',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = IdlePercentTrend.fromJson(_result.data);
    return value;
  }

  @override
  Future<FuelBurnRateTrend> getFuelBurnRateTrend(interval, startDate, endDate,
      pageNumber, pageSize, includepagination, customerId) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburnrate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FuelBurnRateTrend.fromJson(_result.data);
    return value;
  }

  @override
  Future<LocationSearchResponse> getLocations(
      query, maxResults, authToken) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(maxResults, 'maxResults');
    ArgumentError.checkNotNull(authToken, 'authToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'maxResults': maxResults,
      r'authToken': authToken
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/ww/api/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LocationSearchResponse.fromJson(_result.data);
    return value;
  }
}
