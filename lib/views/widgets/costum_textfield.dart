import 'package:flutter/material.dart';

import '../../core/constant/app_colors.dart';

// ignore: camel_case_types, must_be_immutable
class costumTextField extends StatelessWidget {
  costumTextField(
      {Key? key,
      required this.icon,
      required this.name,
      required this.onchanged,
      required this.security,
      required this.validate,
      required this.textInputType})
      : super(key: key);
  Icon icon;
  TextInputType textInputType;
  String name;
  bool security;
  Function(String) onchanged;
  String? Function(String?) validate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        keyboardType: textInputType,
        validator: validate,
        obscureText: security,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: name,
            hintStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: AppColors.mainColor.withOpacity(0.6),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)))),
        onChanged: onchanged,
      ),
    );
  }
}
