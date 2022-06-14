import "package:dio/dio.dart" as dio;
import 'package:dio/dio.dart';
import "package:gql/language.dart" as gql;
import "package:gql_dio_link/gql_dio_link.dart";
import "package:gql_exec/gql_exec.dart";
import "package:gql_link/gql_link.dart";
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import '../../utils/helper_methods.dart';
import '../models/login_response.dart';
import '../services/login_service.dart';

class Network {
  final LoginService? _loginService = locator<LoginService>();
  final client = dio.Dio();
  String? codeChallenge;
  // String? queryUrl;
  // String? customerUid;
  // String? subUid;
  // String? customerUserId;
  String codeVerifier = randomAlphaNumeric(43);
  static String _createCodeVerifier() {
    return randomAlphaNumeric(43);
  }

  // static final graphqlEndpoint =
  //     "https://cloud.api.trimble.com/osg-in/frame-gateway-gql/1.0/graphql";
  //     "https://cloud.api.trimble.com/osg-in/gateway-gql-pre-prod/1.0/graphql"

  static final graphqlEndpoint =
      "https://cloud.api.trimble.com/osg-in/gateway-gql-pre-prod/1.0/graphql";

  static final graphqlStaggedEndpoint =
      "https://cloud.qa.api.trimblecloud.com/osg-in/frame-gateway-gql/1.0/graphql";
  final LocalService? _localService = locator<LocalService>();

  Network._internal() {
    client.interceptors
      ..add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    client.clear();
  }
  getGraphqlPlantData({String? query, String? customerId}) async {
    try {
      final Link link = DioLink(
        graphqlEndpoint,
        client: client,
        defaultHeaders: {
          "content-type": "application/json",
          "CustomerId": customerId!,
          "Accept": "application/json",
          "Auth": "bearer " + await _localService!.getToken(),
          "Authorization": "bearer " + await _localService!.getToken(),
        },
      );
      final res = await link
          .request(Request(
            operation: Operation(document: gql.parseString(query!)),
          ))
          .first;

      return res;
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getGraphqlAccountData(
    String? query,
  ) async {
    final Link link = DioLink(graphqlEndpoint, client: client, defaultHeaders: {
      "content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "bearer " + await _localService!.getToken(),
    });
    final res = await link
        .request(Request(
          operation: Operation(document: gql.parseString(query!)),
        ))
        .first;
    return res;
  }

  getGraphqlData(
      {String? query,
      String? customerId,
      String? userId,
      String? subId}) async {
    try {
      // String? tokenTime = await _localService!.getExpiry();
      // Logger().i(tokenTime);
      // if (DateTime.now().isAfter(DateTime.parse(tokenTime!))) {
      //   Logger().e("token expired");
      // }
      // queryUrl = query;
      // customerUserId = userId;
      // customerUid = customerId;
      // subUid = subId;
      // Logger().w(customerId);
      // Logger().w(userId);
      // Logger().w(subId);

      final Link link = DioLink(
        graphqlEndpoint,
        client: client,
        defaultHeaders: {
          "content-type": "application/json",
          "X-VisionLink-CustomerUid": customerId!,
          "service": "in-vfleet-uf-webapi",
          "Accept": "application/json",
          "X-VisionLink-UserUid": userId!,
          "Authorization": "bearer " + await _localService!.getToken(),
          "sub-customeruid": subId!
        },
      );
      final res = await link
          .request(Request(
            operation: Operation(document: gql.parseString(query!)),
          ))
          .first;

      return res;
    } catch (e) {
      Logger().e(e.toString());
      if (e is DioLinkServerException) {
        var error = e;
        if (error.response.statusCode == 401) {
          var refreshLoginResponce = await refreshToken();
          if (refreshLoginResponce != null) {
            await _localService!.saveTokenInfo(refreshLoginResponce);
            await _localService!.saveToken(refreshLoginResponce.access_token);
            await _localService!
                .saveRefreshToken(refreshLoginResponce.refresh_token);
            var tokenTime =
                Utils.tokenExpiresTime(refreshLoginResponce.expires_in!);
            await _localService!.saveExpiryTime(tokenTime);
            var data = await getGraphqlData(
                query: query,
                customerId: customerId,
                userId: userId,
                subId: subId);
            return data;
          }
        } else {
          throw e;
        }
      } else {
        throw e;
      }
    }
  }

  getStaggedGraphqlData(
      {String? query,
      String? customerId,
      String? userId,
      String? subId}) async {
    try {
      // queryUrl = query;
      // customerUserId = userId;
      // customerUid = customerId;
      // subUid = subId;
      // Logger().w(customerId);
      // Logger().w(userId);
      // Logger().w(subId);

      final Link link = DioLink(
        graphqlEndpoint,
        client: client,
        defaultHeaders: {
          "content-type": "application/json",
          "X-VisionLink-CustomerUid": customerId!,
          "service": "in-vfleet-uf-webapi",
          "Accept": "application/json",
          "X-VisionLink-UserUid": userId!,
          "Authorization": "bearer " + await _localService!.getToken(),
          "sub-customeruid": subId!
        },
      );
      final res = await link
          .request(Request(
            operation: Operation(document: gql.parseString(query!)),
          ))
          .first;

      return res;
    } catch (e) {
      Logger().e(e.toString());
      if (e is DioLinkServerException) {
        var error = e;
        if (error.response.statusCode == 401) {
          await staggedRefreshToken();
          var data = await getGraphqlData(
              query: query,
              customerId: customerId,
              userId: userId,
              subId: subId);
          return data;
        } else {
          throw e;
        }
      } else {
        throw e;
      }
    }
  }

  Future<LoginResponse?> refreshToken() async {
    var currentCodeVerifier = await _localService!.getCodeVerifier();
    var refreshToken = await _localService!.getRefreshToken();
    codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier(), true);
    Logger().e("code verifier $currentCodeVerifier");
    Logger().i("refresh token $refreshToken");
    Logger().w("code challenge $codeChallenge");
    LoginResponse? result = await _loginService!.getRefreshLoginDataV4(
        code_challenge: codeChallenge,
        code_verifier: currentCodeVerifier,
        token: refreshToken);
    return result;
  }

  staggedRefreshToken() async {
    LoginResponse? stagedResult = await _loginService!.stagedToken();
    if (stagedResult != null) {
      _localService!.saveStaggedToken(stagedResult.access_token);
    }
  }

  static final Network _singleton = Network._internal();

  factory Network() => _singleton;
}
