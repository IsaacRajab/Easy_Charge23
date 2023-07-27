import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';

import '../models/bookings.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/route_constants.dart';
import '../utils/custom_widgets/common_progress.dart';
import '../utils/helpers/common_helper.dart';
import '../utils/helpers/snack_bar_utils.dart';
import '../utils/services/api_service.dart';

class PaymentPageController extends GetxController {
  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocussed = false.obs;

  late Bookings bookingsArg;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    bookingsArg = Get.arguments;
  }

  void onCreditCardModelChange({required CreditCardModel creditCardModel}) {
    cardNumber.value = creditCardModel.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocussed.value = creditCardModel.isCvvFocused;
  }

  Future<void> onTapProceedToBookSlot() async {
    if (formKey.currentState!.validate()) {
      try {
        CommonProgressBar.show();

        //{
        //    "StationId":"1",
        //    "Slotid":"1",
        //    "Uid":"1000",
        //    "Vid":"1",
        //    "Date":"2022/03/16",
        //    "TimeIn":"17:00",
        //    "TimeOut":"22:00",
        //    "Amount":"1000",
        //    "DT":"2022/03/16 13:00",
        //}

        var jsonResponse = await ApiService.postGetStatus(
          ApiConstants.bookSlot,
          body: bookingsArg,
        );
        if (jsonResponse.isNotEmpty) {
          if (jsonResponse.contains("true")) {
            Get.offAllNamed(RouteConstants.paymentSuccessPageScreen);
            SnackBarUtils.normalSnackBar(
              title: "Success",
              message: 'Slot booked successfully',
            );
          } else if (jsonResponse.contains("false") ||
              jsonResponse.contains("no")) {
            SnackBarUtils.errorSnackBar(
              title: "Failed!",
              message: 'Failed to book slot. Please try again later',
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
}
