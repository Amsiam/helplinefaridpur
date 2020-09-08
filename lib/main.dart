import 'package:flutter/material.dart';
import 'package:helplinefaridpur/WebViewPage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = "https://helplinefaridpur.xyz";
  gooo(String title, String link) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebPageView(
          title: title,
          url: url + link,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Line Faridpur"),
        elevation: 0,
      ),
      body: Builder(builder: (context) {
        return WebView(
          initialUrl: "https://helplinefaridpur.xyz",
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            print(request);
            if (request.url.contains("mailto:")) {
              launch(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("tel:")) {
              launch(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("facebook.com")) {
              launch(request.url);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        );
      }),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Container()),
            ListTile(
              leading: Icon(Icons.airport_shuttle),
              title: Text("Ambulance Service"),
              onTap: () => gooo("Ambulance Service", "/ambulance/"),
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
                  onTap: () => gooo("O+ Blood", "/oও-পজেটিভ-রক্ত-ধারীদের-তাল/"),
                ),
                ListTile(
                  title: Text("O-"),
                  onTap: () => gooo("O- Blood", "/o-ও-নেগেটিভ-রক্তযোদ্ধাদের/"),
                ),
                ListTile(
                  title: Text("A+"),
                  onTap: () =>
                      gooo("A+ Blood", "/a-এ-পজেটিভ-রক্ত-যোদ্ধাদের-ত/"),
                ),
                ListTile(
                  title: Text("A-"),
                  onTap: () => gooo("A- Blood", "/a-এ-নেগেটিভ-রক্ত-যোদ্ধাদের/"),
                ),
                ListTile(
                  title: Text("B+"),
                  onTap: () => gooo("B+ Blood", "/b-বি-পজেটিভ-রক্ত-যোদ্ধাদের/"),
                ),
                ListTile(
                  title: Text("B-"),
                  onTap: () => gooo("B- Blood", "/b-বি-নেগেটিভ-রক্ত-যোদ্ধাদে/"),
                ),
                ListTile(
                  title: Text("AB+"),
                  onTap: () =>
                      gooo("AB+ Blood", "/ab-এবি-পজেটিভ-রক্ত-যোদ্ধাদে/"),
                ),
                ListTile(
                  title: Text("AB-"),
                  onTap: () =>
                      gooo("Ab- Blood", "/ab-এবি-নেগেটিভ-রক্ত-যোদ্ধাদ/"),
                ),
                ListTile(
                  title: Text("Be a Doner"),
                  onTap: () => gooo("Be a Doner", "/edit-profile/"),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.local_library_rounded),
              title: Text("Book Shop"),
              children: [
                ListTile(
                  title: Text("Buy Book"),
                  onTap: () => gooo("Buy Book", "/buybook/"),
                ),
                ListTile(
                  title: Text("Sell Book"),
                  onTap: () => gooo("Sell Book", "/sellbook/"),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.local_hospital),
              title: Text("Doctor List"),
              children: [
                ListTile(
                  title: Text("মেডিসিন"),
                  onTap: () => gooo("মেডিসিন", "/মেডিসিন/"),
                ),
                ListTile(
                  title: Text("চর্মরোগ বিশেষজ্ঞ/ডাক্তার দের তালিকা"),
                  onTap: () =>
                      gooo("চর্মরোগ বিশেষজ্ঞ/ডাক্তার দের তালিকা", "/skin/"),
                ),
                ListTile(
                  title: Text("নিউরোলজিস্ট দের তালিকা"),
                  onTap: () => gooo("নিউরোলজিস্ট দের তালিকা", "/nuro/"),
                ),
                ListTile(
                  title: Text("গাইনোকলজিস্ট দের তালিকা"),
                  onTap: () =>
                      gooo("গাইনোকলজিস্ট দের তালিকা", "/গাইনোকলজিস্ট/"),
                ),
                ListTile(
                  title: Text("চক্ষু ডাক্তার দের তালিকা"),
                  onTap: () => gooo("চক্ষু ডাক্তার দের তালিকা", "/391-2/"),
                ),
                ListTile(
                  title: Text("নাক কান গলা বিশেষজ্ঞ"),
                  onTap: () => gooo("নাক কান গলা বিশেষজ্ঞ", "/নাক-কান-গলা/"),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.school),
              title: Text("Tuition Corner"),
              children: [
                ListTile(
                  title: Text("Join as a tutor"),
                  onTap: () => gooo("Join as a tutor", "/joinsir/"),
                ),
                ListTile(
                  title: Text("Find a tutor"),
                  onTap: () => gooo("Find a tutor", "/findsir/"),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.home),
              title: Text("To-Let Corner"),
              children: [
                ListTile(
                  title: Text("মেসে সিট খালি আছে বিজ্ঞাপণ দিন"),
                  onTap: () => gooo("মেসে সিট খালি আছে বিজ্ঞাপণ দিন", "/mess/"),
                ),
                ListTile(
                  title: Text("ফ্লাট বাসা ভাড়ার বিজ্ঞাপণ"),
                  onTap: () => gooo("ফ্লাট বাসা ভাড়ার বিজ্ঞাপণ", "/tolet/"),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.drive_eta),
              title: Text("Transport Service"),
              children: [
                ListTile(
                  title: Text("মাইক্রো বাসের তালিকা"),
                  onTap: () => gooo("মাইক্রো বাসের তালিকা", "/micro/"),
                ),
                ListTile(
                  title: Text("চালক হিসেবে নিবন্ধন করুন"),
                  onTap: () => gooo("চালক হিসেবে নিবন্ধন করুন", "/driver/"),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.perm_phone_msg),
              title: Text("জরুরী নাম্বারের তালিকা"),
              onTap: () => gooo("জরুরী নাম্বারের তালিকা", "/emergency/"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About us"),
              onTap: () => gooo("About Us", "/aboutus/"),
            ),
          ],
        ),
      ),
    );
  }
}
