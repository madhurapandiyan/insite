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
    email_verified: json['email_verified'],
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

AuthenticatedUser _$AuthenticatedUserFromJson(Map<String, dynamic> json) {
  return AuthenticatedUser(
    code: json['code'] as String,
    status: json['status'] as String,
    result: json['result'] as String,
  );
}

Map<String, dynamic> _$AuthenticatedUserToJson(AuthenticatedUser instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

AuthenticatePayload _$AuthenticatePayloadFromJson(Map<String, dynamic> json) {
  return AuthenticatePayload(
    env: json['env'] as String,
    grantType: json['grantType'] as String,
    code: json['code'] as String,
    redirectUri: json['redirectUri'] as String,
    client_key: json['client_key'] as String,
    clientSecret: json['clientSecret'] as String,
    tenantDomain: json['tenantDomain'] as String,
    mobile: json['mobile'] as String,
    uuid: json['uuid'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$AuthenticatePayloadToJson(
        AuthenticatePayload instance) =>
    <String, dynamic>{
      'env': instance.env,
      'grantType': instance.grantType,
      'code': instance.code,
      'redirectUri': instance.redirectUri,
      'client_key': instance.client_key,
      'clientSecret': instance.clientSecret,
      'tenantDomain': instance.tenantDomain,
      'mobile': instance.mobile,
      'uuid': instance.uuid,
      'email': instance.email,
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
      url, assetUID, serviceHeader, customerId, userId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUID, 'assetUID');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'service': serviceHeader,
              r'X-VisionLink-CustomerUid': customerId,
              r'X-VisionLink-UserUid': userId
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
  Future<SearchData> search(url, customerId, serviceHeader) async {
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
    final value = SearchData.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchData> searchVL(url, customerId) async {
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
  Future<UtilizationSummaryResponse> utilLizationListVL(url, customerId) async {
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
    final value = UtilizationSummaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetUtilization> singleAssetUtilization(
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
  Future<AssetCount> assetCount(url, customerId, service) async {
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
  Future<AssetCount> assetCountVL(url, customerId) async {
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
  Future<AssetLocationData> assetLocationVL(url, customerId) async {
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
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> fuelLevel(url, customerId, service) async {
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
  Future<AssetCount> fuelLevelVL(url, customerId) async {
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
  Future<AssetUtilization> assetUtilGraphData(url, customerId, service) async {
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
    final value = AssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetUtilization> assetUtilGraphDataVL(url, customerId) async {
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
    final value = AssetUtilization.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetCount> idlingLevel(url, customerId, serviceHeader) async {
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
  Future<AssetCount> idlingLevelVL(url, customerId) async {
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
  Future<SingleAssetOperation> singleAssetOperationVL(url, customerId) async {
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
    final value = SingleAssetOperation.fromJson(_result.data);
    return value;
  }

  @override
  Future<RunTimeCumulative> runtimeCumulative(
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
  Future<TotalHours> getTotalHours(url, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
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
  Future<UtilizationSummary> getAssetUtilizationVL(url, customerId) async {
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
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilizationcustomerUIDVL(
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
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResponse> getToken(username, password, granttype, clientid,
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
  Future<LoginResponse> getTokenWithoutLogin(authorization, contentType) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(contentType, 'contentType');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/oauth/token?grant_type=client_credentials',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'Authorization': authorization,
              r'content-type': contentType
            },
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
  Future<HealthListResponse> getHealthListData(
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
  Future<AssetCount> faultCount(url, customerId, service) async {
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
  Future<AssetCount> faultCountVL(url, customerId) async {
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
  Future<AssetCount> idlingLevelFilterDataVL(customerId) async {
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
  Future<UtilizationSummary> utilizationSummary(
      url, customerId, service) async {
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
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<UtilizationSummary> utilizationSummaryVL(url, customerId) async {
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
    final value = UtilizationSummary.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> locationFilterData(url, customerId, service) async {
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
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetLocationData> locationFilterDataVL(url, customerId) async {
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
    final value = AssetLocationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<AdminManageUser> getAdminManagerUserListDataVL(url, customerId) async {
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
    final value = AdminManageUser.fromJson(_result.data);
    return value;
  }

  @override
  Future<ManageUser> getUser(url, customerId) async {
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
    final value = ManageUser.fromJson(_result.data);
    return value;
  }

  @override
  Future<ApplicationData> getApplicationsData(url, customerId) async {
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
    final value = ApplicationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdateResponse> updateUserData(url, customerId, updateUserData) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(updateUserData, 'updateUserData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdateResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdateResponse> deleteUsersData(
      url, customerId, updateUserData) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(updateUserData, 'updateUserData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdateResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdateResponse> deleteUsers(
      url, updateUserData, customerId, userId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(updateUserData, 'updateUserData');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'X-VisionLink-UserUid': userId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdateResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddUser> addUserData(url, customerId, updateUserData) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(updateUserData, 'updateUserData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddUser.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddUser> inviteUser(
      url, updateUserData, customerId, userId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(updateUserData, 'updateUserData');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'X-VisionLink-UserUid': userId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddUser.fromJson(_result.data);
    return value;
  }

  @override
  Future<RoleDataResponse> roles(url, customerId) async {
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
    final value = RoleDataResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AdminManageUser> getAdminManagerUserListData(
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
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AdminManageUser.fromJson(_result.data);
    return value;
  }

  @override
  Future<ManageAssetConfiguration> getAssetSettingsListDataVL(
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
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ManageAssetConfiguration.fromJson(_result.data);
    return value;
  }

  @override
  Future<ManageAssetConfiguration> getAssetSettingsListData(
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
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ManageAssetConfiguration.fromJson(_result.data);
    return value;
  }

  @override
  Future<SubscriptionDashboardResult> getSubscriptionDashboardResults(
      url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SubscriptionDashboardResult.fromJson(_result.data);
    return value;
  }

  @override
  Future<SubscriptionDashboardDetailResult> getSubscriptionDeviceResults(
      url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SubscriptionDashboardDetailResult.fromJson(_result.data);
    return value;
  }

  @override
  Future<HierarchyAssets> getPlantHierarchyAssetsDetails(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HierarchyAssets.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddSettings> getassetSettingsFuelBurnRateDataVL(
      url, assetFuelBurnRateSetting, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        assetFuelBurnRateSetting, 'assetFuelBurnRateSetting');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetFuelBurnRateSetting?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddSettings.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddSettings> getassetSettingsFuelBurnRateData(
      url, assetFuelBurnRateSetting, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        assetFuelBurnRateSetting, 'assetFuelBurnRateSetting');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetFuelBurnRateSetting?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddSettings.fromJson(_result.data);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getAssetTargetSettingsDataVL(
      url, estimatedAssetSetting, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(estimatedAssetSetting, 'estimatedAssetSetting');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(estimatedAssetSetting?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EstimatedAssetSetting.fromJson(_result.data);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getAssetTargetSettingsData(
      url, estimatedAssetSetting, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(estimatedAssetSetting, 'estimatedAssetSetting');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(estimatedAssetSetting?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EstimatedAssetSetting.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> postGeofenceAnotherData(
      url, customeruid, geofencepayload) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(geofencepayload, 'geofencepayload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> putGeofenceAnotherData(
      url, customeruid, geofencepayload) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(geofencepayload, 'geofencepayload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<Materialmodel> getMaterialModel(url, customeruid) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Materialmodel.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> putGeofencePayLoadVL(
      url, customeruid, geofencepayload) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(geofencepayload, 'geofencepayload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<AuthenticatedUser> authenticateUser(url, authenticatePayload) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(authenticatePayload, 'authenticatePayload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authenticatePayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AuthenticatedUser.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> putGeofencePayLoad(
      url, customeruid, geofencepayload, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(geofencepayload, 'geofencepayload');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postGeofencePayLoadVL(
      url, customeruid, geofencepayload) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(geofencepayload, 'geofencepayload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postGeofencePayLoad(
      url, customeruid, geofencepayload, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(geofencepayload, 'geofencepayload');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<Geofence> getGeofenceDataVL(url, customeruid) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Geofence.fromJson(_result.data);
    return value;
  }

  @override
  Future<Geofence> getGeofenceData(url, customeruid, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Geofence.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> deleteGeofenceVL(url, customeruid) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> deleteGeofence(url, customeruid, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<Geofencemodeldata> getSingleGeofenceVL(url, customeruid) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Geofencemodeldata.fromJson(_result.data);
    return value;
  }

  @override
  Future<Geofencemodeldata> getSingleGeofence(url, customeruid, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Geofencemodeldata.fromJson(_result.data);
    return value;
  }

  @override
  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadDataVL(
      url, estimatedCycleVolumePayLoad, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        estimatedCycleVolumePayLoad, 'estimatedCycleVolumePayLoad');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(estimatedCycleVolumePayLoad?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EstimatedCycleVolumePayLoad.fromJson(_result.data);
    return value;
  }

  @override
  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadData(
      url, estimatedCycleVolumePayLoad, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        estimatedCycleVolumePayLoad, 'estimatedCycleVolumePayLoad');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(estimatedCycleVolumePayLoad?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EstimatedCycleVolumePayLoad.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetMileageSettingData> getMileageDataVL(
      url, assetMileageSettingData, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        assetMileageSettingData, 'assetMileageSettingData');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetMileageSettingData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetMileageSettingData.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> markFavouriteVL(url, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> markFavourite(url, customerId, service) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(service, 'service');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': service
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<AssetMileageSettingData> getMileageData(
      url, assetMileageSettingData, customerId, serviceHeader) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        assetMileageSettingData, 'assetMileageSettingData');
    ArgumentError.checkNotNull(customerId, 'customerId');
    ArgumentError.checkNotNull(serviceHeader, 'serviceHeader');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetMileageSettingData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customerId,
              r'service': serviceHeader
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetMileageSettingData.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetAddgeofenceModel> getGeofenceInputData(url, customeruid) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(customeruid, 'customeruid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'x-visionlink-customeruid': customeruid
            },
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetAddgeofenceModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleAssetResponce> postSingleAssetSmsSchedule(
      url, singleAssetData) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(singleAssetData, 'singleAssetData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = singleAssetData.map((e) => e.toJson()).toList();
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleAssetResponce.fromJson(_result.data);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getEstimatedTagetListData(
      url, assetUid, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = assetUid;
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EstimatedAssetSetting.fromJson(_result.data);
    return value;
  }

  @override
  Future<EstimatedCycleVolumePayLoad> getEstimatedCyclePayLoadVoumeListData(
      url, assetUid, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetUid, 'assetUid');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = assetUid;
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EstimatedCycleVolumePayLoad.fromJson(_result.data);
    return value;
  }

  @override
  Future<SavingSmsResponce> savingSms(url, singleAssetData) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(singleAssetData, 'singleAssetData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = singleAssetData.map((e) => e.toJson()).toList();
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SavingSmsResponce.fromJson(_result.data);
    return value;
  }

  @override
  Future<SmsReportSummaryModel> gettingReportSummary(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SmsReportSummaryModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<SmsReportSummaryModel> gettingScheduleReportSummary(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SmsReportSummaryModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> getAssetIconData(url, assetIconPayLoad, customerId) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(assetIconPayLoad, 'assetIconPayLoad');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetIconPayLoad?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'x-visionlink-customeruid': customerId},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<SerialNumberResults> getModelNameFromMachineSerialNumber(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SerialNumberResults.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddAssetRegistrationData> getSingleAssetRegistrationData(
      url, addAssetRegistrationData) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(
        addAssetRegistrationData, 'addAssetRegistrationData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addAssetRegistrationData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddAssetRegistrationData.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeviceSearchModel> getDeviceSearchModel(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeviceSearchModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeviceSearchModelResponse> getDeviceSearchModelResponse(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeviceSearchModelResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ReplaceDeviceModel> getReplaceDeviceModel(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ReplaceDeviceModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> postNewDeviceId(url, replacementModel) async {
    ArgumentError.checkNotNull(url, 'url');
    ArgumentError.checkNotNull(replacementModel, 'replacementModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(replacementModel?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('$url',
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
  Future<TotalDeviceReplacementStatusModel> getRepalcementDeviceStatus(
      url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TotalDeviceReplacementStatusModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ReplacementDeviceIdDownload> getReplacementDeviceIdDownload(
      url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ReplacementDeviceIdDownload.fromJson(_result.data);
    return value;
  }

  @override
  Future<SingleTransferDeviceId> getSingleAssetTransfersDeviceIds(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SingleTransferDeviceId.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeviceDetailsPerId> getDeviceDetailsPerDeviceId(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeviceDetailsPerId.fromJson(_result.data);
    return value;
  }

  @override
  Future<AssetDetailsBySerialNo> getDeviceDetailsPerSerialNo(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AssetDetailsBySerialNo.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomerDetails> getExitingCustomerDetails(url) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$url',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomerDetails.fromJson(_result.data);
    return value;
  }
}
