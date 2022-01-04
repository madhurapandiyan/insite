import "package:dio/dio.dart" as dio;
import "package:gql/language.dart" as gql;
import "package:gql_dio_link/gql_dio_link.dart";
import "package:gql_exec/gql_exec.dart";
import "package:gql_link/gql_link.dart";
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';

class Network {
  static final graphqlEndpoint =
      "https://cloud.api.trimble.com/osg-in/frame-gateway-gql/1.0/graphql";
  final LocalService? _localService = locator<LocalService>();

  getGraphqlData(
    String? query,
    String? customerId,
    String? userId,
  ) async {
    final client = dio.Dio();

    final Link link = DioLink(graphqlEndpoint, client: client, defaultHeaders: {
      "content-type": "application/json",
      "X-VisionLink-CustomerUid": customerId!,
      "service": "in-vfleet-uf-webapi",
      "Accept": "application/json",
      "X-VisionLink-UserUid": userId!,
      "Authorization": "bearer " + await _localService!.getToken(),
    });

    final res = await link
        .request(Request(
          operation: Operation(document: gql.parseString(query!)),
        ))
        .first;

    return res;
  }
}
