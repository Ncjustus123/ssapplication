import 'package:driver_salary/Reusables/custom_dialog.dart';
import 'package:driver_salary/inventory_page/service_request.dart';
import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/provider/service_request.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:after_layout/after_layout.dart';
import '../authentication_service.dart';
import 'multiple_service_req.dart';


class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage>
    with AfterLayoutMixin<ServicePage> {
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();

  ServiceRequestProvider serviceProvider;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Service Request'),
          backgroundColor: Colors.purple,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pending_actions),
                text: "Pending",
              ),
              Tab(
                icon: Icon(Icons.done),
                text: "Verified",
              ),
              Tab(
                icon: Icon(Icons.done_all_sharp),
                text: "Approved",
              ),
            ],
          ),
        ),
        body: Stack(children: [
          TabBarView(
            children: [
              TaskList(listType: 0),
              TaskList(listType: 1),
              TaskList(listType: 2),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: provider.Consumer<ServiceRequestProvider>(
                builder: (context, service, child) => (service
                    .selectedAwaitingApproval.isEmpty &&
                    service.selectedAwaitingVerification.isEmpty)
                    ? SizedBox()
                    : ElevatedButton(
                  child: Text("multiple"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleServiceRequestPage(),
                    ),
                  ),
                )),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ServiceRequestPage())).then((value) => boot(context)),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void boot(context){
    serviceProvider =
        provider.Provider.of<ServiceRequestProvider>(context, listen: false);
    serviceProvider.checkClaims();
    serviceProvider.approvedList.clear();
    serviceProvider.verifiedList.clear();
    serviceProvider.pendingList.clear();
    serviceProvider.getServiceRequest();
    serviceProvider.selectedAwaitingVerification.clear();
    serviceProvider.selectedAwaitingApproval.clear();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    boot(context);
  }
}



class TaskList extends StatelessWidget {
  final int listType;

  TaskList({this.listType});

  ServiceRequestProvider service;
  List<InventoryItems> taskList = [];
  @override
  Widget build(BuildContext context) {
    return provider.Consumer<ServiceRequestProvider>(
      builder: (context, service, child) {
        switch (listType) {
          case 0:
            {
              //pendinglist
              taskList = service.pendingList;
            }
            break;
          case 1:
            {
              //verifiedList
              taskList = service.verifiedList;
            }
            break;
          case 2:
            {
              //approved List
              taskList = service.approvedList;
            }
            break;
        }
        return (service.status == Loading.loading)
            ? Center(
          child: CircularProgressIndicator(),
        )
            : (taskList.isEmpty)
            ? Center(
            child: Text(
                "This list is empty, you can pull to refresh to fetch latest"))
            : ListView.builder(
          itemCount: taskList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: InkWell(
                onTap: () async {
                  await buildShowDialog1(
                      context,
                      taskList[index],
                      service.haveAccessToApproveRequest,
                      service.haveAccessToVerifyRequest);
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (listType == 2)
                          ? SizedBox()
                          : Checkbox(
                          onChanged: (bool newvalue) {
                            if (newvalue) {
                              service.editAwaitingVerification(
                                  index, 1, listType);
                            } else {
                              service.editAwaitingVerification(
                                  index, 0, listType);
                            }
                            print("object");
                            print(service
                                .selectedAwaitingVerification);
                            print("object2");
                            print(service
                                .selectedAwaitingApproval);
                          },
                          value: service.boolValueType(
                              listType, taskList[index].id)),
                      // InkWell(
                      // child:
                      ListTile(
                        leading: Text(
                          DateFormat.yMMMd().format(DateTime.parse(
                              taskList[index].requestDate)),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (taskList[index].isApproved &&
                                  taskList[index].isVerified)
                                  ? Colors.greenAccent[700]
                                  : (taskList[index].isVerified &&
                                  !taskList[index].isApproved)
                                  ? Colors.blue[900]
                                  : Colors.orange),
                        ),
                        title: Text(taskList[index].requestedBy),
                        subtitle: Text(taskList[index].note ?? ""),
                        trailing:
                        Text(taskList[index].departmentName),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
