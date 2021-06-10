import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/constants/firebase.dart';
import 'package:shopping_phone/app/routes/app_pages.dart';
import 'package:shopping_phone/app/ui/page/authentication/auth.dart';

class MorePage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('more'.tr),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
                auth.currentUser == null
                    ? 'My Account'
                    : auth.currentUser.email,
                style: Theme.of(context).textTheme.headline6),
            subtitle: auth.currentUser == null
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthenticationScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('Login'))
                : GestureDetector(
                    onTap: () {
                      userController.signOut();
                    },
                    child: Text('Logout')),
            trailing: auth.currentUser != null
                ? InkWell(
                    onTap: () => {Get.toNamed(Routes.UPDATE_PROFILE)},
                    child: Icon(Icons.edit))
                : Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.account_circle),
          ),
          Divider(),
          ListTile(
            title:
                Text('settings'.tr, style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.settings),
            onTap: () {
              Get.defaultDialog(
                title: "settings".tr,
                middleText: "select_language".tr,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.updateLocale(Locale('en', 'US'));
                          Get.back();
                        },
                        child: Center(
                          child: SizedBox.fromSize(
                            size: Size(50, 50), // button width and height
                            child: ClipOval(
                              child: Material(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/icons-usa.png',
                                        width: 50.0, height: 50.0), // icon
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.updateLocale(Locale('vi', 'VN'));
                          Get.back();
                          Get.back();
                        },
                        child: Center(
                          child: SizedBox.fromSize(
                            size: Size(50, 50), // button width and height
                            child: ClipOval(
                              child: Material(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/images/icons-vietnam.png',
                                        width: 50.0,
                                        height: 50.0), // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                onConfirm: () {
                  Get.back();
                },
              );
            },
          ),
          Divider(),
          ListTile(
            title:
                Text('about_us'.tr, style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.info),
            onTap: () {
              Get.defaultDialog(
                title: "about_us".tr,
                middleText: "Contact US",
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: SizedBox.fromSize(
                          size: Size(32, 32), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.blue, // button color
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.call, color: Colors.white), // icon
                                  // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox.fromSize(
                          size: Size(32, 32), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.greenAccent, // button color
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.email_outlined,
                                      color: Colors.white), // icon
                                  // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox.fromSize(
                          size: Size(32, 32), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.red, // button color
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.chat_outlined,
                                      color: Colors.white), // icon
                                  // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                onConfirm: () {
                  Get.back();
                },
              );
            },
          ),
          Divider(),
          ListTile(
            title:
                Text('exist_app'.tr, style: Theme.of(context).textTheme.title),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              Get.defaultDialog(
                  title: "Thông báo",
                  middleText: "Bạn muốn thoát ứng dụng không?",
                  textConfirm: "Ok",
                  textCancel: "No",
                  onConfirm: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  onCancel: () {
                    Get.back();
                  });
            },
          ),
        ],
      ),
    );
  }
}
