import 'package:after_layout/after_layout.dart';
import 'package:chopper/chopper.dart';
import 'package:driver_salary/Reusables/custom_dialog.dart';
import 'package:driver_salary/inventory_page/multiple_stock_req.dart';
import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/provider/service_request.dart';
import 'package:driver_salary/provider/stock_request.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import '../authentication_service.dart';
import 'Create_new_request.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>
    with AfterLayoutMixin<InventoryPage> {
  AuthenticationClient get authClient => GetIt.I<AuthenticationClient>();
  StockRequestProvider stockProvider;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 10,
          title: Text('Stock Request',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
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
              Tab(
                icon: Icon(Icons.assignment_turned_in),
                text: "Issued",
              ),
            ],
          ),
        ),
        body: Stack(children: [
          TabBarView(
            children: [
              TaskList(listType: 0),
              TaskList(listType: 1),
              TaskList(
                listType: 2,
              ),
              TaskList(
                listType: 3,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: provider.Consumer<StockRequestProvider>(
              builder: (context, stock, child) =>
              (stock.selectedAwaitingVerification.isEmpty &&
                  stock.selectedAwaitingApproval.isEmpty &&
                  stock.selectedAwaitingIssue.isEmpty)
                  ? SizedBox()
                  : ElevatedButton(
                child: Text("Multiple"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultipleStockRequestPage(),
                  ),
                ),
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateRequest())).then((value) => boot(context));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  void boot(context){
    stockProvider =
        provider.Provider.of<StockRequestProvider>(context, listen: false);
    stockProvider.checkClaims();
    stockProvider.approvedList.clear();
    stockProvider.verifiedList.clear();
    stockProvider.pendingList.clear();
    stockProvider.issuedList.clear();
    stockProvider.getAllinventory();
    stockProvider.selectedAwaitingVerification.clear();
    stockProvider.selectedAwaitingApproval.clear();
    stockProvider.selectedAwaitingIssue.clear();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    boot(context);

  }
}

class TaskList extends StatelessWidget {
  final int listType;

  TaskList({this.listType});
  StockRequestProvider stock;
  List<InventoryItems> taskList = [];
  @override
  Widget build(BuildContext context) {
    return provider.Consumer<StockRequestProvider>(
      builder: (context, stock, child) {
        switch (listType) {
          case 0:
            {
              taskList = stock.pendingList;
            }
            break;
          case 1:
            {
              taskList = stock.verifiedList;
            }
            break;
          case 2:
            {
              taskList = stock.approvedList;
            }
            break;
          case 3:
            {
              taskList = stock.issuedList;
            }
            break;
        }
        return (stock.status == Loading.loading)
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
                    await buildShowDialog(
                        context,
                        taskList[index],
                        stock.haveAccessToApproveRequest,
                        stock.haveAccessToVerifyRequest,
                        stock.haveAccessToissueRequest);
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (listType == 3)
                            ? SizedBox()
                            : Checkbox(
                            onChanged: (bool newvalue) {
                              if (newvalue) {
                                stock.editAwaitingVerification(
                                    index, 1, listType);
                              } else {
                                stock.editAwaitingVerification(
                                    index, 0, listType);
                              }
                              print(stock
                                  .selectedAwaitingVerification);
                            },
                            value: (stock.boolValueType(
                                listType, taskList[index].id))),

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
                                    : (taskList[index].isIssued ||
                                    taskList[index]
                                        .isApproved &&
                                        taskList[index]
                                            .isVerified)
                                    ? Colors.purple
                                    : Colors.orange),
                          ),
                          title: Text(taskList[index].itemName),
                          subtitle: Text(taskList[index].driverName),
                          trailing:
                          Text(taskList[index].vehicleRegName),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
