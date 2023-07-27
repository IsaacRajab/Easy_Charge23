import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/route_constants.dart';
import '../utils/constants/string_constants.dart';
import '../utils/custom_widgets/common_dialog.dart';
import '../utils/helpers/user_pref.dart';

class UserTypeSelectionController extends GetxController {

  void onTapUserTypeUser() {
    Get.toNamed(RouteConstants.loginScreen, arguments: StringConstants.USER);
  }

  void onTapUserTypeAdmin() {
    Get.toNamed(RouteConstants.loginScreen, arguments: StringConstants.ADMIN);
  }

}
