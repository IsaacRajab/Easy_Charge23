import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/route_constants.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/custom_widgets/common_scaffold.dart';

class PaymentSuccessPageScreen extends StatelessWidget {
  const PaymentSuccessPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(RouteConstants.dashboardScreen);
        return Future.value(false);
      },
      child: CommonScaffold(
        body: Container(
          constraints: BoxConstraints(
            minWidth: Get.width,
            minHeight: Get.height,
          ),
          child: Center(
            child: Lottie.asset(
              StringConstants.paymentSuccessLottie,
              repeat: true,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
