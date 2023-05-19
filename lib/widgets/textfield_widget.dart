import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final double? borderRadius;
  final int? maxLines;
  final String labelText;
  const TextFieldWidget({
    Key? key,
    required this.textController,
    required this.hintText,
    this.borderRadius = 30,
    this.maxLines = 1,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          controller: textController,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textHolder,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
