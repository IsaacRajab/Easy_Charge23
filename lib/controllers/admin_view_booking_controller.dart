import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/admin_bookings.dart';
import '../models/stations.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/route_constants.dart';
import '../utils/helpers/DateTimeUtils.dart';
import '../utils/helpers/common_helper.dart';
import '../utils/helpers/snack_bar_utils.dart';
import '../utils/services/api_service.dart';

class AdminViewBookingController extends GetxController {
  RxBool isLoading = false.obs;
  RxDouble totalRevenue = 0.0.obs;

  RxList dataList = <AdminBookings>[].obs;
  RxList<Stations> stationList = <Stations>[].obs;
  Rx<Stations?> selectedStation = Rx<Stations?>(null);

  late TextEditingController etFromDate, etToDate;

  @override
  Future<void> onInit() async {
    super.onInit();
    etFromDate = TextEditingController();
    etToDate = TextEditingController();
    await fetchStations();
    selectedStation.value = stationList.first;
    fetchAdminBookingsByParams();
  }

  void viewAllUsers() {
    Get.toNamed(RouteConstants.viewAllUserScreen);
  }

  void onTapBookingCard({required AdminBookings booking}) {
    Get.toNamed(
      RouteConstants.viewBookingDetailsAdmin,
      arguments: booking,
    );
  }

  void onTapFromDateField() {
    DateTimeUtils.showDatePickerDialog().then((value) {
      if (value != null) {
        if (validateFromDateField(value) == null) {
          etFromDate.text = value;
          fetchAdminBookingsByParams();
        }
      }
    });
  }

  void onTapToDateField() {
    DateTimeUtils.showDatePickerDialog().then((value) {
      if (value != null) {
        etToDate.text = value;
        fetchAdminBookingsByParams();
      }
    });
  }

  void onChanged({required Stations? stations}) {
    selectedStation.value = stations ?? stationList.first;
    fetchAdminBookingsByParams();
  }

  String? validateFromDateField(String? value) {
    return DateTimeUtils.dateValidation(
      startDate: value ?? etFromDate.text,
      endDate: etToDate.text,
    );
  }

  String? validateToDateField(String? value) {
    return DateTimeUtils.dateValidation(
      startDate: etFromDate.text,
      endDate: value ?? etToDate.text,
    );
  }

  Future<void> fetchStations() async {
    try {
      isLoading(true);
      stationList.clear();
      var jsonResponse = await ApiService.postGetData(
        ApiConstants.viewStationAdmin,
        body: {},
      ) as List;
      stationList.value = jsonResponse.map((e) {
        return Stations.fromJson(e);
      }).toList();
    } catch (e) {
      SnackBarUtils.errorSnackBar(
        title: "ERROR",
        message: "Something went wrong while fetching stations. "
            "Please try again later",
      );
    } finally {
      Stations all = Stations(stationName: "All Stations", stationId: "all");
      isLoading(false);
      stationList.insert(0, all);
      stationList.value = stationList.toSet().toList();
    }
  }

  void fetchAdminBookingsByParams() async {
    try {
      isLoading(true);
      AdminBookings bookings = AdminBookings();
      bookings.fromDate = etFromDate.text;
      bookings.toDate = etToDate.text;
      bookings.stationId = selectedStation.value?.stationId ?? "all";
      var jsonResponse = await ApiService.postGetData(
        ApiConstants.viewBookingsAdmin,
        body: bookings,
      ) as List;
      totalRevenue.value = 0.0;
      dataList.value = jsonResponse.map((e) {
        AdminBookings adminBookings = AdminBookings.fromJson(e);
        double amount = convertValueToDouble(amount: adminBookings.amount);
        totalRevenue.value = totalRevenue.value + amount;
        return adminBookings;
      }).toList();
    } catch (e) {
      CommonHelper.printDebugError(e);
    } finally {
      isLoading(false);
    }
  }

  double convertValueToDouble({required String? amount}) {
    try {
      return double.tryParse(amount ?? "0") ?? 0.0;
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
    return 0.0;
  }
}
