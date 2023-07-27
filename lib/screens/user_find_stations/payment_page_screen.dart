import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../controllers/payment_page_controller.dart';
import '../../utils/constants/dimens_constants.dart';
import '../../utils/custom_widgets/common_scaffold.dart';

class PaymentPageScreen extends StatelessWidget {
  PaymentPageScreen({Key? key}) : super(key: key);

  final PaymentPageController _controller = Get.put(PaymentPageController());

  @override
  Widget build(BuildContext context) {
    context.theme;
    return CommonScaffold(
      appBar: AppBar(title: const Text("Payment"), centerTitle: true),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(DimenConstants.contentPadding),
              child: Card(
                elevation: DimenConstants.cardElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DimenConstants.textFieldCornerRadius,
                  ),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: Get.height,
                    maxHeight: Get.height,
                    minWidth: Get.width,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      DimenConstants.textFieldCornerRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(DimenConstants.mixPadding),
                  child: Center(
                    child: Obx(
                      () {
                        return SingleChildScrollView(child: _fakeCardWidget());
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          _proceedToPlaceOrderButton(),
        ],
      ),
    );
  }

  Widget _fakeCardWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CreditCardWidget(
          height: 200,
          cardNumber: _controller.cardNumber.value,
          expiryDate: _controller.expiryDate.value,
          cardHolderName: _controller.cardHolderName.value,
          cvvCode: _controller.cvvCode.value,
          labelValidThru: 'VALID\nTHRU',
          obscureCardNumber: true,
          obscureInitialCardNumber: false,
          obscureCardCvv: true,
          isHolderNameVisible: true,
          isSwipeGestureEnabled: true,
          showBackView: _controller.isCvvFocussed.value,
          bankName: " ",
          cardBgColor: Colors.black,
          padding: DimenConstants.mixPadding,
          animationDuration: const Duration(milliseconds: 1000),
          frontCardBorder: Border.all(color: Colors.black),
          backCardBorder: Border.all(color: Colors.black),
          onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          glassmorphismConfig: Glassmorphism(
            blurX: 7.0,
            blurY: 10.0,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(1),
              ],
              stops: const <double>[0.6, 0.3, 0],
            ),
          ),
        ),
        CreditCardForm(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          formKey: _controller.formKey,
          obscureCvv: true,
          obscureNumber: true,
          cardNumber: _controller.cardNumber.value,
          cvvCode: _controller.cvvCode.value,
          cardHolderName: _controller.cardHolderName.value,
          expiryDate: _controller.expiryDate.value,
          themeColor: Get.theme.primaryColor,
          onCreditCardModelChange: (CreditCardModel creditCardModel) {
            _controller.onCreditCardModelChange(
              creditCardModel: creditCardModel,
            );
          },
        ),
      ],
    );
  }

  Widget _proceedToPlaceOrderButton() {
    return InkWell(
      onTap: () => _controller.onTapProceedToBookSlot(),
      child: Container(
        padding: const EdgeInsets.all(DimenConstants.mixPadding),
        color: Get.theme.primaryColor,
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Proceed To Book Slot ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.textTheme.titleMedium?.fontSize,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: Get.textTheme.titleMedium?.fontSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
