import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final FormFieldValidator<String>? validatorFunction;
  final ValueChanged<String?>? onSave;
  final EdgeInsets? padding;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixBoxConstraint;
  final BoxConstraints? suffixBoxConstraint;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final bool filled;
  final Color? fillColor;
  final EdgeInsets? margin;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? errorText;
  final bool passwordField;
  final TextCapitalization textCapitalization;
  final Color? backColor;
  final FontWeight fontWeight;
  final double height;
  final double borderRadius;
  final bool isBorder;
  final TextStyle? hintStyle;

  const CustomTextField({
    this.label,
    this.height = 60,
    this.hint,
    this.isBorder = true,
    this.fillColor,
    this.borderRadius = 10,
    this.margin,
    this.validatorFunction,
    this.padding,
    this.onSave,
    this.filled = false,
    this.hintStyle,
    this.inputType,
    this.textCapitalization = TextCapitalization.none,
    this.fontWeight = FontWeight.w500,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixBoxConstraint,
    this.prefixBoxConstraint,
    this.controller,
    this.onTap,
    this.backColor,
    this.readOnly,
    this.inputFormatters,
    this.enable = false,
    this.passwordField = false,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onTap: onTap,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        controller: controller,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        style:
            Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500),
        textCapitalization: textCapitalization,
        maxLength: maxLength,
        obscureText: passwordField,
        validator: validatorFunction,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          errorStyle: Get.textTheme.displaySmall!.copyWith(color: Colors.red),
          fillColor: fillColor,
          contentPadding: padding,
          constraints: BoxConstraints(minHeight: 50),
          filled: filled,
          border: isBorder
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(8))
              : UnderlineInputBorder(),
          label: label != null ? Text(label!) : null,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconConstraints: suffixBoxConstraint,
          prefixIconConstraints: prefixBoxConstraint,
          hintStyle: hintStyle ?? Get.textTheme.displayMedium,
        ),
      ),
    );
  }
}
