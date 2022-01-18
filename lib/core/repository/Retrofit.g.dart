// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Retrofit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sample _$SampleFromJson(Map<String, dynamic> json) => Sample(
      status: json['status'] as bool?,
      logout: json['logout'] as bool?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$SampleToJson(Sample instance) => <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'logout': instance.logout,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      email: json['email'] as String?,
      family_name: json['family_name'] as String?,
      given_name: json['given_name'] as String?,
      accountUserName: json['accountUserName'] as String?,
      uuid: json['uuid'] as String?,
      lastPwdSetTimeStamp: json['lastPwdSetTimeStamp'] as String?,
      lastLoginTimeStamp: json['lastLoginTimeStamp'] as String?,
      lastUpdateTimeStamp: json['lastUpdateTimeStamp'] as String?,
      accountName: json['accountName'] as String?,
      sub: json['sub'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email_verified: json['email_verified'],
    );

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

UserPayLoad _$UserPayLoadFromJson(Map<String, dynamic> json) => UserPayLoad(
      env: json['env'] as String?,
      grant_type: json['grant_type'] as String?,
      code: json['code'] as String?,
      redirect_uri: json['redirect_uri'] as String?,
      client_key: json['client_key'] as String?,
      client_secret: json['client_secret'] as String?,
      tenantDomain: json['tenantDomain'] as String?,
    );

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
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      access_token: json['access_token'] as String?,
      token_type: json['token_type'] as String?,
      expires_in: json['expires_in'] as int?,
    );

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
    };

AuthenticatedUser _$AuthenticatedUserFromJson(Map<String, dynamic> json) =>
    AuthenticatedUser(
      code: json['code'] as String?,
      status: json['status'] as String?,
      result: json['result'] as String?,
    );

Map<String, dynamic> _$AuthenticatedUserToJson(AuthenticatedUser instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'result': instance.result,
    };

