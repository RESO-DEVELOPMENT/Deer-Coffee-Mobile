import 'package:deer_coffee/api/account_api.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/check_login_model.dart';
import 'package:deer_coffee/models/user_create.dart';
import 'package:deer_coffee/utils/request.dart';
import 'package:deer_coffee/view_models/base_view_model.dart';
import 'package:deer_coffee/view_models/startup_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import '../models/user.dart';
import '../utils/route_constrant.dart';
import '../utils/share_pref.dart';
import 'cart_view_model.dart';

class AccountViewModel extends BaseViewModel {
  // UserCredential? userCredential;
  AccountAPI accountAPI = AccountAPI();
  String? userId;
  UserDetails? memberShipModel;
  String? phoneNumber;
  var verId = '';
  int? resendTok = 0;
  var receivedID = '';
  AccountViewModel() {
    getToken().then((value) => requestObj.setToken = value);
  }

  Future<void> checkUser(String phone) async {
    phoneNumber = phone;
    CheckLoginModel? checkLogin = await accountAPI.checkUser(phone);
    Get.snackbar("Thông báo", checkLogin?.message ?? '');
    await Get.toNamed(
      "${RouteHandler.OTP}?phone=$phone&type=${checkLogin?.signInMethod ?? "SIGNIN"}",
    );
  }

  Future<void> onLogin(String phone, String pin, String type) async {
    showLoadingDialog();
    UserModel? user = await accountAPI.signIn(phone, pin, type);
    if (user == null || user.userId == null) {
      Get.snackbar(
          'Lỗi đăng nhập', user?.message ?? 'Đăng nhập không thành công');
      hideDialog();
      return;
    } else {
      requestObj.setToken = user.accessToken ?? '';
      await setToken(user.accessToken ?? '');
      await getMembershipInfo(user.userId ?? '');
      hideDialog();
      await Get.find<CartViewModel>().getListPromotion();
      Get.snackbar('Thông báo', user.message ?? 'Đăng nhập thành công');
      await Get.offAllNamed(RouteHandler.HOME);
    }
  }

  // Future<void> onLoginWithPhone(String phone) async {
  //   showLoadingDialog();
  //   phoneNumber = phone;
  //   auth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       try {
  //         showLoadingDialog();
  //         await auth.signInWithCredential(credential).then((value) => {
  //               userCredential = value,
  //             });
  //         String? token = await auth.currentUser?.getIdToken();
  //         UserModel? user = await accountAPI.signIn(token ?? '');
  //         if (user == null || user.userInfo == null) {
  //           showAlertDialog(
  //               title: 'Lỗi đăng nhập',
  //               content: user?.message ?? 'Đăng nhập không thành công');
  //           return;
  //         } else {
  //           requestObj.setToken = user.accessToken ?? '';
  //           await setToken(user.accessToken ?? '');
  //           await getMembershipInfo(user.userInfo?.id ?? '');
  //           await Get.find<CartViewModel>().getListPromotion();
  //           hideDialog();
  //           await Get.offAllNamed(RouteHandler.HOME);
  //         }
  //       } catch (e) {
  //         await showAlertDialog(title: "Xảy ra lỗi", content: e.toString());
  //         // Get.back();
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) async {
  //       await showAlertDialog(
  //           title: "Lỗi đăng nhập", content: e.message ?? 'Lỗi');
  //       Get.back();
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       if (kDebugMode) {
  //         print(verificationId);
  //         print(resendToken ?? 0);
  //       }
  //       receivedID = verificationId;
  //       resendTok = resendToken;
  //       await Get.offNamed(
  //         RouteHandler.OTP,
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verId = verificationId;
  //     },
  //   );
  // }

  // Future<void> resendOtp() async {
  //   auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       try {
  //         showLoadingDialog();
  //         await auth.signInWithCredential(credential).then((value) => {
  //               userCredential = value,
  //             });
  //         String? token = await auth.currentUser?.getIdToken();
  //         UserModel? user = await accountAPI.signIn(token ?? '');
  //         if (user == null || user.userInfo == null) {
  //           showAlertDialog(
  //               title: 'Lỗi đăng nhập',
  //               content: user?.message ?? 'Đăng nhập không thành công');
  //           return;
  //         } else {
  //           requestObj.setToken = user?.accessToken ?? '';
  //           await setToken(user.accessToken ?? '');
  //           await getMembershipInfo(user.userInfo?.id ?? '');
  //           await Get.find<CartViewModel>().getListPromotion();
  //           hideDialog();
  //           await Get.offAllNamed(RouteHandler.HOME);
  //         }
  //       } catch (e) {
  //         await showAlertDialog(title: "Xảy ra lỗi", content: e.toString());
  //         // Get.back();
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) async {
  //       await showAlertDialog(
  //           title: "Lỗi đăng nhập", content: e.message ?? 'Lỗi');
  //       Get.back();
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       if (kDebugMode) {
  //         print(verificationId);
  //         print(resendToken ?? 0);
  //       }
  //       receivedID = verificationId;
  //       resendTok = resendToken;
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verId = verificationId;
  //     },
  //   );
  // }

  // Future<void> verifyOTPCode(code) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: receivedID,
  //     smsCode: code,
  //   );
  //   try {
  //     showLoadingDialog();
  //     await auth.signInWithCredential(credential).then((value) => {
  //           userCredential = value,
  //         });
  //     String? token = await auth.currentUser?.getIdToken();
  //     UserModel? user = await accountAPI.signIn(token ?? '');
  //     if (user == null || user.userInfo == null) {
  //       showAlertDialog(
  //           title: 'Lỗi đăng nhập',
  //           content: user?.message ?? 'Đăng nhập không thành công');
  //       return;
  //     } else {
  //       requestObj.setToken = user.accessToken ?? '';
  //       await setToken(user.accessToken ?? '');
  //       await getMembershipInfo(user.userInfo?.id ?? '');
  //       await Get.find<CartViewModel>().getListPromotion();
  //       hideDialog();
  //       await Get.offAllNamed(RouteHandler.HOME);
  //     }
  //   } catch (e) {
  //     await showAlertDialog(title: "Xảy ra lỗi", content: e.toString());
  //   }
  // }

  Future<void> getMembershipInfo(String id) async {
    try {
      setState(ViewStatus.Loading);
      await accountAPI.getUserById(id).then((value) => memberShipModel = value);
      userId = memberShipModel?.id;
      await setUserId(memberShipModel?.id ?? '');
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi", content: e.toString());
    }
  }

  Future<String?> getQRCode() async {
    try {
      setState(ViewStatus.Loading);
      String? qr;
      await accountAPI.getUserQRCode(userId ?? '').then((value) => qr = value);
      setState(ViewStatus.Completed);
      return qr;
    } catch (e) {
      setState(ViewStatus.Completed);
      showAlertDialog(title: "Lỗi", content: e.toString());
      return null;
    }
  }

  Future<void> processSignOut() async {
    var option = await showConfirmDialog();
    if (option == true) {
      showLoadingDialog();
      userId = null;
      memberShipModel = null;
      await removeALL();
      await Get.find<StartUpViewModel>().handleStartUpLogic();
      hideDialog();
    }
  }

  Future<void> refreshUser() async {
    notifyListeners();
  }

  Future<void> updateUser(UserUpdate user, String id) async {
    showLoadingDialog();
    var res = await accountAPI.updateUser(id, user);
    memberShipModel = await accountAPI.getUserById(id);
    hideDialog();
    // await showAlertDialog(content: res);
  }
}
