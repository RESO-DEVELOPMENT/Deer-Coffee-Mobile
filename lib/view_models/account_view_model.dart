import 'package:deer_coffee/api/account_api.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/membership_model.dart';
import 'package:deer_coffee/models/user_create.dart';
import 'package:deer_coffee/utils/request.dart';
import 'package:deer_coffee/view_models/base_view_model.dart';
import 'package:deer_coffee/view_models/startup_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../api/pointify/pointify_data.dart';
import '../models/user.dart';
import '../utils/route_constrant.dart';
import '../utils/share_pref.dart';

class AccountViewModel extends BaseViewModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  AccountAPI accountAPI = AccountAPI();
  PointifyData? pointifyData = PointifyData();
  UserModel? user;
  UserDetails? memberShipModel;
  String? phoneNumber;
  var verId = '';
  int? resendTok = 0;
  var receivedID = '';
  AccountViewModel() {
    auth = FirebaseAuth.instance;
    getUserInfo().then((value) => user = value);
  }
  Future<void> onLoginWithPhone(String phone) async {
    showLoadingDialog();
    phoneNumber = phone;
    auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth
              .signInWithCredential(credential)
              .then((value) => userCredential = value);
          await Get.offAllNamed(RouteHandler.HOME);
        } catch (e) {
          await showAlertDialog(
              title: "Xảy ra lỗi", content: e.toString() ?? 'Lỗi');
          Get.back();
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        await showAlertDialog(
            title: "Lỗi đăng nhập", content: e.message ?? 'Lỗi');
        Get.back();
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (kDebugMode) {
          print(verificationId);
          print(resendToken ?? 0);
        }
        receivedID = verificationId;
        resendTok = resendToken;
        await Get.offNamed(
          RouteHandler.OTP,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verId = verificationId;
      },
    );
  }

  Future<void> resendOtp() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth
              .signInWithCredential(credential)
              .then((value) => userCredential = value);
          await Get.offAllNamed(RouteHandler.HOME);
        } catch (e) {
          await showAlertDialog(
              title: "Xảy ra lỗi", content: e.toString() ?? 'Lỗi');
          Get.back();
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        await showAlertDialog(
            title: "Lỗi đăng nhập", content: e.message ?? 'Lỗi');
        Get.back();
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (kDebugMode) {
          print(verificationId);
          print(resendToken ?? 0);
        }
        receivedID = verificationId;
        resendTok = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verId = verificationId;
      },
    );
  }

  Future<void> verifyOTPCode(code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: code,
    );
    try {
      showLoadingDialog();
      await auth.signInWithCredential(credential).then((value) => {
            userCredential = value,
          });

      String? token = await auth.currentUser?.getIdToken();
      await accountAPI.signIn(token ?? '').then((value) => user = value);
      if (user == null || user?.userInfo == null) {
        showAlertDialog(
            title: 'Lỗi đăng nhập',
            content: user?.message ?? 'Đăng nhập không thành công');
        return;
      } else {
        requestObj.setToken = user?.accessToken ?? '';
        await setUserInfo(user!);
        await setToken(user!.accessToken ?? '');
        await Get.offAllNamed(RouteHandler.HOME);
      }
    } catch (e) {
      await showAlertDialog(
          title: "Xảy ra lỗi", content: e.toString() ?? 'Lỗi');
      // Get.back();
    }
  }

  Future<void> getMembershipInfo() async {
    try {
      setState(ViewStatus.Loading);
      if (user?.userInfo != null) {
        await accountAPI
            .getUserById(user?.userInfo?.id ?? '')
            .then((value) => memberShipModel = value);
      }
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi", content: e.toString());
    }
  }

  Future<void> processSignOut() async {
    var option = await showConfirmDialog();
    if (option == true) {
      showLoadingDialog();
      user = null;
      memberShipModel = null;
      await auth.signOut();
      await removeALL();
      await Get.find<StartUpViewModel>().handleStartUpLogic();
      hideDialog();
    }
  }

  Future<void> updateUser(UserUpdate user, String id) async {
    showLoadingDialog();
    var res = await accountAPI.updateUser(id, user);
    memberShipModel = await accountAPI.getUserById(id);
    hideDialog();
    await showAlertDialog(content: res);
  }
}
