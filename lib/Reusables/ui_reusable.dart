import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class ReusableCard extends StatelessWidget {
  final Color colour;
  final String name;
  final Function onPressed;
  final Widget cardChild;

  ReusableCard({this.colour, this.cardChild, this.onPressed, this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: cardChild,
        height: 150,
        width: 150,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class GetDataTable extends StatelessWidget {
  final Function onTap;
  GetDataTable({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onTap,
        child: DataTable(
          headingRowHeight: 25,
          dataRowHeight: 45,
          horizontalMargin: 0,
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Ref-Number',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
            ),
            DataColumn(
              label: Text(
                'Department',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('{}')),
                DataCell(Text('IT Department')),
                DataCell(Text('Awaiting')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExpansionList extends StatefulWidget {
  final String name;
  final IconData icon;
  final Function onTap;
  ExpansionList(
      {@required this.name, @required this.icon, @required this.onTap});
  @override
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        animationDuration: Duration(milliseconds: 200),
        expansionCallback: (index, expanded) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, expanded) {
              return ListTile(
                leading: Icon(widget.icon),
                title: Text(widget.name),
              );
            },
            isExpanded: isExpanded,
            body: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.navigate_next),
                  title: Text("Request"),
                  onTap: widget.onTap,
                ),
                ListTile(
                  leading: Icon(Icons.navigate_next),
                  title: Text(" Cancelled Request"),
                ),
              ],
            ),
          ),
        ]);
  }
}

class Requestpage extends StatefulWidget {
  final String hint;
  final String title;
  bool readOnly;
  Function onchanged;
  TextEditingController controller;
  Requestpage({this.title, this.hint, this.readOnly,this.onchanged, this.controller});
  @override
  _RequestpageState createState() => _RequestpageState();
}

class _RequestpageState extends State<Requestpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            shape: BoxShape.rectangle,
            color: Colors.white,
          ),
          height: 50.0,
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onchanged,
            readOnly: widget.readOnly,

            validator: (e) {
              if (e.isEmpty) {
                return "Field cannot be empty";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              contentPadding: EdgeInsets.only(top: 14.0),
            ),
          ),
        ),
      ],
    );
  }
}
void showLoadingIndicator({@required status}) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.purple
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.purple
    ..textColor = Colors.purple
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.show(status: status);
}
