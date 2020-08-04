
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DialogType { error, success }

class CustomWidget {
  static InputDecoration getInputDeco(String hint) {
    return InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  labelText: hint,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 20),
                                  labelStyle: TextStyle(
                                    color: Colors
                                        .grey, //This is an example of a change
                                  ),);
                        
  }

  static String getNairaSign() {
    return "₦";
  }

  static Future<void> showCustomDialog(DialogType type, BuildContext context,
      String message, String actionText, VoidCallback onClose) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0,
            contentPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            content: Container(
              width: double.infinity,
//              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        transform: Matrix4.translationValues(0, 50, 0),
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10),
//                    color: Colors.orange,
//                    padding: EdgeInsets.(: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 15.0,
                                  top: 60),
                              child: Text(
                                message,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.elasticInOut,
                        tween: Tween<double>(begin: 10, end: 0),
                        builder: (__, value, child) {
                          return Container(
                            transform: Matrix4.translationValues(0, value, 0),
                            child: child,
                          );
                        },
                        child: Image.asset(
                          (type == DialogType.success)
                              ? 'assets/images/confirmed.PNG'
                              : "assets/images/denied.PNG",
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    transform: Matrix4.translationValues(0, 50, 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                          padding: EdgeInsets.all(10),
                          onPressed: onClose,
                          color: (type == DialogType.success)
                              ? Color(0XFF009845)
                              : Colors.red,
                          child: Text(
                            actionText,
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Widget ProfileItemTile(String label, String value) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
            child: Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 7),
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          )
        ],
      ),
    );
  }

  static AppBar getAppBar(BuildContext context, String title, bool hasBack,
      {double elevation = 5, dynamic returnValue}) {
    return AppBar(
        automaticallyImplyLeading: hasBack,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        elevation: elevation,
        backgroundColor: Colors.white,
        leading: (hasBack)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => Navigator.pop(context, returnValue),
              )
            : SizedBox());
  }

  static Color getColor(int type) {
    if (type == Constants.available) {
      return Colors.grey[400];
    } else if (type == Constants.selected) {
      return Colors.green[800];
    } else {
      return Colors.red[600];
    }
  }

  static String formatMoney(double amount, {bool floor = false}) {
    return NumberFormat.currency(symbol: "₦", decimalDigits: (floor) ? 0 : 2)
        .format(amount);
  }
}
class CustomCheckBox extends StatefulWidget {
  CustomCheckBox({this.value, this.title, this.center, this.onChange(bool e)});

  final bool value;
  final String title;
  final Function onChange;
  final bool center;

  @override
  State<StatefulWidget> createState() {
    return CheckBox(value, title, center, onChange);
  }
}

class CheckBox extends State<CustomCheckBox> {
  CheckBox(this.value, this.title, this.center, this.onChange(bool e));

  bool value;
  String title;
  Function onChange;
  bool center;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return view();
  }

  Widget view() {
    if (center == null) {
      center = false;
    }
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment:
            (center) ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            activeColor: Colors.grey[800],
            value: value,
            onChanged: (e) {
              setState(() {
                value = e;
              });
              onChange(e);
              //v(e);
            },
          ),
          //default value here is empty and when changed, we make a function for enabling repeated trips
          Text(
            title,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class CustomClipperOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: new Offset(size.width / 2, size.width / 2),
        radius: size.width / 2 + 3);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ClipOvalShadow extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;
  final Widget child;

  ClipOvalShadow({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipOvalShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipRect(child: child, clipper: this.clipper),
    );
  }
}

class _ClipOvalShadowPainter extends CustomPainter {
  _ClipOvalShadowPainter({@required this.shadow, @required this.clipper});

  final Shadow shadow;
  final CustomClipper<Rect> clipper;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipRect = clipper.getClip(size).shift(Offset(0, 0));
    canvas.drawOval(clipRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Constants {
  static const int available = 1;
  static const int booked = 2;
  static const int selected = 3;
}

Route createRoute(Widget page, String routeName) {
  print(routeName);
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
     );
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0, 5);
    path.arcToPoint(Offset(5, 0), radius: Radius.circular(5));
    path.lineTo(width - 5, 0);
    path.arcToPoint(Offset(width, 5), radius: Radius.circular(5));
    path.lineTo(width, height * .45);
    path.arcToPoint(Offset(width, height * .55),
        clockwise: false, radius: Radius.circular(30));
    path.lineTo(width, height - 5);
    path.arcToPoint(Offset(width - 5, height), radius: Radius.circular(5));
    path.lineTo(5, height);
    path.arcToPoint(Offset(0, height - 5), radius: Radius.circular(5));
    path.lineTo(0, height * .55);
    path.arcToPoint(Offset(0, height * .45),
        clockwise: false, radius: Radius.circular(30));
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ColorUtils {
  static const Color app_green = Color(0xFF00A85A);
  static const Color grey_background = Color(0xFFFAFAFA);

//  TextDecoration inputDeco = Decoration();
//  static const Color app_green = Color(0xFF00A85A);
//  static const Color app_green = Color(0xFF00A85A);
//  static const Color app_green = Color(0xFF00A85A);

}
