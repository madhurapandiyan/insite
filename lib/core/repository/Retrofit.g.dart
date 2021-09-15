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
    family_name: json['family_name'] as String,
    given_name: json['given_name'] as String,
    accountUserName: json['accountUserName'] as String,
    uuid: json['uuid'] as String,
    lastPwdSetTimeStamp: json['lastPwdSetTimeStamp'] as String,
    lastLoginTimeStamp: json['lastLoginTimeStamp'] as String,
    lastUpdateTimeStamp: json['lastUpdateTimeStamp'] as String,
    accountName: json['accountName'] as String,
    sub: json['sub'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    email_verified: json['email_verified'] as bool,
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
      'given_name': instance.given_name,
      'family_name': instance.family_name,
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
    baseUrl ??= 'https://cloud.api.trimble.com/CTSPulseIndiastg';
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
  Future<UserInfo> getUserInfo(contentType, authorization) async {
    ArgumentError.checkNotNull(contentType, 'contentType');
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/userinfo?schema=openid',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'content-type': contentType,
              r'Authorization': authorization
            },
            extra: _extra,
            contentType: contentType,
            baseUrl: baseUrl),
        data: _data);
    final value = UserInfo.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserInfo> getUserInfoV4(
      contentType, authorization, accessToken) async {
    ArgumentError.checkNotNull(contentType, 'contentType');
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(accessToken?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/oauth/userinfo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'content-type': contentType,
              r'Authorization': authorization
            },
            extra: _extra,
            contentType: contentType,
            baseUrl: baseUrl),
        data: _data);
    final value = UserInfo.fromJson(_result.data);
    return value;
  }

  @override
  Future<PermissionResponse> getPermission(
      limit, provider_id, xVisonLinkCustomerId, customerId, user_guid) async {
    ArgumentError.checkNotNull(limit, 'limit');
    ArgumentError.checkNotNull(provider_id, 'provider_id');
    ArgumentError.checkNotNull(xVisonLinkCustomerId, 'xVisonLinkCustomerId');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(user_guid, 'user_guid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'provider_id': provider_id
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/authorization/1.0.0/users/$user_guid/organizations/$customerId/permissions',
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
  Future<PermissionResponse> getPermissionVL(
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
  Future<CustomersResponse> accountHierarchy(
      url, toplevelsonly, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(toplevelsonly, 'toplevelsonly');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'toplevelsonly': toplevelsonly};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'service': serviceHeader},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomersResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchyVL(toplevelsonly) async {
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
  Future<CustomersResponse> accountHierarchyChildren(
      url, targetcustomeruid, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(targetcustomeruid, 'targetcustomeruid');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'targetcustomeruid': targetcustomeruid
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'service': serviceHeader},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomersResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchyChildrenVL(
      targetcustomeruid) async {
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
  Future<FleetSummaryResponse> fleetSummaryURL(
      url, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FleetSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FleetSummaryResponse> fleetSummaryURLVL(url, customerId) async {
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
  Future<AssetResponse> assetSummaryURL(url, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetResponse> assetSummaryURLVL(url, customerId) async {
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
  Future<AssetLocationData> assetLocationWithCluster(url, latitude, longitude,
      pageNumber, pageSize, radiusKm, sort, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(radiusKm, 'radiusKm');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'latitude': latitude,
      r'longitude': longitude,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'radiuskm': radiusKm,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
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
  Future<AssetLocationData> assetLocationWithClusterVL(latitude, longitude,
      pageNumber, pageSize, radiusKm, sort, customerId) async {
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(radiusKm, 'radiusKm');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'latitude': latitude,
      r'longitude': longitude,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'radiuskm': radiusKm,
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
  Future<AssetLocationData> assetLocationSummary(
      url, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationSummaryVL(url, customerId) async {
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
  Future<AssetDetail> assetDetail(
      url, assetUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetDetail.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetDetail> assetDetailVL(assetUID, customerId) async {
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
  Future<AssetDetail> assetDetailCI(
      url, assetUID, customerUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUID': assetUID,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetDetail.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Note>> getAssetNotes(
      url, assetUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Note.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Note>> getAssetNotesVL(assetUID, customerId) async {
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
  Future<dynamic> postNotes(url, postnote, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(postnote, 'postnote');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postnote?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'service': serviceHeader},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postNotesVL(postnote) async {
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
    final _result = await _dio.request('/npulse-masterdataapi-in/1.0/v1/ping',
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
        '/npulse-masterdataapi-in/1.0/v1/ping',
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
  Future<SearchData> searchByAllWithCI(url, snContains, assetIDContains,
      customerUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'snContains': snContains,
      r'assetIDContains': assetIDContains,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByIDWithCI(
      url, assetIDContains, customerUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetIDContains': assetIDContains,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchBySNWithCI(
      url, snContains, customerUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'snContains': snContains,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByAll(
      url, assetIDContains, snContains, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetIDContains': assetIDContains,
      r'snContains': snContains
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchByID(
      url, assetIDContains, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetIDContains, 'assetIDContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetIDContains': assetIDContains
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchBySN(
      url, snContains, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(snContains, 'snContains');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'snContains': snContains};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationHistory> assetLocationHistory(
      url, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationHistory.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationHistory> assetLocationHistoryVL(url, customerId) async {
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
    final value = AssetLocationHistory.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummaryResponse> utilLizationList(
      assetUID,
      startDate,
      endDate,
      sort,
      customerId,
      includeNonReportedDays,
      includeOutsideLastReportedDay,
      serviceHeader) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(
        includeNonReportedDays, 'includeNonReportedDays');
    ArgumentError.checkNotNull(
        includeOutsideLastReportedDay, 'includeOutsideLastReportedDay');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'startDate': startDate,
      r'endDate': endDate,
      r'sort': sort,
      r'includeNonReportedDays': includeNonReportedDays,
      r'includeOutsideLastReportedDay': includeOutsideLastReportedDay
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-utilization-in/1.0/api/v1/Utilization/Details',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummaryResponse> utilLizationListVL(
      assetUID,
      startDate,
      endDate,
      sort,
      customerId,
      includeNonReportedDays,
      includeOutsideLastReportedDay) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(
        includeNonReportedDays, 'includeNonReportedDays');
    ArgumentError.checkNotNull(
        includeOutsideLastReportedDay, 'includeOutsideLastReportedDay');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'startDate': startDate,
      r'endDate': endDate,
      r'sort': sort,
      r'includeNonReportedDays': includeNonReportedDays,
      r'includeOutsideLastReportedDay': includeOutsideLastReportedDay
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
      assetUID, sort, startDate, endDate, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'sort': sort,
      r'startDate': startDate,
      r'endDate': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-utilization-in/1.0/api/v1/Utilization/Details/Aggregate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetUtilization> singleAssetUtilizationVL(
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
  Future<SingleAssetUtilization> singleAssetUtilizationGraph(
      assetUID, startDate, endDate) async {
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'AssetUid': assetUID,
      r'startDate': startDate,
      r'endDate': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-utilization-in/1.0/api/v1/Utilization/Details/Aggregate/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<Utilization> utilization(url, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Utilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<Utilization> utilizationVL(url, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
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
  Future<AssetCount> assetCount(url, grouping, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'grouping': grouping};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountAll(url, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountcustomerUID(
      url, grouping, customerUID, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountVL(grouping, customerId) async {
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountAllVL(customerId) async {
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountAllcustomerUID(
      url, customerUID, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'customerUID': customerUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountcustomerUIDVL(
      grouping, customerUID, customerId) async {
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'customerUID': customerUID
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountAllcustomerUIDVL(customerUID, customerId) async {
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'customerUID': customerUID};
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountByFilter(url, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetCountByFilterVL(url, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationWithOutFilter(
      url, pageNumber, pageSize, sort, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationWithOutFilterVL(
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
  Future<AssetLocationData> assetLocationWithOutFilterCustomerUID(
      url,
      pageNumber,
      pageSize,
      sort,
      customerIdentifier,
      customerId,
      service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerIdentifier, 'customerIdentifier');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort,
      r'customerIdentifier': customerIdentifier
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationWithOutFilterCustomerUIDVL(
      pageNumber, pageSize, sort, customerIdentifier, customerId) async {
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerIdentifier, 'customerIdentifier');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'sort': sort,
      r'customerIdentifier': customerIdentifier
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
  Future<AssetCount> fuelLevel(
      url, grouping, thresholds, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(thresholds, 'thresholds');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'thresholds': thresholds
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> fuelLevelVL(grouping, thresholds, customerId) async {
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> fuelLevelCustomerUID(
      url, grouping, thresholds, customerUID, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(thresholds, 'thresholds');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'thresholds': thresholds,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> fuelLevelCustomerUIDVL(
      grouping, thresholds, customerUID, customerId) async {
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(thresholds, 'thresholds');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'thresholds': thresholds,
      r'customerUID': customerUID
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetUtilization> assetUtilGraphData(
      url, assetUID, date, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUID,
      r'date': date
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetUtilization> assetUtilGraphDataVL(
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
  Future<AssetCount> idlingLevel(url, startDate, idleEfficiencyRanges, endDate,
      customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(idleEfficiencyRanges, 'idleEfficiencyRanges');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'endDate': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelCustomerUID(
      url,
      startDate,
      idleEfficiencyRanges,
      endDate,
      customerUID,
      customerId,
      serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(idleEfficiencyRanges, 'idleEfficiencyRanges');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'endDate': endDate,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelVL(
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelCustomerUIDVL(
      startDate, idleEfficiencyRanges, endDate, customerUID, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(idleEfficiencyRanges, 'idleEfficiencyRanges');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'endDate': endDate,
      r'customerUID': customerUID
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
    final value = AssetCount.fromJson(_result.data);
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
      startDate, endDate, assetUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'endDate': endDate,
      r'assetUid': assetUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-utilization-in/1.0/assetoperationsegments',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetOperation.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetOperation> singleAssetOperationVL(
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
      startDate, endDate, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdatelocal': startDate,
      r'enddatelocal': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/hours/cumulatives',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RunTimeCumulative.fromJson(_result.data);
    return value;
  }

  @override
  Future<RunTimeCumulative> runtimeCumulativeVL(
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
      startDate, endDate, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdatelocal': startDate,
      r'enddatelocal': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/fuelburned/cumulatives',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FuelBurnedCumulative.fromJson(_result.data);
    return value;
  }

  @override
  Future<FuelBurnedCumulative> fuelBurnedCumulativeVL(
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
      pageSize, includepagination, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
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
        '/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/hours/cumulatives/intervals',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TotalHours.fromJson(_result.data);
    return value;
  }

  @override
  Future<TotalHours> getTotalHoursVL(interval, startDate, endDate, pageNumber,
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
  Future<TotalFuelBurned> getTotalFuelBurned(
      interval,
      startDate,
      endDate,
      pageNumber,
      pageSize,
      includepagination,
      customerId,
      serviceHeader) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
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
        '/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/fuelburned/cumulatives/intervals',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TotalFuelBurned.fromJson(_result.data);
    return value;
  }

  @override
  Future<TotalFuelBurned> getTotalFuelBurnedVL(interval, startDate, endDate,
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
  Future<IdlePercentTrend> getIdlePercentTrend(
      interval,
      startDate,
      endDate,
      pageNumber,
      pageSize,
      includepagination,
      customerId,
      serviceHeader) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
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
        '/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/idlepercent',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = IdlePercentTrend.fromJson(_result.data);
    return value;
  }

  @override
  Future<IdlePercentTrend> getIdlePercentTrendVL(interval, startDate, endDate,
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
  Future<FuelBurnRateTrend> getFuelBurnRateTrend(
      interval,
      startDate,
      endDate,
      pageNumber,
      pageSize,
      includepagination,
      customerId,
      serviceHeader) async {
    ArgumentError.checkNotNull(interval, 'interval');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(includepagination, 'includepagination');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
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
        '/npulse-fleet-in/1.0/api/v2/UtilizationGraphs/summary/fuelburnrate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FuelBurnRateTrend.fromJson(_result.data);
    return value;
  }

  @override
  Future<FuelBurnRateTrend> getFuelBurnRateTrendVL(interval, startDate, endDate,
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

  @override
  Future<UtilizationSummary> getAssetUtilization(
      url, date, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilizationcustomerUID(
      url, date, customerUID, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'date': date,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
<<<<<<< HEAD
  Future<LoginResponse> getToken(username, password, granttype, clientid,
=======
  Future<UtilizationSummary> getAssetUtilizationVL(date, customerId) async {
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Summary/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilizationcustomerUIDVL(
      date, customerUID, customerId) async {
    ArgumentError.checkNotNull(date, 'date');
    ArgumentError.checkNotNull(customerUID, 'customerUID');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'date': date,
      r'customerUID': customerUID
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Summary/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResponse> getLoginData(username, password, granttype, clientid,
>>>>>>> d7ef7e1214ca5daedee4ba91741c4db6c21110b6
      clientsecret, scope, contentType) async {
    ArgumentError.checkNotNull(username, 'username');
    ArgumentError.checkNotNull(password, 'password');
    ArgumentError.checkNotNull(granttype, 'granttype');
    ArgumentError.checkNotNull(clientid, 'clientid');
    ArgumentError.checkNotNull(clientsecret, 'clientsecret');
    ArgumentError.checkNotNull(scope, 'scope');
    ArgumentError.checkNotNull(contentType, 'contentType');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'username': username,
      r'password': password,
      r'grant_type': granttype,
      r'client_id': clientid,
      r'client_secret': clientsecret,
      r'scope': scope
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/token',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'content-type': contentType},
            extra: _extra,
            contentType: contentType,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FaultSummaryResponse> faultViewSummaryURL(
      url, fitlers, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(fitlers, 'fitlers');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = fitlers;
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FaultSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FaultSummaryResponse> faultViewSummaryURLVL(
      url, fitlers, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(fitlers, 'fitlers');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = fitlers;
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FaultSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResponse> getTokenV4(tokenData, contentType) async {
    ArgumentError.checkNotNull(tokenData, 'tokenData');
    ArgumentError.checkNotNull(contentType, 'contentType');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(tokenData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/oauth/token',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'content-type': contentType},
            extra: _extra,
            contentType: contentType,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetFaultSummaryResponse> assetViewSummaryURL(
      url, fitlers, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(fitlers, 'fitlers');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = fitlers;
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetFaultSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetFaultSummaryResponse> assetViewSummaryURLVL(
      url, fitlers, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(fitlers, 'fitlers');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = fitlers;
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetFaultSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FaultSummaryResponse> assetViewDetailSummaryURL(
      url, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FaultSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<FaultSummaryResponse> assetViewDetailSummaryURLVL(
      url, customerId) async {
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
    final value = FaultSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HealthListResponse> assetViewLocationSummaryURL(
      url, assetUid, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUid': assetUid};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'X-VisionLink-CustomerUid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HealthListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HealthListResponse> assetViewLocationSummaryURLVL(
      url, assetUid, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUid': assetUid};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-VisionLink-CustomerUid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HealthListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HealthListResponse> getHealthListData(assetUid, endDateTime, langDesc,
      limit, page, startDateTime, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(endDateTime, 'endDateTime');
    ArgumentError.checkNotNull(langDesc, 'langDesc');
    ArgumentError.checkNotNull(limit, 'limit');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(startDateTime, 'startDateTime');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUid,
      r'endDateTime': endDateTime,
      r'langDesc': langDesc,
      r'limit': limit,
      r'page': page,
      r'startDateTime': startDateTime
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-unifiedservice-in/1.0/health/FaultDetails/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HealthListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HealthListResponse> getHealthListDataVL(assetUid, endDateTime,
      langDesc, limit, page, startDateTime, customerId) async {
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(endDateTime, 'endDateTime');
    ArgumentError.checkNotNull(langDesc, 'langDesc');
    ArgumentError.checkNotNull(limit, 'limit');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(startDateTime, 'startDateTime');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUid,
      r'endDateTime': endDateTime,
      r'langDesc': langDesc,
      r'limit': limit,
      r'page': page,
      r'startDateTime': startDateTime
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-service/1.0/health/FaultDetails/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HealthListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetFaultResponse> getDashboardListData(
      assetUid, endDate, startDate, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUid,
      r'endDateTime': endDate,
      r'startDateTime': startDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/npulse-unifiedservice-in/1.0/health/faultSummary/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetFaultResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetFaultResponse> getDashboardListDataVL(
      assetUid, endDate, startDate, customerId) async {
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUid,
      r'endDateTime': endDate,
      r'startDateTime': startDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/t/trimble.com/vss-service/1.0/health/faultSummary/v1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetFaultResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> faultCountcustomerUID(
      url, startDate, endDate, customerUid, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerUid, 'customerUid');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDateTime': startDate,
      r'endDateTime': endDate,
      r'customerUid': customerUid
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> faultCount(
      url, startDate, endDate, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDateTime': startDate,
      r'endDateTime': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> faultCountcustomerUIDVL(
      url, startDate, endDate, customerUid, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerUid, 'customerUid');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDateTime': startDate,
      r'endDateTime': endDate,
      r'customerUid': customerUid
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> faultCountVL(url, startDate, endDate, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDateTime': startDate,
      r'endDateTime': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetStatusFilterData(
      url, grouping, productfamily, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'productfamily': productfamily
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> assetStatusFilterDataVL(
      grouping, productfamily, customerId) async {
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'productfamily': productfamily
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> fuelLevelFilterData(
      url, grouping, productfamily, thresholds, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(thresholds, 'thresholds');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'productfamily': productfamily,
      r'thresholds': thresholds
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> fuelLevelFilterDataVL(
      grouping, productfamily, thresholds, customerId) async {
    ArgumentError.checkNotNull(grouping, 'grouping');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(thresholds, 'thresholds');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'productfamily': productfamily,
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelFilterData(url, startDate, idleEfficiencyRanges,
      productfamily, endDate, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(idleEfficiencyRanges, 'idleEfficiencyRanges');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'productfamily': productfamily,
      r'endDate': endDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelFilterDataVL(startDate, idleEfficiencyRanges,
      productfamily, endDate, customerId) async {
    ArgumentError.checkNotNull(startDate, 'startDate');
    ArgumentError.checkNotNull(idleEfficiencyRanges, 'idleEfficiencyRanges');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'productfamily': productfamily,
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
    final value = AssetCount.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummary> utilizationSummaryFilterData(
      url, endDate, productfamily, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(endDate, 'endDate');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'date': endDate,
      r'productfamily': productfamily
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> locationFilterData(url, pageNumber, pageSize,
      productfamily, sort, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'productfamily': productfamily,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> locationFilterDataVL(
      pageNumber, pageSize, productfamily, sort, customerId) async {
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(productfamily, 'productfamily');
    ArgumentError.checkNotNull(sort, 'sort');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'productfamily': productfamily,
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
}
