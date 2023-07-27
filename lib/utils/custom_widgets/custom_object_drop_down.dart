import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimens_constants.dart';

class CustomObjectDropDown<T> extends StatelessWidget {
  final RxList<T> displayList;
  final String hintText;
  final bool? isAddCompulsoryFieldAsteriskSign;
  final bool? isReadOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(T?)? validatorFunction;
  final Function(T?)? onValueChanged;
  final Rx<T?> selected;
  final String Function(T)? displayTextFunction;

  const CustomObjectDropDown({
    Key? key,
    required this.hintText,
    this.isAddCompulsoryFieldAsteriskSign,
    this.isReadOnly,
    this.prefixIcon,
    this.suffixIcon,
    required this.displayList,
    required this.selected,
    this.validatorFunction,
    this.onValueChanged,
    this.displayTextFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Obx(
      () {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(DimenConstants.contentPadding),
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              focusNode: focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                label: isAddCompulsoryFieldAsteriskSign == true
                    ? Text.rich(
                        TextSpan(
                          text: hintText,
                          children: const <InlineSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      )
                    : Text(hintText),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(DimenConstants.textFieldCornerRadius),
                  ),
                ),
              ),
              value: selected.value,
              isDense: true,
              onChanged: isReadOnly != null && isReadOnly == true
                  ? null
                  : (value) => setSelected(value),
              validator: validatorFunction,
              items: displayList.toSet().map(
                (value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      displayTextFunction != null
                          ? displayTextFunction!(value)
                          : value.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  void setSelected(T? value) {
    if (value != null) {
      if (isReadOnly == null || isReadOnly != true) {
        selected.value = value;
        onValueChanged?.call(selected.value);
      }
    }
  }
}
