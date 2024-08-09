import 'dart:convert';
import 'dart:ui';
import 'package:estore/QRView.dart';
import 'package:estore/checkin.dart';
import 'package:estore/deliverscan.dart';
import 'package:estore/home.dart';
import 'package:estore/pickscan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:estore/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:estore/auth/login.dart';

class DriverScreen extends StatefulWidget {
  @override
  _ShoppingScreentate createState() => _ShoppingScreentate();
}

class _ShoppingScreentate extends State<DriverScreen> {
  late PageController _myPage;
  late SharedPreferences sharedPreferences;
  List ads = [];
  int currentPage = 0;
  int bcurrentPage = 0;
  var productdetails;
  var superdetails;
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;
  var bannerdetails;
  var catdetails;
  var stringResponse;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController couponController = new TextEditingController();
  List cartsarray = [];
  List cartsqau = [];
  int subtotal = 0;
  int total = 0;
  int discount = 0;
  String oproduct = "";
  List _ch = ["Check In", "Check Out", "Mumbai"];
  int count = 1;
  var ch;
  int dcharge = 0;
  var enquiryValue = 'Day after tomorrow';
  static final DateTime now = DateTime.now();

  Future getHttp() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("uid")!;
    http.Response sresponse;
    sresponse = await (http.get(
        Uri.parse(
            'https://molten-topic-379204.el.r.appspot.com/api/streams/gettop'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));
    http.Response bresponse;
    bresponse = await (http.get(
        Uri.parse(
            'https://molten-topic-379204.el.r.appspot.com/api/images/getbanners'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));
    http.Response presponse;
    presponse = await (http.get(
        Uri.parse(
            'https://molten-topic-379204.el.r.appspot.com/api/packages/getbanners'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }));

    http.Response caresponse;
    caresponse = await (http.get(
        Uri.parse(
            'https://molten-topic-379204.el.r.appspot.com/api/category/getcategories'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));
    setState(() {
      productdetails = json.decode(presponse.body);
      bannerdetails = json.decode(bresponse.body);
      superdetails = json.decode(sresponse.body);
      catdetails = json.decode(caresponse.body);
    });
  }

  @override
  void initState() {
    super.initState();

    getHttp();
    _myPage = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Container(
              height: 50,
              width: 50,
              child: Image(
                image: AssetImage("assets/martlogo.png"),
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          // Container(
          //     padding: EdgeInsets.only(top: 20, right: 20),
          //     child: Text(
          //       "+ Cities",
          //       style: TextStyle(color: Colors.grey),
          //     )),
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/driver.png'),
              fit: BoxFit.contain,
            ),
            color: Colors.cyan[100],
          ),
          width: double.infinity,
          child: Column(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/driver.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: Column(
                children: [
                  // Container(
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(13),
                  //   ),
                  //   child: Row(
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               currentPage = 0;
                  //             });
                  //           },
                  //           child: AnimatedContainer(
                  //             duration: Duration(milliseconds: 200),
                  //             margin: EdgeInsets.only(right: 5),
                  //             height: 30,
                  //             width: MediaQuery.of(context).size.width / 4 - 20,
                  //             decoration: BoxDecoration(
                  //               color: currentPage == 0
                  //                   ? Colors.pink[200]
                  //                   : Colors.black,
                  //               borderRadius: BorderRadius.circular(13),
                  //             ),
                  //             child: Align(
                  //                 alignment: Alignment.center,
                  //                 child: Text(
                  //                   "Coins",
                  //                   style:
                  //                   TextStyle(fontSize: 10, color: Colors.black, fontWeight:FontWeight.bold),
                  //                 )),
                  //           ),
                  //         ),
                  //
                  //       ]),
                  // ),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.center,
                      child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          child: Text(
                            "Driver  ",
                          ))),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PickScan()));
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 2, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                            width: 150,
                            height: 50,
                            padding: EdgeInsets.only(top: 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 3),
                                        child: DefaultTextStyle(
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            child: Text(
                                              "Picked ",
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DeliverScan()));
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 2, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                            width: 150,
                            height: 50,
                            padding: EdgeInsets.only(top: 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 3),
                                        child: DefaultTextStyle(
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            child: Text(
                                              "Deliver ",
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () async {
                        String email = emailController.text.trim();
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        var id = sharedPreferences.getString('uid');

                        Map data = {
                          'cid': id,
                          'box': '',
                          'time': DateTime.now().toString(),
                          'status': 'checkout'
                        };

                        var jsonResponse = null;
                        var url = Uri.parse("${BASE_URL}api/dhistory/add");
                        var response = await http.post(url, body: data);
                        if (response.statusCode == 200) {
                          jsonResponse = json.decode(response.body);
                          print(jsonResponse);
                          if (jsonResponse != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CheckInScreen()));

                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(builder: (BuildContext context) => Navigation()),
                            //     (Route<dynamic> route) => false);
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "${json.decode(response.body)}",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          print("The error message is: ${response.body}");
                        }
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 2, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                            width: 150,
                            height: 50,
                            padding: EdgeInsets.only(top: 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 3),
                                        child: DefaultTextStyle(
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            child: Text(
                                              "Check Out ",
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )),
                ],
              ),
            ),
          ]),
        ),
      ));

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: bcurrentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: bcurrentPage == index ? Colors.pink[300] : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Future<void> _showMyDialog(String data) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 40,
              child: Image(
                image: AssetImage("assets/martlogo.png"),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(data),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}