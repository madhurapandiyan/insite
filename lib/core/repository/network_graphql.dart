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
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL2lkLnRyaW1ibGUuY29tIiwiZXhwIjoxNjM5NzQ5NzU3LCJuYmYiOjE2Mzk3NDYxNTcsImlhdCI6MTYzOTc0NjE1NywianRpIjoiMmFkNGEyODk3N2RhNDNmMWEzNDkxNTA4YTJmMmI4MzciLCJqd3RfdmVyIjoyLCJzdWIiOiIxZDAyMmI1YS0yZTRhLTRmNWItYmQ4MS1hZDJhNzU5NzdlMjEiLCJpZGVudGl0eV90eXBlIjoidXNlciIsImFtciI6WyJwYXNzd29yZCJdLCJhdXRoX3RpbWUiOjE2Mzk3MjIyNTQsImF6cCI6Ijg5NDUyNDVkLTU5NzAtNDAxNS04NmQzLTQwNDk3NmI5YWY1ZiIsImF1ZCI6WyI4OTQ1MjQ1ZC01OTcwLTQwMTUtODZkMy00MDQ5NzZiOWFmNWYiXSwic2NvcGUiOiJPU0ctSU4tUFVMU0UtQVBQLVBST0QifQ.hpbPYP9i-AHyIxzg-IUsmALbfqJnFyzWYjSwjphuJTmCBjVpAUDTZiq1_5U3xIOldj6EHWVzhdFOeyr-U8CZxOfMFu0RDsRMbZGLkoNpWEalTSB9S86J3ldjampfar48tZY1Nzk5vbQdJ8LE3734yRIDHYGU7A3j-7UPPHsjZv_0nS28UK3Od1taIpLo0urGtRA3oIrjnexHIkAF0M9cV3ipWhD_Yo541TBa5Xhy1q3ooj3EYGZyaDLRwhl7bqdpj84XWdFqWOzjVN9XJkg9ziEO978BRVCO0hLK9yZmgdKxytWdzN8EZWkW7sXG8TZuiqpBOW1fkOYsKzI8Xt7xNQ"
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
