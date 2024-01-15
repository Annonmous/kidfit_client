import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final Widget? suffixIcon;
  final Widget? icon;
  final Color? fieldColor;
  final bool? obscureText;
  final int? maxLines;
  final ValueChanged<String>? onchange;
  final VoidCallback onsubmit;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final bool enabled;

  final FormFieldValidator<String>? validator;
  CustomTextFieldWidget(
      {super.key,
      required this.controller,
      this.onchange,
      required this.hintText,
      this.validator,
      this.icon,
      this.obscureText = false,
      this.suffixIcon,
      required this.onsubmit,
      required this.inputType,
      this.maxLines,
      required this.label,
      this.focusNode,
      required this.enabled,
      this.fieldColor});

  final themecontroller = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
                color: themecontroller.textcolor,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextFormField(
          onChanged: onchange,
          enabled: enabled,
          focusNode: focusNode,
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText!,
          maxLines: maxLines ?? 1,
          style: TextStyle(
            color: themecontroller.textcolor,
            fontSize: 14,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.deny(
                RegExp(r'\s\s+')), // Deny consecutive spaces
            LeadingSpaceTrimmerInputFormatter(), // Custom input formatter to trim leading spaces
          ],
          validator: validator,
          decoration: InputDecoration(
            fillColor: fieldColor ?? themecontroller.textfiledecolor,
            filled: true,
            suffixIcon: suffixIcon,
            prefixIcon: icon,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themecontroller.bordercolor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themecontroller.bordercolor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themecontroller.bordercolor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themecontroller.bordercolor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themecontroller.bordercolor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themecontroller.bordercolor.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            counterStyle: TextStyle(
              color: themecontroller.textcolor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: themecontroller.textcolor.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

class LeadingSpaceTrimmerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Trim leading spaces from the text value
    if (newValue.text.startsWith(' ')) {
      final trimmedText = newValue.text.trimLeft();
      return newValue.copyWith(
        text: trimmedText,
        composing: TextRange.collapsed(trimmedText.length),
      );
    }
    return newValue;
  }
}
