import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/slots.dart';
import '../utils/constants/api_constants.dart';
import '../utils/custom_widgets/common_progress.dart';
import '../utils/helpers/common_helper.dart';
import '../utils/helpers/snack_bar_utils.dart';
import '../utils/services/api_service.dart';

class AddUpdateSlotController extends GetxController {
  late TextEditingController etVoltage;
  late TextEditingController etPrice;

  late FocusNode etVoltageFocusNode;
  late FocusNode etPriceFocusNode;

  var typeOfCharger = ''.obs;
  var isSlotEnabled = false.obs;
  var switchText = "Slot Disabled".obs;

  late Slots? slotArg;
  late String slotId, stationId;

  @override
  void onInit() {
    super.onInit();
    initUI();
    initObj();
  }

  void initObj() {
    stationId = Get.arguments == null ? null : Get.arguments[0];
    try {
      slotArg = Get.arguments[1];
    } catch (e) {
      slotArg = null;
      CommonHelper.printDebugError("");
    }
    _setSlotToFields();
  }

  void initUI() {
    etVoltage = TextEditingController();
    etPrice = TextEditingController();

    etVoltageFocusNode = FocusNode();
    etPriceFocusNode = FocusNode();
  }

  void onChanged(String value) {
    typeOfCharger.value = value;
  }

  void onPressSubmit({
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      await CommonHelper.getInternetStatus().then(
        (connection) async {
          if (connection) {
            if (slotArg == null) {
              _createSlot();
            } else {
              _updateSlot();
            }
          }
        },
      );
    }
  }

  void setSelected(bool value) {
    isSlotEnabled.value = value;
    if (value == false) {
      switchText.value = 'Slot Disabled';
    } else {
      switchText.value = 'Slot Enabled';
    }
  }

  String? dropDownValidation(String? value) {
    try {
      if (value == null) {
        return 'Cannot Be Empty';
      }
      if (value == "Select Type of Charger") {
        return 'Cannot Be Empty';
      }
    } catch (e) {
      return 'Cannot Be Empty';
    }
    return null;
  }

  void _setSlotToFields() {
    try {
      if (slotArg != null) {
        etVoltage.text = slotArg!.voltage!;
        etPrice.text = slotArg!.price!;
        slotId = slotArg!.slotsId!;
        typeOfCharger.value = slotArg!.typeOfCharger!;
        if (slotArg!.status! == "Enable") {
          setSelected(true);
        } else {
          setSelected(false);
        }
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
  }

  Slots createSlotObject() {
    Slots slot = Slots();
    try {
      bool slotEnabled = isSlotEnabled.value;
      slot.stationId = stationId;
      slot.voltage = etVoltage.text;
      slot.price = etPrice.text;
      slot.typeOfCharger = typeOfCharger.value;
      if (slotEnabled) {
        slot.status = "Enable";
      } else {
        slot.status = "Disable";
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
    }
    return slot;
  }

  Future<void> _createSlot() async {
    try {
      CommonProgressBar.show();
      Slots slot = createSlotObject();
      var jsonResponse = await ApiService.postGetStatus(
        ApiConstants.addSlot,
        body: slot,
      );
      if (jsonResponse.isNotEmpty) {
        if (jsonResponse.contains("true")) {
          Get.back();
          SnackBarUtils.normalSnackBar(
            title: "Success",
            message: 'Slot added successfully',
          );
        } else if (jsonResponse.contains("already")) {
          SnackBarUtils.normalSnackBar(
            title: "Failed!",
            message: 'Slot already exist.  Please try again',
          );
        } else if (jsonResponse.contains("false") ||
            jsonResponse.contains("no")) {
          SnackBarUtils.errorSnackBar(
            title: "Failed!",
            message: 'Failed to add slot. Please try again later',
          );
        }
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
      SnackBarUtils.errorSnackBar(
        title: "Failed!",
        message: 'Failed to add slot. Please try again later',
      );
    } finally {
      CommonProgressBar.hide();
    }
  }

  Future<void> _updateSlot() async {
    try {
      CommonProgressBar.show();
      Slots slot = createSlotObject();
      slot.slotsId = slotId;
      var jsonResponse = await ApiService.postGetStatus(
        ApiConstants.updateSlot,
        body: slot,
      );
      if (jsonResponse.isNotEmpty) {
        if (jsonResponse.contains("true")) {
          Get.back();
          SnackBarUtils.normalSnackBar(
            title: "Success",
            message: 'Slot updated successfully',
          );
        } else if (jsonResponse.contains("already")) {
          SnackBarUtils.normalSnackBar(
            title: "Failed!",
            message: 'Slot already exist.  Please try again',
          );
        } else if (jsonResponse.contains("false") ||
            jsonResponse.contains("no")) {
          SnackBarUtils.errorSnackBar(
            title: "Failed!",
            message: 'Failed to update slot. Please try again later',
          );
        }
      }
    } catch (e) {
      CommonHelper.printDebugError(e);
      SnackBarUtils.errorSnackBar(
        title: "Failed!",
        message: 'Failed to update slot. Please try again later',
      );
    } finally {
      CommonProgressBar.hide();
    }
  }
}
