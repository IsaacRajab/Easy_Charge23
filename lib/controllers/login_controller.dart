import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/admin_master.dart';
import '../models/user_master.dart';
import '../utils/constants/string_constants.dart';
import '../utils/custom_widgets/common_progress.dart';
import '../utils/helpers/common_helper.dart';
import '../utils/helpers/snack_bar_utils.dart';
import '../utils/services/api_service.dart';
import '../utils/helpers/user_pref.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/route_constants.dart';

class LoginController extends GetxController {
  late TextEditingController etEmail;
  late TextEditingController etPassword;

  late FocusNode etEmailFocusNode;
  late FocusNode etPasswordFocusNode;

  RxString userType = StringConstants.USER.obs;

  @override
  void onInit() {
    super.onInit();
    userType.value = Get.arguments;
    initUI();
  }

  void initUI() {
    etEmail = TextEditingController();
    etPassword = TextEditingController();
    etEmailFocusNode = FocusNode();
    etPasswordFocusNode = FocusNode();
  }

  void onTapSignUp() {
    Get.toNamed(RouteConstants.registrationScreen);
  }

  void onPressButtonLogin({
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      userType.value == StringConstants.ADMIN ? _adminLogin() : _userLogin();
    }
  }

  AdminMaster createAdminObject() {
    String emailId = etEmail.text;
    String password = etPassword.text;

    AdminMaster adminMaster = AdminMaster();
    adminMaster.emailId = emailId;
    adminMaster.password = password;

    return adminMaster;
  }

  Future<void> _adminLogin() async {
    try {
      CommonProgressBar.show();

      AdminMaster adminMaster = createAdminObject();
      var jsonResponse = await ApiService.postGetStatus(
        ApiConstants.adminLogin,
        body: adminMaster,
      );
      if (jsonResponse.isNotEmpty) {
        if (jsonResponse.contains("true")) {
          UserPref.setLoginUserType(StringConstants.ADMIN);
          Get.offAllNamed(RouteConstants.dashboardScreen);
        } else if (jsonResponse.contains("false") ||
            jsonResponse.contains("no")) {
          SnackBarUtils.errorSnackBar(
            title: "Failed",
            message: 'Invalid username or password. Please try again later',
          );
        }
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
      SnackBarUtils.errorSnackBar(
        title: "Failed",
        message: "Something went wrong. Please try again later",
      );
    } finally {
      CommonProgressBar.hide();
    }
  }

  Future<void> _userLogin() async {
    try {
      CommonProgressBar.show();
      String emailId = etEmail.text;
      String password = etPassword.text;

      UserMaster adminMaster = UserMaster();
      adminMaster.emailId = emailId;
      adminMaster.password = password;

      var jsonResponse = await ApiService.postLoginAndGetData(
          ApiConstants.userLogin,
          body: adminMaster) as List;

      List<UserMaster> userMasterList =
          jsonResponse.map((e) => UserMaster.fromJson(e)).toList();

      if (userMasterList.isNotEmpty) {
        if (userMasterList[0].status != null) {
          if (userMasterList[0].status!.contains("false") ||
              userMasterList[0].status!.contains("no")) {
            SnackBarUtils.errorSnackBar(
              title: "Error",
              message: 'Invalid username or password. Please try again later',
            );
          } else {
            SnackBarUtils.errorSnackBar(
              title: "Error",
              message: 'Something went wrong. Please try again later',
            );
          }
        } else {
          if (userMasterList[0].userId != null) {
            UserPref.setLoginUserType(StringConstants.USER);
            UserPref.setLoginUserId(userMasterList[0].userId);
            UserPref.setLoginUserName(userMasterList[0].userName);
            Get.offAllNamed(RouteConstants.dashboardScreen);
          } else {
            SnackBarUtils.errorSnackBar(
              title: "Error",
              message: 'Something went wrong. Please try again later',
            );
          }
        }
      } else {
        SnackBarUtils.errorSnackBar(
          title: "Error",
          message: 'Something went wrong. Please try again later',
        );
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
      SnackBarUtils.errorSnackBar(
        title: "Error",
        message: 'Something went wrong. Please try again later',
      );
    } finally {
      CommonProgressBar.hide();
    }
  }
}
