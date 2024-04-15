import 'package:deer_coffee/api/account_api.dart';
import 'package:deer_coffee/api/pointify/pointify_data.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/membership_info.dart';
import 'package:deer_coffee/models/user_create.dart';
import 'package:deer_coffee/utils/request.dart';
import 'package:deer_coffee/utils/request_pointify.dart';
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

  PointifyData pointifyData = PointifyData();
  String? userId;
  MembershipInfo? memberShipModel;
  MemberShip? memberShip;
  String? phoneNumber;
  var verId = '';
  int? resendTok = 0;
  var receivedID = '';
  AccountViewModel() {
    getToken().then((value) => requestObj.setToken = value);
    getToken().then((value) => requestPointifyObj.setToken = value);
  }

  Future<void> checkUser(String phone) async {
    phoneNumber = phone;
    num? checkLogin = await accountAPI.checkUser(phone);
    // Get.snackbar("Thông báo", checkLogin?.message ?? '');
    if (checkLogin == 0) {
      await Get.toNamed(
        "${RouteHandler.OTP}?phone=$phone",
      );
    } else if (checkLogin == 1) {
      await Get.toNamed(
        "${RouteHandler.SIGN_UP}?phone=$phone",
      );
    } else {
      await Get.toNamed(
        "${RouteHandler.RESET}?phone=$phone",
      );
    }
  }

  Future<void> onLogin(String phone, String pinCode) async {
    showLoadingDialog();
    MemberShipRespone? membership = await accountAPI.signIn(phone, pinCode);
    if (membership == null || membership.status != 200) {
      await showAlertDialog(
          title: "Lỗi đăng nhập", content: membership?.message ?? '');
      return;
    } else {
      requestPointifyObj.setToken = memberShip?.token ?? '';
      await setToken(membership.data?.token ?? '');
      await getMembershipInfo(membership.data?.userId ?? '');
      hideDialog();
      await Get.find<CartViewModel>().getListPromotion();
      Get.snackbar('Thông báo', membership.message ?? 'Đăng nhập thành công');
      await Get.offAllNamed(RouteHandler.HOME);
    }
  }

  Future<void> onSignUp(String phone, String pinCode, String fullName,
      int gender, String email, String referalPhone) async {
    showLoadingDialog();
    MemberShipRespone? membership = await accountAPI.signUp(
        phone, pinCode, fullName, gender, email, referalPhone);
    if (membership == null || membership.data == null) {
      Get.snackbar(
          'Lỗi đăng ký', membership?.message ?? 'Đăng ký không thành công');
      hideDialog();
      return;
    } else {
      requestPointifyObj.setToken = memberShip?.token ?? '';
      await setToken(membership.data?.token ?? '');
      await getMembershipInfo(membership.data?.userId ?? '');
      hideDialog();
      await Get.find<CartViewModel>().getListPromotion();
      Get.snackbar('Thông báo', membership.message ?? 'Đăng ký thành công');
      await Get.offAllNamed(RouteHandler.HOME);
    }
  }

   Future<void> onResetPassword(String phone, String pinCode) async {
    showLoadingDialog();
    MemberShipRespone? membership = await accountAPI.resetPassword(phone, pinCode);
    if (membership == null || membership.status != 200) {
      await showAlertDialog(
          title: "Lỗi đặt lại mật khẩu", content: membership?.message ?? '');
      return;
    } else {
      requestPointifyObj.setToken = memberShip?.token ?? '';
      await setToken(membership.data?.token ?? '');
      await getMembershipInfo(membership.data?.userId ?? '');
      hideDialog();
      await Get.find<CartViewModel>().getListPromotion();
      Get.snackbar('Thông báo', membership.message ?? 'Thay đổi mật khẩu thành công');
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
      await pointifyData
          .getMembershipInfo(id)
          .then((value) => memberShipModel = value);
      userId = memberShipModel?.membershipId;
      await setUserId(memberShipModel?.membershipId ?? '');
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
    // memberShipModel = await accountAPI.getUserById(id);
    hideDialog();
    // await showAlertDialog(content: res);
  }
}
