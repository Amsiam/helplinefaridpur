import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WebView(),
    );
  }
}

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  InAppWebViewController _webViewController;

  String homeurl = "https://helplinefaridpur.xyz/";

  String url = "https://helplinefaridpur.xyz";

  double progress = 0;

  void gooo(String title, String prefix) {
    _webViewController.loadUrl(url: homeurl + prefix);
  }

  showExitScreen() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirm"),
            content: Text("Do you want to exit?"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.green,
                child: Text("No"),
              ),
              RaisedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                color: Colors.red,
                child: Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var curl = await _webViewController.getUrl();
        if (await _webViewController.canGoBack() && curl != homeurl) {
          _webViewController.goBack();
          return null;
        }
        return showExitScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('HelpLine Faridpur'),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    if (_webViewController != null) {
                      _webViewController.goBack();
                    }
                  },
                ),
                InkWell(
                  child: Icon(Icons.refresh),
                  onTap: () {
                    if (_webViewController != null) {
                      _webViewController.reload();
                    }
                  },
                ),
                InkWell(
                  child: Icon(Icons.arrow_forward),
                  onTap: () {
                    if (_webViewController != null) {
                      _webViewController.goForward();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(2.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : null),
            Expanded(
              child: InAppWebView(
                initialUrl: url,
                shouldOverrideUrlLoading: (controller, request) async {
                  var url = request.url;
                  var uri = Uri.parse(url);
                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunch(url)) {
                      // Launch the App
                      await launch(
                        url,
                      );
                      // and cancel the request
                      return ShouldOverrideUrlLoadingAction.CANCEL;
                    }
                  }

                  return ShouldOverrideUrlLoadingAction.ALLOW;
                },
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                  useShouldOverrideUrlLoading: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Container()),
              ListTile(
                leading: Icon(
                  Icons.airport_shuttle,
                  color: Colors.cyan,
                ),
                title: Text("Ambulance Service"),
                onTap: () {
                  gooo("Ambulance Service", "/ambulance/");
                  Navigator.pop(context);
                },
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.opacity_outlined,
                  color: Colors.red,
                ),
                title: Text("Blood Service"),
                children: [
                  ListTile(
                    title: Text("O+"),
                    onTap: () {
                      gooo("O+ Blood", "/o_positive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("O-"),
                    onTap: () {
                      gooo("O- Blood", "/o_negetive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("A+"),
                    onTap: () {
                      gooo("A+ Blood", "/a_positive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("A-"),
                    onTap: () {
                      gooo("A- Blood", "/a_negetive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("B+"),
                    onTap: () {
                      gooo("B+ Blood", "/b_positive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("B-"),
                    onTap: () {
                      gooo("B- Blood", "/b_negetive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("AB+"),
                    onTap: () {
                      gooo("AB+ Blood", "/ab_positive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("AB-"),
                    onTap: () {
                      gooo("Ab- Blood", "/ab_negetive/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("Be a Doner"),
                    onTap: () {
                      gooo("Be a Doner", "/edit-profile/");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.local_library_rounded,
                  color: Colors.pinkAccent,
                ),
                title: Text("Book Shop"),
                children: [
                  ListTile(
                    title: Text("Buy Book"),
                    onTap: () {
                      gooo("Buy Book", "/buybook/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("Sell Book"),
                    onTap: () {
                      gooo("Sell Book", "/sellbook/");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.local_hospital,
                  color: Colors.red,
                ),
                title: Text("Doctor List"),
                children: [
                  ListTile(
                    title: Text("মেডিসিন"),
                    onTap: () {
                      gooo("মেডিসিন", "/মেডিসিন/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("চর্মরোগ বিশেষজ্ঞ/ডাক্তার দের তালিকা"),
                    onTap: () {
                      gooo("চর্মরোগ বিশেষজ্ঞ/ডাক্তার দের তালিকা", "/skin/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("নিউরোলজিস্ট দের তালিকা"),
                    onTap: () {
                      gooo("নিউরোলজিস্ট দের তালিকা", "/nuro/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("গাইনোকলজিস্ট দের তালিকা"),
                    onTap: () {
                      gooo("গাইনোকলজিস্ট দের তালিকা", "/গাইনোকলজিস্ট/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("চক্ষু ডাক্তার দের তালিকা"),
                    onTap: () {
                      gooo("চক্ষু ডাক্তার দের তালিকা", "/391-2/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("নাক কান গলা বিশেষজ্ঞ"),
                    onTap: () {
                      gooo("নাক কান গলা বিশেষজ্ঞ", "/নাক-কান-গলা/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("দন্ত বিশেষজ্ঞ"),
                    onTap: () {
                      gooo("দন্ত বিশেষজ্ঞদের তালিকা", "/dental/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("বাতজ্বর এর ডাক্তার দের তালিকা"),
                    onTap: () {
                      gooo("বাতজ্বর এর ডাক্তার দের তালিকা", "/raimo/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("মা ও শিশু বিশেষজ্ঞ দের তালিকা"),
                    onTap: () {
                      gooo("মা ও শিশু বিশেষজ্ঞ দের তালিকা", "/mce/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("হাড়জোড় বিশেষজ্ঞ(আর্থোপিডিক্স) দের তালিকা"),
                    onTap: () {
                      gooo("হাড়জোড় বিশেষজ্ঞ(আর্থোপিডিক্স) দের তালিকা",
                          "/artho/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("হৃদরোগ বিশেষজ্ঞ দের তালিকা"),
                    onTap: () {
                      gooo("হৃদরোগ বিশেষজ্ঞ দের তালিকা", "/heart/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("ডায়াবেটিস বিশেষজ্ঞ দের তালিকা"),
                    onTap: () {
                      gooo("ডায়াবেটিস বিশেষজ্ঞ দের তালিকা", "/diebetic/");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.school,
                  color: Colors.black,
                ),
                title: Text("Tuition Corner"),
                children: [
                  ListTile(
                    title: Text("Join as a tutor"),
                    onTap: () {
                      gooo("Join as a tutor", "/joinsir/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("Find a tutor"),
                    onTap: () {
                      gooo("Find a tutor", "/findsir/");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.greenAccent,
                ),
                title: Text("To-Let Corner"),
                children: [
                  ListTile(
                    title: Text("মেসে সিট খালি আছে বিজ্ঞাপণ দিন"),
                    onTap: () {
                      gooo("মেসে সিট খালি আছে বিজ্ঞাপণ দিন", "/mess/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("ফ্লাট বাসা ভাড়ার বিজ্ঞাপণ"),
                    onTap: () {
                      gooo("ফ্লাট বাসা ভাড়ার বিজ্ঞাপণ", "/tolet/");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.drive_eta,
                  color: Colors.amber,
                ),
                title: Text("Transport Service"),
                children: [
                  ListTile(
                    title: Text(
                        "ফরিদপুর থেকে দূরপাল্লার বাসের সময় সূচী ও ফোন নাম্বার"),
                    onTap: () {
                      gooo(
                          "ফরিদপুর থেকে দূরপাল্লার বাসের সময় সূচী ও ফোন নাম্বার",
                          "/bus/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("প্রাইভেট কারের তালিকা ও ফোন নাম্বার"),
                    onTap: () {
                      gooo("প্রাইভেট কারের তালিকা ও ফোন নাম্বার", "/privet/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("মাইক্রো বাসের তালিকা"),
                    onTap: () {
                      gooo("মাইক্রো বাসের তালিকা", "/micro/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("মিনি ট্রাকের তালিকা ও ফোন নাম্বার"),
                    onTap: () {
                      gooo("মিনি ট্রাকের তালিকা ও ফোন নাম্বার", "/mtruck/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("ট্রাকের তালিকা ও ফোন নাম্বার"),
                    onTap: () {
                      gooo("ট্রাকের তালিকা ও ফোন নাম্বার", "/truck/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("ট্রেনের সময় সুচী ও ভাড়া"),
                    onTap: () {
                      gooo("ট্রেনের সময় সুচী ও ভাড়া", "/train/");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("চালক হিসেবে নিবন্ধন করুন"),
                    onTap: () {
                      gooo("চালক হিসেবে নিবন্ধন করুন", "/driver/");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.perm_phone_msg,
                  color: Colors.brown,
                ),
                title: Text("জরুরী নাম্বারের তালিকা"),
                onTap: () {
                  gooo("জরুরী নাম্বারের তালিকা", "/emergency/");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.accessibility_new,
                  color: Colors.purpleAccent,
                ),
                title: Text("Be a Entrepreneur"),
                onTap: () {
                  gooo("Be a Entrepreneur", "/jentra/");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.offline_bolt,
                  color: Colors.indigo,
                ),
                title: Text("Hot Line"),
                onTap: () {
                  gooo("Hot Line", "/hotline/");
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About us"),
                onTap: () {
                  gooo("Hot Line", "/aboutus/");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
