import 'package:driver_salary/model/inventoryModel.dart';
import 'package:driver_salary/provider/stock_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;

class MultipleStockRequestPage extends StatelessWidget {
  StockRequestProvider requestProvider;
  @override
  Widget build(BuildContext context) {
    requestProvider = provider.Provider.of<StockRequestProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            multipleRequestPageBody(),
            ElevatedButton(
              child: Text("Submit"),
              onPressed: () {
                requestProvider.multipleRequest(context);
              },
              style: ButtonStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget multipleRequestPageBody() {
    List<Widget> childrenList = [];
    childrenList.add(Container(
      height: 50,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //padding: EdgeInsets.only(left:80),
              color: Colors.blue[900],
              width: 5),
          Expanded(
            child: Text(
              "To Be Verified....",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ));
    for (int id in requestProvider.selectedAwaitingVerification) {
      InventoryItems item = requestProvider.pendingList
          .singleWhere((element) => element.id == id);
      Widget card = ExpandableCard(item);
      childrenList.add(card);
    }
    childrenList.add(Container(
        height: 50,
        color: Colors.grey[100],
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(color: Colors.green, width: 5),
          Expanded(
            child: Text(
              "To Be Approved...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          )
        ])));
    for (int id in requestProvider.selectedAwaitingApproval) {
      InventoryItems item = requestProvider.verifiedList
          .singleWhere((element) => element.id == id);
      childrenList.add(ExpandableCard(item));
    }

    childrenList.add(Container(
      height: 50,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //padding: EdgeInsets.only(left:80),
              color: Colors.purple,
              width: 5),
          Expanded(
            child: Text(
              "To Be Issued...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ));
    for (int id in requestProvider.selectedAwaitingIssue) {
      InventoryItems item = requestProvider.approvedList
          .singleWhere((element) => element.id == id);
      childrenList.add(ExpandableCard(item));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: childrenList,
      ),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  ExpandableCard(this.item);
  final InventoryItems item;
  bool isExpanded = false;
  @override
  _ExpandableCardState createState() => new _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with TickerProviderStateMixin<ExpandableCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          print(isExpanded);
        });
      },
      child: Dismissible(
        key: Key(widget.item.id.toString()),
        onDismissed: (direction) {},
        child: SizedBox(
          width: double.infinity,
          child: Card(
              elevation: 2,
              color: Colors.grey[200],
              child: AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 500),
                child: ConstrainedBox(
                  constraints: isExpanded
                      ? BoxConstraints()
                      : BoxConstraints(maxHeight: 80),
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.item.driverName ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(widget.item.vehicleRegName ?? ""),
                              Text(
                                DateFormat.yMMMd().format(DateTime.parse(
                                    widget.item.requestDate ?? "")),
                                softWrap: isExpanded,
                                overflow: TextOverflow.fade,
                              ),
                              Text(
                                widget.item.description ?? "",
                                softWrap: isExpanded,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
