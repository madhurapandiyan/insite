import "package:dio/dio.dart" as dio;
import "package:gql/language.dart" as gql;
import "package:gql_dio_link/gql_dio_link.dart";
import "package:gql_exec/gql_exec.dart";
import "package:gql_link/gql_link.dart";
import 'package:logger/logger.dart';

class Network {
  static final graphqlEndpoint =
      "https://cloud.api.trimble.com/osg-in/frame-gateway-gql/1.0/graphql";
  final headers = {
    "content-type": "application/json",
    "X-VisionLink-CustomerUid": "1857723c-ada1-11eb-8529-0242ac130003",
    "service": "in-vfleet-uf-webapi",
    "Accept": "application/json",
    "X-VisionLink-UserUid": "1d022b5a-2e4a-4f5b-bd81-ad2a75977e21",
    "Authorization":
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL2lkLnRyaW1ibGUuY29tIiwiZXhwIjoxNjM5NjYxNDkzLCJuYmYiOjE2Mzk2NTc4OTMsImlhdCI6MTYzOTY1Nzg5MywianRpIjoiZGU0YTk3YTVhOGFhNGJmN2E2NDU5NDA1OTVjNDM1NzUiLCJqd3RfdmVyIjoyLCJzdWIiOiIxZDAyMmI1YS0yZTRhLTRmNWItYmQ4MS1hZDJhNzU5NzdlMjEiLCJpZGVudGl0eV90eXBlIjoidXNlciIsImFtciI6WyJwYXNzd29yZCJdLCJhdXRoX3RpbWUiOjE2Mzk2NTM4MzMsImF6cCI6Ijg5NDUyNDVkLTU5NzAtNDAxNS04NmQzLTQwNDk3NmI5YWY1ZiIsImF1ZCI6WyI4OTQ1MjQ1ZC01OTcwLTQwMTUtODZkMy00MDQ5NzZiOWFmNWYiXSwic2NvcGUiOiJPU0ctSU4tUFVMU0UtQVBQLVBST0QifQ.SH8MdA3hNUoUJ4RW1MVuqiJE1enfqypbE8PDxZxGGkrhf94-woG-G8zmWH9ZHcn0Sjxy03vldyr0spUUV_h4IVtwmbFVuDX4B5ClODNiQlwiew6JlnGZ4gfJdMZ1-C-fx1i2MOAkRriaSEFv7VWT55cvic-Yp-o9EpxUQLi1trU_BDl07PIYAMO4hydgUhABLhEiCnc2svQTnsypT4lTxXV9EValOFVEQv0VGD6dpYSOWfoHiV8su-olN0o8NuvMOlKTnnOUcRwM6DCJvPQuk2s9Al5Qwbq5Ems7-2pjyQ_cY7lbEzX4fbdMFSLYAgfa-a4-6dGt0B_CLNW3eahSzw"
  };

  getGraphqlData(var query) async {
    final client = dio.Dio();

    final Link link =
        DioLink(graphqlEndpoint, client: client, defaultHeaders: headers);

    final res = await link
        .request(Request(
          operation: Operation(document: gql.parseString(query)),
        ))
        .first;

    return res;
  }
}
