import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.label,
    this.prefix,
    this.suffix,
    this.textInputType,
    this.maxLines,
    this.expands = false,
  });

  final TextEditingController controller;
  final String? label;
  final IconButton? prefix;
  final IconButton? suffix;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool expands;
  final Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        hintText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:  const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:  const BorderSide(
            color: Color(0xFF17686A),
            width: 2,
          ),
        ),
        prefix: prefix,
        suffix: suffix,
      ),
      keyboardType: textInputType,
      maxLines: expands == false ? 1 : maxLines,
      expands: expands,
      textAlignVertical: TextAlignVertical.top,
    );
  }
}
