import 'package:chopper/chopper.dart';
import 'package:driver_salary/Functions/utilities.dart';
import 'package:flutter/rendering.dart';

part 'Functions/authentication_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class AuthenticationClient extends ChopperService {
  @Post(
    path: EndPoint.GET_TOKEN,
//      headers: {"content-type": "application/x-www-form-urlencoded"}
  )
  Future<Response> getToken(@Body() Map<String, dynamic> json);

  @Get(path: EndPoint.getPilotWallet)
  Future<Response> getPilotWallet(@Path("email") String email);

  @Post(path: EndPoint.getReport)
  Future<Response> getReport(@Body() Map body);

  @Post(path: EndPoint.changePassword)
  Future<Response> changePassword(@Body() Map body);

  @Post(path: EndPoint.getAllInventoryitemname)
  Future<Response> getAllInventoryitemname();

  @Post(path: EndPoint.getAllinventory)
  Future<Response> getAllinventory();

  @Post(path: EndPoint.getVehicles)
  Future<Response> getVehicles();

  @Post(path: EndPoint.getIssue)
  Future<Response> getIssue();

  @Post(path: EndPoint.getDepartment)
  Future<Response> getDepartment();

  @Post(path: EndPoint.getWarehouse)
  Future<Response> getWarehouse();

  @Post(path: EndPoint.getWarehousebin)
  Future<Response> getWarehousebin(String warehouseId);

  @Post(path: EndPoint.getMechanic)
  Future<Response> getMechanic();

  @Post(path: EndPoint.getDrivers)
  Future<Response> getDrivers();

  @Get(path: EndPoint.getcancelledStockreqeust)
  Future<Response> getcancelledStockreqeust();

  @Get(path: EndPoint.getcancelledServiceRequest)
  Future<Response> getcancelledServiceRequest();

  @Post(path: EndPoint.requestCreate)
  Future<Response> requestCreate(@Body () Map body);

  @Get(path: EndPoint.getTerminal)
  Future<Response> getTerminal();

  @Get(path: EndPoint.companyTypes)
  Future<Response> companyTypes();

  @Get(path: EndPoint.getProfile)
  Future<Response> getProfile();

  @Get(path: EndPoint.getClaims)
  Future<Response> getClaims();

  @Put(path: EndPoint.verify)
  Future<Response> verify(int id, Map itemList);

  @Put(path: EndPoint.verifymultiplestockreq)
  Future<Response> verifymultiplestockreq(List <int> id,);
  //Map itemList

  @Put(path: EndPoint.verifyService)
  Future<Response> verifyService(List <int> id, );

  @Put(path: EndPoint.verifysingleService)
  Future<Response> verifysingleService(int id, Map itemList);

  @Put(path: EndPoint.approved)
  Future<Response> approved(int id, Map itemList);

  @Put(path: EndPoint.approvemultiplestockreq)
  Future<Response> approvemultiplestockreq(List <int> id,);

  @Put(path:EndPoint.approvedsingleService)
  Future<Response> approvedsingleService(int id, Map itemList);

  @Put(path: EndPoint.approvedService)
  Future<Response> approvedService(List <int> id);

  @Put(path: EndPoint.cancel)
  Future<Response> cancel(int id, Map itemList);

  @Put(path: EndPoint.cancelService)
  Future<Response> cancelService(int id, Map itemList);

  @Put(path: EndPoint.issue)
  Future<Response> issue(int id, Map itemList);

  @Put(path: EndPoint.issuemultiplestockreq)
  Future<Response> issuemultiplestockreq(List <int> id,);

  @Get(path: EndPoint.getServiceRequest)
  Future<Response> getServiceRequest();

  @Post(path: EndPoint.serviceRequestCreate)
  Future<Response> serviceRequestCreate(@Body () Map body);



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
