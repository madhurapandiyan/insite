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
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL2lkLnRyaW1ibGUuY29tIiwiZXhwIjoxNjQwMjg2MzY2LCJuYmYiOjE2NDAyODI3NjYsImlhdCI6MTY0MDI4Mjc2NiwianRpIjoiZTdkMmZiYWM0NmI4NGY4OGIwNjViZGMwM2JhOTAyZDYiLCJqd3RfdmVyIjoyLCJzdWIiOiIxZDAyMmI1YS0yZTRhLTRmNWItYmQ4MS1hZDJhNzU5NzdlMjEiLCJpZGVudGl0eV90eXBlIjoidXNlciIsImFtciI6WyJwYXNzd29yZCJdLCJhdXRoX3RpbWUiOjE2NDAyMzMzNzAsImF6cCI6Ijg5NDUyNDVkLTU5NzAtNDAxNS04NmQzLTQwNDk3NmI5YWY1ZiIsImF1ZCI6WyI4OTQ1MjQ1ZC01OTcwLTQwMTUtODZkMy00MDQ5NzZiOWFmNWYiXSwic2NvcGUiOiJPU0ctSU4tUFVMU0UtQVBQLVBST0QifQ.jdkfXiwIpKobNimdf2Ab6sfd4xGgx27NytTJ_YXSVbZKBGJJDfR7A9_-pUMWg7DI_0wVhuIpWy5cMgHMDMnnp1GDwLTmnYAunX2XK7HsG3S2y4A5HpuKvXBfrrpCzt9R4jowpngx5yem_YwJP2waA7LTbMTjsrr-Eqe-9D5k1SCysXGSRbmKqJmdmk_ktIs8V2wrDGQt8nyqEDj_4pVMzCDsrLGy1P6vWRKt4qR6f3m-St-VVeBRlE7nKd_-VrvwO8boy3d4PptcUpOSaNOp8FzNdf3XyZ5NQRZaA3rf9cpR8vF9iQ3cuoN9Ss2W43Illxt6bOIfT1O4bv6IfL5kfQ"
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
