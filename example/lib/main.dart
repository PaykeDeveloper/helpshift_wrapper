import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpshift_wrapper/helpshift_wrapper.dart';
import 'package:helpshift_wrapper_example/src/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupHelpShiftSdk();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

/// configure HelpShift SDK for Native Platforms
void setupHelpShiftSdk() async {
  await HelpshiftWrapper.setUpHelpShiftSDK(
    helpShiftApiKey: Constants.helpShiftApiKey(),
    helpShiftAppId: Constants.helpShiftAppId(),
    helpShiftDomain: Constants.helpShiftDomain,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userNameCtrl = TextEditingController();
  final userIdCtrl = TextEditingController();
  final userEmailCtrl = TextEditingController();
  final languageCtrl = TextEditingController();
  var isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HelpShift Wrapper'),
          centerTitle: true,
          actions: isLoggedIn
              ? [
                  InkWell(
                    onTap: () async {
                      var result = await HelpshiftWrapper.logoutUser();
                      if (result == true) {
                        setState(() {
                          isLoggedIn = false;
                        });
                      }
                    },
                    child: const Icon(Icons.logout),
                  )
                ]
              : [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              isLoggedIn == false
                  ? loginWidget(context)
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    HelpshiftWrapper.showAllConversation(
                        configMap: getConfigmap());
                  },
                  child: const Text('Show All Conversation'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.showAllConversation(
                      configMap: setMetadata());
                },
                child: const Text('Show All Conversation'),
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.openFAQsScreen(configMap: setMetadata());
                },
                child: const Text('FAQs'),
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.openSingleFAQScreen(
                      sectionId: "1", configMap: getConfigmap());
                },
                child: const Text('Order FAQs'),
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.openSingleFAQScreen(
                      sectionId: "2", configMap: getConfigmap());
                },
                child: const Text('Returns and Exchanges FAQs'),
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.openSingleFAQScreen(
                      sectionId: "3", configMap: getConfigmap());
                },
                child: const Text('Shipping and Delivery FAQs'),
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.openSingleFAQScreen(
                      sectionId: "4", configMap: getConfigmap());
                },
                child: const Text('Payment FAQs'),
              ),
              ElevatedButton(
                onPressed: () {
                  HelpshiftWrapper.openSinglePublishedFAQDetail(
                      publishId: "8", configMap: getConfigmap());
                },
                child: const Text('What Payment Methods do you accept?'),
              ),
              const SizedBox(height: 20),
              languageWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  loginWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          nameLabelUiWidget("User Name", userNameCtrl, TextInputType.name),
          const SizedBox(height: 20),
          nameLabelUiWidget("User Id", userIdCtrl, TextInputType.text),
          const SizedBox(height: 20),
          nameLabelUiWidget(
              "User Email", userEmailCtrl, TextInputType.emailAddress),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  var userName = userNameCtrl.text.trim();
                  var userId = userIdCtrl.text.trim();
                  var userEmail = userEmailCtrl.text.trim();
                  dynamic result;
                  if (validationUserDetail(context)) {
                    result = await HelpshiftWrapper.loginUser(
                      userId: userId ?? "",
                      email: userEmail ?? "",
                      userName: userName ?? "",
                    );
                  }

                  userEmailCtrl.clear();
                  userIdCtrl.clear();
                  userEmailCtrl.clear();

                  if (kDebugMode) {
                    print('result $result');
                  }
                  if (result == true) {
                    setState(() {
                      isLoggedIn = true;
                    });
                  }
                },
                child: const Text('Login')),
          )
        ],
      ),
    );
  }

  nameLabelUiWidget(label, ctrl, inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextField(
              controller: ctrl,
              keyboardType: inputType,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your $label",
                  fillColor: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  languageWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          nameLabelUiWidget("Language", languageCtrl, TextInputType.text),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  var language = languageCtrl.text.trim();
                  final result = await HelpshiftWrapper.setLanguage(
                    language: language ?? "",
                  );

                  languageCtrl.clear();

                  if (kDebugMode) {
                    print('result $result');
                  }
                },
                child: const Text('Set language')),
          )
        ],
      ),
    );
  }

  /// setup your config map according to your need
  getConfigmap() {
    Map<String, dynamic> config = {};
    // set tags for tracking
    config["tags"] = ["foo", "bar"];

    // set custom issue fields
    var cifMap = {};
    var isPro = {};
    isPro["type"] = "boolean";
    isPro["value"] = "true";
    cifMap["is_pro"] = isPro;

    config["customIssueFields"] = cifMap;

    return config;
  }

  /// setup your customIssueFiled Map
  getCustomIssueFieldMap() {
    var joiningDate = {};
    joiningDate["type"] = "date";
    joiningDate["value"] = 1505927361535;

    var stockLevel = {};
    stockLevel["type"] = "number";
    stockLevel["value "] = "1505";

    var employeeName = {};
    employeeName["type"] = "singleline";
    employeeName["value"] = "Bugs helpshift";

    var isPro = {};
    isPro["type"] = "boolean";
    isPro["value"] = "true";

    var cifMap = {};
    cifMap["joining_date"] = joiningDate;
    cifMap["stock_level"] = stockLevel;
    cifMap["employee_name"] = employeeName;
    cifMap["is_pro"] = isPro;

    Map<String, dynamic> config = {};
    config["customIssueFields"] = cifMap;

    return config;
  }

  /// custom metadata
  setMetadata() {
    Map<String, dynamic> config = {};
    var metaMap = {"usertype": "paid"};
    config["customMetadata"] = metaMap;
    return config;
  }

  validationUserDetail(BuildContext context) {
    var userId = userIdCtrl.text.trim();
    var userEmail = userEmailCtrl.text.trim();
    if (userId.isEmpty && userEmail.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter userId or email to login.');
      return false;
    } else {
      return true;
    }
  }
}
