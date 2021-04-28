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
  Future<FleetSummaryResponse> fleetSummary(
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
  Future<AssetResponse> assetSummary(
      startdate, enddate, pagesize, pagenumber, sort, customerId) async {
    ArgumentError.checkNotNull(startdate, 'startdate');
    ArgumentError.checkNotNull(enddate, 'enddate');
    ArgumentError.checkNotNull(pagesize, 'pagesize');
    ArgumentError.checkNotNull(pagenumber, 'pagenumber');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdate': startdate,
      r'enddate': enddate,
      r'pagesize': pagesize,
      r'pagenumber': pagenumber,
      r'sort': sort
    };
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
  Future<FleetSummaryResponse> fleetSummaryCI(
      customerIdentifier, pageNumber, pageSize, sort, customerId) async {
    ArgumentError.checkNotNull(customerIdentifier, 'customerIdentifier');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'customerIdentifier': customerIdentifier,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort
    };
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
  Future<AssetResponse> assetSummaryCI(customerUID, startdate, enddate,
      pagesize, pagenumber, sort, customerId) async {
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(startdate, 'startdate');
    ArgumentError.checkNotNull(enddate, 'enddate');
    ArgumentError.checkNotNull(pagesize, 'pagesize');
    ArgumentError.checkNotNull(pagenumber, 'pagenumber');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'customerUID': customerUID,
      r'startdate': startdate,
      r'enddate': enddate,
      r'pagesize': pagesize,
      r'pagenumber': pagenumber,
      r'sort': sort
    };
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
  Future<SearchData> searchDetail(customerUID, snContains, customerId) async {
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'customerUID': customerUID,
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
      assetUID, startDate, endDate, customerId) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'startDate': startDate,
      r'endDate': endDate
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
}
