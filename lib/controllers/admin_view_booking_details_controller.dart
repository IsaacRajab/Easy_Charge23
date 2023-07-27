import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/admin_bookings.dart';
import '../utils/constants/api_constants.dart';
import '../utils/custom_widgets/common_dialog.dart';
import '../utils/custom_widgets/common_progress.dart';
import '../utils/helpers/common_helper.dart';
import '../utils/helpers/snack_bar_utils.dart';
import '../utils/services/api_service.dart';

class AdminViewBookingDetailsController extends GetxController {
  Rxn<AdminBookings> bookingsArg = Rxn<AdminBookings>();

  @override
  void onInit() {
    super.onInit();
    bookingsArg.value = Get.arguments;
    bookingsArg.value ??= AdminBookings();
  }

  Future<void> onTapCancelBooking() async {
    Get.dialog(
      CommonDialog(
        title: "WARNING!!!!",
        contentWidget: const Text(
          "Are you sure you want to "
          "cancel user's booking? This cannot be undone",
        ),
        negativeRedDialogBtnText: "Confirm",
        positiveDialogBtnText: "Back",
        onNegativeRedBtnClicked: () => cancelBooking(),
      ),
    );
  }

  Future<void> cancelBooking() async {
    try {
      CommonProgressBar.show();

      AdminBookings booking = AdminBookings();
      booking.bookingId = bookingsArg.value?.bookingId;

      var jsonResponse = await ApiService.postGetStatus(
        ApiConstants.cancelBooking,
        body: booking,
      );
      if (jsonResponse.isNotEmpty) {
        if (jsonResponse.contains("true")) {
          bookingsArg.value?.bookingStatus = "Cancelled";
          Get.back();
          SnackBarUtils.normalSnackBar(
            title: "Success",
            message: 'Booking cancelled',
          );
        } else if (jsonResponse.contains("false") ||
            jsonResponse.contains("no")) {
          SnackBarUtils.errorSnackBar(
            title: "Failed!",
            message: 'Failed to cancel booking. Please try again later',
          );
        }
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
      SnackBarUtils.errorSnackBar(
        title: "Failed!",
        message: 'Something went wrong. Please try again later',
      );
    } finally {
      CommonProgressBar.hide();
    }
  }
}
