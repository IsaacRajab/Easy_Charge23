import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/route_constants.dart';
import '../utils/constants/string_constants.dart';
import '../utils/custom_widgets/common_dialog.dart';
import '../utils/helpers/user_pref.dart';

class DashboardController extends GetxController {
  RxString userType = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    userType.value = await UserPref.getLoginUserType();
  }

  void onTapManageStation() {
    Get.toNamed(RouteConstants.manageStationsScreen);
  }

  void onTapViewBooking() {
    Get.toNamed(
      userType.value == StringConstants.ADMIN
          ? RouteConstants.viewBookingsAdmin
          : RouteConstants.viewBookings,
    );
  }

  void onTapManageEVVehicles() {
    Get.toNamed(RouteConstants.manageEVVehicles);
  }

  void onTapFindStations() {
    Get.toNamed(RouteConstants.findStations);
  }

  void onTapProfile() {
    Get.toNamed(RouteConstants.profileScreen);
  }

  void onPressViewRoadMap() {
    Get.toNamed(RouteConstants.googleMapViewRoadMap);
  }

  void onPressLogout() {
    Get.dialog(
      CommonDialog(
        title: "WARNING!!!!",
        contentWidget: const Text("Are you sure you want to logout?"),
        negativeRedDialogBtnText: "Confirm",
        positiveDialogBtnText: "Back",
        onNegativeRedBtnClicked: () {
          Get.offAllNamed(RouteConstants.userTypeScreen);
          UserPref.removeAllFromUserPref();
        },
      ),
    );
  }
}
