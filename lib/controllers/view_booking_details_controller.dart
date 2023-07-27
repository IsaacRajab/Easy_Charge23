import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/bookings.dart';
import '../utils/constants/api_constants.dart';
import '../utils/custom_widgets/common_dialog.dart';
import '../utils/custom_widgets/common_progress.dart';
import '../utils/helpers/DateTimeUtils.dart';
import '../utils/helpers/common_helper.dart';
import '../utils/helpers/snack_bar_utils.dart';
import '../utils/services/api_service.dart';

class ViewBookingDetailsController extends GetxController {
  late Bookings bookingArg;
  late bool isCancelButtonVisible;

  @override
  void onInit() {
    super.onInit();
    bookingArg = Get.arguments;
    isCancelButtonVisible = checkIfBookingCanCancel();
  }

  bool checkIfBookingCanCancel() {
    try {
      String? bookingDate = bookingArg.bookingDate!;
      String? bookingTime = bookingArg.timeIn!;

      int hoursRemaining = DateTimeUtils.checkStringDateTimeDifferenceInHours(
        endDate: bookingDate,
        endTime: bookingTime,
      );

      if (hoursRemaining >= 1) {
        if (bookingArg.bookingStatus != null) {
          if (bookingArg.bookingStatus!.toLowerCase().contains("cancel")) {
            return false;
          }
        }
        return true;
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
    return false;
  }

  Future<void> onTapCancelBooking() async {
    Get.dialog(
      CommonDialog(
        title: "WARNING!!!!",
        contentWidget: const Text(
          "Are you sure you want to "
          "cancel booking? This cannot be undone",
        ),
        negativeRedDialogBtnText: "Confirm",
        positiveDialogBtnText: "Back",
        onNegativeRedBtnClicked: () => cancelBooking(),
      ),
    );
  }

  Future<void> cancelBooking() async {
    try {
      String? bookingDate = bookingArg.bookingDate!;
      String? bookingTime = bookingArg.timeIn!;

      int hoursRemaining = DateTimeUtils.checkStringDateTimeDifferenceInHours(
        endDate: bookingDate,
        endTime: bookingTime,
      );

      if (hoursRemaining >= 1) {
        Get.back();
        CommonProgressBar.show();

        Bookings booking = Bookings();
        booking.bookingId = booking.bookingId;

        var jsonResponse = await ApiService.postGetStatus(
          ApiConstants.cancelBookings,
          body: booking,
        );
        if (jsonResponse.isNotEmpty) {
          if (jsonResponse.contains("true")) {
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
      } else {
        SnackBarUtils.errorSnackBar(
          title: "Failed!",
          message: 'Booking cannot be cancelled',
        );
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

  static String? currentDayOfWeek() {
    try {
      return DateFormat('EEEE').format(DateTime.now());
    } catch (e) {
      return null;
    }
  }

  static DateTime? stringTimeToDateTime({
    required String time,
  }) {
    try {
      var timeFormat = DateFormat("hh:mm");
      TimeOfDay timeOfDay = TimeOfDay.fromDateTime(timeFormat.parse(time));
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
    } catch (e) {
      return null;
    }
  }

  static DateTime? stringDateTimeToDateTime({
    required String stringDateTime,
  }) {
    try {
      DateFormat dateFormat = DateFormat("yyyy/MM/dd hh:mm");
      return dateFormat.parse(stringDateTime);
    } catch (e) {
      return null;
    }
  }

  static DateTime? currentDateTime() {
    try {
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String currentDateTimeInString() {
    return currentDate() + " " + currentTime();
  }

  static String? dateTimeTo24hrTimeTo12hr({
    required String dateTime,
  }) {
    try {
      var timeFormat = DateFormat("hh:mm");
      return DateFormat("hh:mm a").format(timeFormat.parse(dateTime));
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String?> showTimePickerDialog() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: Get.context as BuildContext,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null) {
      final localizations =
      MaterialLocalizations.of(Get.context as BuildContext);
      String formattedTime =
      localizations.formatTimeOfDay(timeOfDay, alwaysUse24HourFormat: true);
      return formattedTime;
    }
    return null;
  }

  static Future<String?> showDatePickerDialog() async {
    var dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat(DateFormat.YEAR);
    int currentYear = int.parse(dateFormat.format(dateTime));

    final DateTime? d = await showDatePicker(
      context: Get.context as BuildContext,
      initialDate: dateTime,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(currentYear + 1),
    );
    if (d != null) {
      DateFormat dateFormat = DateFormat("yyyy/MM/dd");
      return dateFormat.format(d);
    }
    return null;
  }

  static String currentDate() {
    DateTime currentDateTime = DateTime.now();
    return currentDateTime.year.toString() +
        "/" +
        currentDateTime.month.toString() +
        "/" +
        currentDateTime.day.toString();
  }

  static String currentTime() {
    DateTime currentDateTime = DateTime.now();
    return currentDateTime.hour.toString() +
        ":" +
        currentDateTime.minute.toString();
  }

  static int checkStringDateTimeDifferenceInHours({
    String? startDate,
    String? startTime,
    required String endDate,
    required String endTime,
  }) {
    try {
      DateFormat dateFormat = DateFormat("yyyy/MM/dd hh:mm");
      DateTime startDateTime = dateFormat.parse(
          (startDate ?? currentDate()) + " " + (startTime ?? currentTime()));

      DateTime endDateTime = dateFormat.parse(endDate + " " + endTime);
      Duration duration = endDateTime.difference(startDateTime);

      return duration.inHours;
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
    return 0;
  }

  static String? timeValidation({
    required String startTime,
    required String endTime,
  }) {
    try {
      DateFormat dateFormat = DateFormat("yyyy/MM/dd hh:mm");
      DateTime startDateTime =
      dateFormat.parse(currentDate() + " " + startTime);
      DateTime endDateTime = dateFormat.parse(currentDate() + " " + endTime);
      if (startDateTime.hour.isGreaterThan(endDateTime.hour)) {
        return "Not valid!!!";
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
    return null;
  }

  static String? stringDateTimeValidation({
    String? startDate,
    String? startTime,
    required String endDate,
    required String endTime,
  }) {
    try {
      DateFormat dateFormat = DateFormat("yyyy/MM/dd hh:mm");
      DateTime startDateTime = dateFormat.parse(
          (startDate ?? currentDate()) + " " + (startTime ?? currentTime()));

      DateTime endDateTime = dateFormat.parse(endDate + " " + endTime);

      if (startDateTime.isAfter(endDateTime) ||
          startDateTime.isAtSameMomentAs(endDateTime)) {
        return "Not valid!!!";
      } else {
        return null;
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
    return null;
  }

}
