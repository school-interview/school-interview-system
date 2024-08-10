import 'package:client/constant/color.dart';
import 'package:client/view_model/profile_input/profile_input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ValidatorFunction = String? Function(String value);

/// テキスト入力ボックス
Widget buildInputTextField(
  ProfileInputViewModel viewModel, {
  required String labelText,
  required String hintText,
  int? limitText,
  ValidatorFunction? validator,
  required void Function(String) onChanged,
}) {
  return Container(
    width: 300,
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: ColorDefinitions.boxShadowLayer1,
          offset: Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: ColorDefinitions.boxShadowLayer2,
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
    ),
    child: TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: ColorDefinitions.formLabelTextColor,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: ColorDefinitions.formLabelTextColor,
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(limitText),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '入力してください。';
        }
        if (validator != null) {
          return validator(value);
        }
        return null;
      },
      onChanged: (String? text) {
        if (text == null) {
          return;
        }
        onChanged(text);
      },
    ),
  );
}
