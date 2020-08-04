import 'package:chopper/chopper.dart';
import 'package:driver_salary/utilities.dart';

part 'authentication_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class AuthenticationClient extends ChopperService {
  @Post(
    path: EndPoint.GET_TOKEN,
//      headers: {"content-type": "application/x-www-form-urlencoded"}
  )
  Future<Response> getToken(@Body() Map<String, dynamic> json);

  @Get(path: EndPoint.getPilotWallet)
  Future<Response> getProfile(@Path("email") String email);

  @Post(path: EndPoint.getReport)
  Future<Response> getReport(@Body() Map body);

   @Post(path: EndPoint.changePassword)
  Future<Response> changePassword(@Body() Map body);

  static AuthenticationClient create({String token}) {
    final client = ChopperClient(
        baseUrl: EndPoint.authenticationBaseURL,
        services: [
          _$AuthenticationClient(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          CurlInterceptor(),
          (token != null)
              ? HeadersInterceptor({
                  "Authorization": "bearer $token",
                })
              : HeadersInterceptor({}),
        ]);
    return _$AuthenticationClient(client);
  }

  static const String name = "athorization";
  static const String nameWithTokenHeader = "athorization_with_header";
}
