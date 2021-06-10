import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/model/user.dart';
import 'package:shopping_phone/app/routes/app_pages.dart';
import 'package:shopping_phone/app/ui/page/authentication/auth.dart';

import '../constants/firebase.dart';
import '../utils/showLoading.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;
  RxInt count = 0.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cfpassword = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAll(() => AuthenticationScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAllNamed(Routes.INITIAL);
    }
  }

  void goScreen() {
    Get.offAndToNamed(Routes.INITIAL);
  }

  void signIn() async {
    if (password.text.trim().isEmpty || email.text.trim().isEmpty) {
      Get.snackbar("Lỗi!", "Bạn cần nhập đủ thông tin");
    } else {
      showLoading();
      try {
        await auth
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim())
            .then((result) {
          _clearControllers();
        });
      } catch (e) {
        print("crthang login" + e.toString());
        Get.snackbar("Sign In Failed", e.toString());
      }
    }
  }

  void signUp() async {
    showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
      });
      Get.back();
      goScreen();
    } catch (e) {
      Get.back();
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", e.toString());
      // Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signOut() async {
    auth.signOut();
    goScreen();
    Get.snackbar("Thông báo", "Đăng xuất thành công");
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "cart": []
    });
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  void changePassword() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User currentUser = firebaseAuth.currentUser;
    currentUser.updatePassword('${password.text.trim()}').then((_) {
      Get.snackbar("Thông báo", "Chỉnh sửa thành công");
    }).catchError((err) {
      Get.snackbar("Thông báo", "Thất bại" + err.toString());
    });
    password.clear();
    cfpassword.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() {
    return firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .snapshots()
        .map((snapshot) {
      count = RxInt(UserModel.fromSnapshot(snapshot).cart.length);
      print("crthang Hello user: ${UserModel.fromSnapshot(snapshot).email}");
      print("crthang Giỏ hàng: $count");

      update();
      return UserModel.fromSnapshot(snapshot);
    });
  }
}