AuthenticatePayload _$AuthenticatePayloadFromJson(Map<String, dynamic> json) =>
    AuthenticatePayload(
      env: json['env'] as String? ?? "THC",
      grantType: json['grantType'] as String? ?? "authorization_code",
      code: json['code'] as String? ??
          "1iTfEId3nqmvNc5mune6Y0W8-CJomXmN54ZMb_UpKFT",
      redirectUri: json['redirectUri'] as String? ??
          "https://dev-oem.frame-oesolutions.com/auth",
      client_key: json['client_key'] as String? ??
          "130510bd-8a90-4278-b97a-d811df44ef10",
      clientSecret: json['clientSecret'] as String? ?? "testSecret",
      tenantDomain: json['tenantDomain'] as String? ?? "trimble.com",
      mobile: json['mobile'] as String? ?? "0000000000",
      uuid: json['uuid'] as String?,
      email: json['email'] as String?,
    );

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
    baseUrl ??= 'https://cloud.api.trimble.com/CTSPulseIndiastg';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Sample>> getTasks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Sample>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tasks',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Sample.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<UserInfo> getUserInfo(contentType, authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': contentType,
      r'Authorization': authorization
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserInfo>(Options(
                method: 'GET',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/userinfo?schema=openid',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserInfo> getUserInfoVl(contentType, authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': contentType,
      r'Authorization': authorization
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserInfo>(Options(
                method: 'GET',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/oauth/userinfo',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserInfo> getUserInfoV4(
      contentType, authorization, accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': contentType,
      r'Authorization': authorization
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(accessToken.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserInfo>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/oauth/userinfo',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PermissionResponse> getPermission(
      limit, provider_id, xVisonLinkCustomerId, customerId, user_guid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'provider_id': provider_id
    };
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': xVisonLinkCustomerId
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        PermissionResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/authorization/1.0.0/users/${user_guid}/organizations/${customerId}/permissions',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PermissionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PermissionResponse> getPermissionVL(
      limit, provider_id, customerId, xVisonLinkCustomerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'provider_id': provider_id
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': xVisonLinkCustomerId
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        PermissionResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/authorization/1.0.0/users/organizations/${customerId}/permissions',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PermissionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchy(
      url, toplevelsonly, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'toplevelsonly': toplevelsonly};
    final _headers = <String, dynamic>{r'service': serviceHeader};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CustomersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchyVL(toplevelsonly) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'toplevelsonly': toplevelsonly};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/t/trimble.com/vss-customerservice/1.0/accounthierarchy',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CustomersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchyChildren(
      url, targetcustomeruid, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'targetcustomeruid': targetcustomeruid
    };
    final _headers = <String, dynamic>{r'service': serviceHeader};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CustomersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CustomersResponse> accountHierarchyChildrenVL(
      targetcustomeruid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'targetcustomeruid': targetcustomeruid
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/t/trimble.com/vss-customerservice/1.0/accounthierarchy',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CustomersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FleetSummaryResponse> fleetSummaryURL(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FleetSummaryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FleetSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FleetSummaryResponse> fleetSummaryURLVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FleetSummaryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FleetSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetResponse> assetSummaryURL(url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetResponse> assetSummaryURLVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationWithCluster(url, latitude, longitude,
      pageNumber, pageSize, radiusKm, sort, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'latitude': latitude,
      r'longitude': longitude,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'radiuskm': radiusKm,
      r'sort': sort
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationWithClusterVL(latitude, longitude,
      pageNumber, pageSize, radiusKm, sort, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'latitude': latitude,
      r'longitude': longitude,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'radiuskm': radiusKm,
      r'sort': sort
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/t/trimble.com/vss-unifiedfleetmap/1.0/location/maps/v1',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationSummary(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationSummaryVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetDetail> assetDetail(
      url, assetUID, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetDetail>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetDetail.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetDetail> assetDetailVL(assetUID, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        AssetDetail>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetDetails/v1',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetDetail.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetDetail> assetDetailCI(
      url, assetUID, customerUID, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUID': assetUID,
      r'customerUID': customerUID
    };
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetDetail>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetDetail.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Note>> getAssetNotes(
      url, assetUID, serviceHeader, customerId, userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _headers = <String, dynamic>{
      r'service': serviceHeader,
      r'X-VisionLink-CustomerUid': customerId,
      r'X-VisionLink-UserUid': userId
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Note>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Note.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Note>> getAssetNotesVL(assetUID, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Note>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/t/trimble.com/VSS-AssetMetadata/1.0/AssetMetadata/Notes/v1/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Note.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<dynamic> postNotes(url, postnote, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'service': serviceHeader};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(postnote.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postNotesVL(postnote) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postnote.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/t/trimble.com/VSS-AssetMetadata/1.0/AssetMetadata/Notes/v1',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> ping(postnote) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postnote.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/npulse-masterdataapi-in/1.0/v1/ping',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<PingDeviceData> getPingData(assetUID, deviceUID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'AssetUID': assetUID,
      r'DeviceUID': deviceUID
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PingDeviceData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/npulse-masterdataapi-in/1.0/v1/ping',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PingDeviceData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetDeviceResponse> asset(assetUID, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUID': assetUID};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetDeviceResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/t/trimble.com/vss-deviceservice/2.0/asset',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetDeviceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchData> search(url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchData> searchVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationHistory> assetLocationHistory(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationHistory>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationHistory.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationHistory> assetLocationHistoryVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationHistory>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationHistory.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummaryResponse> utilLizationList(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummaryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummaryResponse> utilLizationListVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummaryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetUtilization> singleAssetUtilization(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetUtilization>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetUtilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetUtilization> singleAssetUtilizationVL(
      url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetUtilization>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetUtilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetUtilization> singleAssetUtilizationGraph(
      assetUID, startDate, endDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'AssetUid': assetUID,
      r'startDate': startDate,
      r'endDate': endDate
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        SingleAssetUtilization>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/npulse-utilization-in/1.0/api/v1/Utilization/Details/Aggregate/v1',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetUtilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Utilization> utilization(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Utilization>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Utilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Utilization> utilizationVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Utilization>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Utilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> assetCount(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> assetCountVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> userCount(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> userCountVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> assetLocationVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> fuelLevel(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> fuelLevelVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetUtilization> assetUtilGraphData(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetUtilization>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetUtilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetUtilization> assetUtilGraphDataVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetUtilization>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetUtilization.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> idlingLevel(url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<IdlingLevelData> notificationData(status, userStatus) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'notificationStatus': status,
      r'notificationUserStatus': userStatus
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<IdlingLevelData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/t/trimble.com/vss-notification/1.0/Notification/Count',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = IdlingLevelData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetOperation> singleAssetOperation(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetOperation>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetOperation.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetOperation> singleAssetOperationVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetOperation>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetOperation.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RunTimeCumulative> runtimeCumulative(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RunTimeCumulative>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RunTimeCumulative.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RunTimeCumulative> runtimeCumulativeVL(
      startDate, endDate, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdatelocal': startDate,
      r'enddatelocal': endDate
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        RunTimeCumulative>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/hours/cumulatives',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RunTimeCumulative.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FuelBurnedCumulative> fuelBurnedCumulative(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FuelBurnedCumulative>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FuelBurnedCumulative.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FuelBurnedCumulative> fuelBurnedCumulativeVL(
      startDate, endDate, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startdatelocal': startDate,
      r'enddatelocal': endDate
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        FuelBurnedCumulative>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburned/cumulatives',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FuelBurnedCumulative.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TotalHours> getTotalHours(url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TotalHours>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TotalHours.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TotalHours> getTotalHoursVL(interval, startDate, endDate, pageNumber,
      pageSize, includepagination, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        TotalHours>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/hours/cumulatives/intervals',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TotalHours.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TotalFuelBurned> getTotalFuelBurned(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TotalFuelBurned>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TotalFuelBurned.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TotalFuelBurned> getTotalFuelBurnedVL(interval, startDate, endDate,
      pageNumber, pageSize, includepagination, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        TotalFuelBurned>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburned/cumulatives/intervals',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TotalFuelBurned.fromJson(_result.data!);
    return value;
  }

  @override
  Future<IdlePercentTrend> getIdlePercentTrend(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<IdlePercentTrend>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = IdlePercentTrend.fromJson(_result.data!);
    return value;
  }

  @override
  Future<IdlePercentTrend> getIdlePercentTrendVL(interval, startDate, endDate,
      pageNumber, pageSize, includepagination, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        IdlePercentTrend>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/idlepercent',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = IdlePercentTrend.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FuelBurnRateTrend> getFuelBurnRateTrend(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FuelBurnRateTrend>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FuelBurnRateTrend.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FuelBurnRateTrend> getFuelBurnRateTrendVL(interval, startDate, endDate,
      pageNumber, pageSize, includepagination, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'interval': interval,
      r'startdatelocal': startDate,
      r'enddatelocal': endDate,
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'includepagination': includepagination
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        FuelBurnRateTrend>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/summary/v2/fuelburnrate',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FuelBurnRateTrend.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LocationSearchResponse> getLocations(
      query, maxResults, authToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'maxResults': maxResults,
      r'authToken': authToken
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LocationSearchResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/ww/api/search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LocationSearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilization(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummary>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummary.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilizationcustomerUID(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummary>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummary.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilizationVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummary>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummary.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummary> getAssetUtilizationcustomerUIDVL(
      url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummary>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummary.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> getToken(username, password, granttype, clientid,
      clientsecret, scope, contentType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'username': username,
      r'password': password,
      r'grant_type': granttype,
      r'client_id': clientid,
      r'client_secret': clientsecret,
      r'scope': scope
    };
    final _headers = <String, dynamic>{r'content-type': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/token',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> getTokenV4(tokenData, contentType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'content-type': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(tokenData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/oauth/token',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> getRefreshLoginData(contentType, refreshToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'content-type': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(refreshToken.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/oauth/token',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> getTokenWithoutLogin(authorization, contentType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': authorization,
      r'content-type': contentType
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: contentType)
            .compose(_dio.options, '/oauth/token?grant_type=client_credentials',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FaultSummaryResponse> faultViewSummaryURL(
      url, fitlers, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = fitlers;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FaultSummaryResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FaultSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FaultSummaryResponse> faultViewSummaryURLVL(
      url, fitlers, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = fitlers;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FaultSummaryResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FaultSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetFaultSummaryResponse> assetViewSummaryURL(
      url, fitlers, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = fitlers;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetFaultSummaryResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetFaultSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetFaultSummaryResponse> assetViewSummaryURLVL(
      url, fitlers, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = fitlers;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetFaultSummaryResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetFaultSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FaultSummaryResponse> assetViewDetailSummaryURL(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FaultSummaryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FaultSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FaultSummaryResponse> assetViewDetailSummaryURLVL(
      url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FaultSummaryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FaultSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HealthListResponse> assetViewLocationSummaryURL(
      url, assetUid, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUid': assetUid};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'X-VisionLink-CustomerUid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HealthListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HealthListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HealthListResponse> assetViewLocationSummaryURLVL(
      url, assetUid, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'assetUid': assetUid};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'X-VisionLink-CustomerUid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HealthListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HealthListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HealthListResponse> getHealthListData(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HealthListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HealthListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HealthListResponse> getHealthListDataVL(assetUid, endDateTime,
      langDesc, limit, page, startDateTime, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUid,
      r'endDateTime': endDateTime,
      r'langDesc': langDesc,
      r'limit': limit,
      r'page': page,
      r'startDateTime': startDateTime
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HealthListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/t/trimble.com/vss-service/1.0/health/FaultDetails/v1',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HealthListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetFaultResponse> getDashboardListData(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetFaultResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetFaultResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetFaultResponse> getDashboardListDataVL(
      assetUid, endDate, startDate, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'assetUid': assetUid,
      r'endDateTime': endDate,
      r'startDateTime': startDate
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetFaultResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/t/trimble.com/vss-service/1.0/health/faultSummary/v1',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetFaultResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> faultCount(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> faultCountVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> assetStatusFilterDataVL(
      grouping, productfamily, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'grouping': grouping,
      r'productfamily': productfamily
    };
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        AssetCount>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelFilterData(url, startDate, idleEfficiencyRanges,
      productfamily, endDate, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'startDate': startDate,
      r'idleEfficiencyRanges': idleEfficiencyRanges,
      r'productfamily': productfamily,
      r'endDate': endDate
    };
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCount>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCount> idlingLevelFilterDataVL(customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        AssetCount>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCount.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummary> utilizationSummary(
      url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummary>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummary.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UtilizationSummary> utilizationSummaryVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UtilizationSummary>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UtilizationSummary.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> locationFilterData(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetLocationData> locationFilterDataVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetLocationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetLocationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AdminManageUser> getAdminManagerUserListDataVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AdminManageUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AdminManageUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ManageUser> getUser(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ManageUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ManageUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicationData> getApplicationsData(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApplicationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateResponse> updateUserData(url, customerId, updateUserData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateResponse> deleteUsersData(
      url, customerId, updateUserData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateResponse> deleteUsers(
      url, updateUserData, customerId, userId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'X-VisionLink-UserUid': userId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddUser> addUserData(url, customerId, updateUserData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddUser>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddUser> inviteUser(
      url, updateUserData, customerId, userId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'X-VisionLink-UserUid': userId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateUserData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddUser>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RoleDataResponse> roles(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RoleDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RoleDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AdminManageUser> getAdminManagerUserListData(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AdminManageUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AdminManageUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ManageAssetConfiguration> getAssetSettingsListDataVL(
      url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ManageAssetConfiguration>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ManageAssetConfiguration.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ManageAssetConfiguration> getAssetSettingsListData(
      url, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ManageAssetConfiguration>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ManageAssetConfiguration.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubscriptionDashboardResult> getSubscriptionDashboardResults(
      url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubscriptionDashboardResult>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubscriptionDashboardResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetRegistrationSearchModel> getSubscriptionDeviceResults(
      url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetRegistrationSearchModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetRegistrationSearchModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubscriptionDashboardDetailResult> getSubcriptionDeviceListData(
      url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubscriptionDashboardDetailResult>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubscriptionDashboardDetailResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HierarchyAssets> getPlantHierarchyAssetsDetails(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HierarchyAssets>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HierarchyAssets.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddSettings> getassetSettingsFuelBurnRateDataVL(
      url, assetFuelBurnRateSetting, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetFuelBurnRateSetting.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddSettings>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddSettings.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddSettings> getassetSettingsFuelBurnRateData(
      url, assetFuelBurnRateSetting, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetFuelBurnRateSetting.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddSettings>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddSettings.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getAssetTargetSettingsDataVL(
      url, estimatedAssetSetting, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(estimatedAssetSetting.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedAssetSetting>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedAssetSetting.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getAssetTargetSettingsData(
      url, estimatedAssetSetting, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(estimatedAssetSetting.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedAssetSetting>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedAssetSetting.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> postGeofenceAnotherData(
      url, customeruid, geofencepayload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> putGeofenceAnotherData(
      url, customeruid, geofencepayload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Materialmodel> getMaterialModel(url, customeruid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Materialmodel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Materialmodel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> putGeofencePayLoadVL(
      url, customeruid, geofencepayload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<AuthenticatedUser> authenticateUser(url, authenticatePayload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authenticatePayload.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticatedUser>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticatedUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> putGeofencePayLoad(
      url, customeruid, geofencepayload, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postGeofencePayLoadVL(
      url, customeruid, geofencepayload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postGeofencePayLoad(
      url, customeruid, geofencepayload, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(geofencepayload.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Geofence> getGeofenceDataVL(url, customeruid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Geofence>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Geofence.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Geofence> getGeofenceData(url, customeruid, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Geofence>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Geofence.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> deleteGeofenceVL(url, customeruid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'DELETE', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> deleteGeofence(url, customeruid, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'DELETE', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Geofencemodeldata> getSingleGeofenceVL(url, customeruid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Geofencemodeldata>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Geofencemodeldata.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Geofencemodeldata> getSingleGeofence(url, customeruid, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Geofencemodeldata>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Geofencemodeldata.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadDataVL(
      url, estimatedCycleVolumePayLoad, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(estimatedCycleVolumePayLoad.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedCycleVolumePayLoad>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedCycleVolumePayLoad.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedCycleVolumePayLoad> getEstimatedCycleVolumePayLoadData(
      url, estimatedCycleVolumePayLoad, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(estimatedCycleVolumePayLoad.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedCycleVolumePayLoad>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedCycleVolumePayLoad.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetMileageSettingData> getMileageDataVL(
      url, assetMileageSettingData, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetMileageSettingData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetMileageSettingData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetMileageSettingData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> markFavouriteVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> markFavourite(url, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<AssetMileageSettingData> getMileageData(
      url, assetMileageSettingData, customerId, serviceHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': serviceHeader
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetMileageSettingData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetMileageSettingData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetMileageSettingData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAddgeofenceModel> getGeofenceInputData(url, customeruid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customeruid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAddgeofenceModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAddgeofenceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleAssetResponce> postSingleAssetSmsSchedule(
      url, singleAssetData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = singleAssetData.map((e) => e.toJson()).toList();
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleAssetResponce>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleAssetResponce.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getEstimatedTagetListDataVL(
      url, assetUid, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUid;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedAssetSetting>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedAssetSetting.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedAssetSetting> getEstimatedTagetListData(
      url, assetUid, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'service': service};
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUid;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedAssetSetting>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedAssetSetting.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimatedCycleVolumePayLoad> getEstimatedCyclePayLoadVoumeListData(
      url, assetUid, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUid;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimatedCycleVolumePayLoad>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimatedCycleVolumePayLoad.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SavingSmsResponce> savingSms(url, singleAssetData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = singleAssetData.map((e) => e!.toJson()).toList();
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SavingSmsResponce>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SavingSmsResponce.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SmsReportSummaryModel> gettingReportSummary(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SmsReportSummaryModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SmsReportSummaryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SmsReportSummaryModel> gettingScheduleReportSummary(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SmsReportSummaryModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SmsReportSummaryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getAssetIconDataVL(url, assetIconPayLoad, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetIconPayLoad.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> getAssetIconData(
      url, assetIconPayLoad, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetIconPayLoad.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<SerialNumberResults> getModelNameFromMachineSerialNumber(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SerialNumberResults>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SerialNumberResults.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddAssetRegistrationData> getSingleAssetRegistrationData(
      url, addAssetRegistrationData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addAssetRegistrationData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddAssetRegistrationData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddAssetRegistrationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> postSingleAssetTransferRegistration(url, data) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<AssetTransferData> getSingleAssetTransferData(
      url, assetTransferData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetTransferData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetTransferData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetTransferData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeviceSearchModel> getDeviceSearchModel(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeviceSearchModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeviceSearchModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeviceSearchModelResponse> getDeviceSearchModelResponse(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeviceSearchModelResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeviceSearchModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReplaceDeviceModel> getReplaceDeviceModel(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReplaceDeviceModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReplaceDeviceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> postNewDeviceId(url, replacementModel) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(replacementModel.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<TotalDeviceReplacementStatusModel> getRepalcementDeviceStatus(
      url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TotalDeviceReplacementStatusModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TotalDeviceReplacementStatusModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReplacementDeviceIdDownload> getReplacementDeviceIdDownload(
      url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReplacementDeviceIdDownload>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReplacementDeviceIdDownload.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleTransferDeviceId> getSingleAssetTransfersDeviceIds(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleTransferDeviceId>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SingleTransferDeviceId.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeviceDetailsPerId> getDeviceDetailsPerDeviceId(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeviceDetailsPerId>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeviceDetailsPerId.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetDetailsBySerialNo> getDeviceDetailsPerSerialNo(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetDetailsBySerialNo>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetDetailsBySerialNo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CustomerDetails> getExitingCustomerDetails(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomerDetails>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CustomerDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCreationResponse> getAssetCreationData(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCreationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCreationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetFuelBurnRateSettingsListData>
      getAssetFuelBurnRateSettingsListDataVL(url, assetUid, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUid;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetFuelBurnRateSettingsListData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetFuelBurnRateSettingsListData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetFuelBurnRateSettingsListData>
      getAssetFuelBurnRateSettingsListData(
          url, assetUid, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUid;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetFuelBurnRateSettingsListData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetFuelBurnRateSettingsListData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetMileageSettingsListData> getAssetMileageSettingsListDataVL(
      url, assetUId, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUId;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetMileageSettingsListData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetMileageSettingsListData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetMileageSettingsListData> getAssetMileageSettingsListData(
      url, assetUId, customerId, service) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'x-visionlink-customeruid': customerId,
      r'service': service
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = assetUId;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetMileageSettingsListData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetMileageSettingsListData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> deleteSmsSchedule(url, data) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = data.map((e) => e.toJson()).toList();
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '${url}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<SubscriptionDashboardDetailResult> getFleetStatusData(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubscriptionDashboardDetailResult>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubscriptionDashboardDetailResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListDeviceTypeResponse> getDeviceTypeVL(
      url, assetUId, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetUId.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDeviceTypeResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListDeviceTypeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListDeviceTypeResponse> getDeviceType(
      url, assetUId, service, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'service': service,
      r'x-visionlink-customeruid': customerId
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(assetUId.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListDeviceTypeResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListDeviceTypeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCreationResetData> submitAssetCreationData(
      url, assetCreationPayLoad) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(assetCreationPayLoad.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCreationResetData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCreationResetData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetCreationResetData> downloadAssetCreationData(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetCreationResetData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetCreationResetData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckUserResponse> checkUserVL(url, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-visionlink-customeruid': customerId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckUserResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckUserResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckUserResponse> checkUser(url, service, customerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'service': service,
      r'x-visionlink-customeruid': customerId
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckUserResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${url}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckUserResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
