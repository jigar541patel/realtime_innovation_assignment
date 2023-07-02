import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors_utils.dart';
import '../utils/decoration_utils.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isEnable;
  final bool isRequire;
  final bool isReadOnly;
  final bool isIconDisplay;
  final bool isObscureText;
  final FormFieldValidator? validator;
  final ValueChanged? onChanged;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmited;
  final TextInputType textInputType;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback? onTap;
  final String? icon;

  const CustomFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isEnable = true,
    this.isRequire = false,
    this.isReadOnly = false,
    this.isObscureText = false,
    this.isIconDisplay = true,
    this.textInputAction,
    this.onSubmited,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.icon = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: isEnable,
      readOnly: isReadOnly,
        cursorColor: primaryTextColor,
      style: TextStyle(
          fontSize: 14.0,
          color: isRequire
              ? primaryTextColor
              : Theme.of(context).textTheme.bodyText1!.color),
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      obscureText: isObscureText,
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: DecorationUtils(context).getUnderlineInputDecoration(
        labelText: labelText,
        isRequire: isRequire,
        isEnable: isEnable,
        icon: icon,
        isIconDisplay: isIconDisplay,



      ),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onSubmited,
    );
  }
}
