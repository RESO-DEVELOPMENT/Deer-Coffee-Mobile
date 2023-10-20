import 'package:deer_coffee/view_models/base_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../utils/route_constrant.dart';

class AccountViewModel extends BaseViewModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  String? phoneNumber;
  var verId = '';
  int? resendTok = 0;
  var receivedID = '';
  AccountViewModel() {
    auth = FirebaseAuth.instance;
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
          // final userInfo = await signIn(userCredential);
          // hideDialog();
          // // TODO: Kiem tra xem user moi hay cu
          // if (userInfo.isFirstLogin) {
          //   // Navigate to sign up screen
          //   await Get.offAllNamed(RouteHandler.SIGN_UP, arguments: userInfo);
          // } else {
          //   await Get.offAllNamed(RouteHandler.NAV);
          //   // chuyen sang trang home
          // }
        } catch (e) {
          await showAlertDialog(
              title: "Xảy ra lỗi", content: e.toString() ?? 'Lỗi');
          Get.back();
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        await showAlertDialog(title: "Xảy ra lỗi", content: e.message ?? 'Lỗi');
        Get.back();
      },
      codeSent: (String verificationId, int? resendToken) async {
        print(verificationId);
        print(resendToken ?? 0);
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

  Future<void> verifyOTPCode(code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: code,
    );
    try {
      showLoadingDialog();
      await auth.signInWithCredential(credential).then((value) => {
            userCredential = value,
            print(
                'User Login In Successful ${userCredential?.user?.phoneNumber ?? ""}')
          });

      await Get.offAllNamed(RouteHandler.HOME);
      // final userInfo = await signIn(userCredential);
      // hideDialog();
      // // TODO: Kiem tra xem user moi hay cu
      // if (userInfo.isFirstLogin) {
      //   // Navigate to sign up screen
      //   await Get.offAllNamed(RouteHandler.SIGN_UP, arguments: userInfo);
      // } else {
      //   await Get.offAllNamed(RouteHandler.NAV);
      //   // chuyen sang trang home
      // }
    } catch (e) {
      await showAlertDialog(
          title: "Xảy ra lỗi", content: e.toString() ?? 'Lỗi');
      // Get.back();
    }
  }
}
