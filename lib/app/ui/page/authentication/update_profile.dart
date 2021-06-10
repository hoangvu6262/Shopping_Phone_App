import 'package:flutter/material.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/ui/page/widgets/custom_btn.dart';
import 'package:get/get.dart';

class UpdateProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("update_profile".tr,
            style: TextStyle(fontSize: 18.0, color: Color(0xFF545D68))),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width / 5),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.withOpacity(.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: TextField(
                            obscureText: true,
                            controller: userController.password,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: "new_password".tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.withOpacity(.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: TextField(
                            obscureText: true,
                            controller: userController.cfpassword,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: "confirm_new_password".tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: CustomButton(
                        text: "update".tr,
                        onTap: () {
                          userController.changePassword();
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
