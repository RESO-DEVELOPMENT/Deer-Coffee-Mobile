import 'package:deer_coffee/api/account_api.dart';
import 'package:deer_coffee/enums/view_status.dart';
import 'package:deer_coffee/models/pointify/membership_model.dart';
import 'package:deer_coffee/models/user_create.dart';
import 'package:deer_coffee/utils/request.dart';
import 'package:deer_coffee/view_models/base_view_model.dart';
import 'package:deer_coffee/widgets/other_dialogs/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  MemberShipModel? memberShipModel;
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
                'User Login In Successful ${userCredential?.user?.phoneNumber ?? ""}'),
            print('User Login In Successful ${userCredential ?? ""}')
          });
      // TODO: Kiem tra xem user moi hay cu
      if (userCredential?.additionalUserInfo?.isNewUser ?? false) {
        // Navigate to sign up screen
        UserCreate newUser = UserCreate(
            phoneNunmer: userCredential?.user?.phoneNumber,
            fullName: 'Người dùng',
            gender: 'ORDER',
            fireBaseUid: userCredential?.user?.uid);
        await accountAPI.signUp(newUser).then((value) => user = value);

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
      } else {
        await accountAPI
            .signIn(userCredential?.user?.phoneNumber ?? '',
                userCredential?.user?.uid ?? '')
            .then((value) => user = value);
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

        // chuyen sang trang home
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
      if (user?.userInfo == null) {
      } else {
        await pointifyData
            ?.getMembershipDetails(user?.userInfo?.id ?? '')
            .then((value) => memberShipModel = value);
        setState(ViewStatus.Completed);
      }
    } catch (e) {
      showAlertDialog(title: "Lỗi", content: e.toString());
    }
  }
}
