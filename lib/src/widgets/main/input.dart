import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/theme/element/app-colors.dart';

class InputController extends GetxController {
  final RxBool obscure = true.obs;
}

class MDDTextInputField extends GetWidget {
  final TextEditingController textController;
  final String label;
  final String hint;
  final Function(String)? onChange;

  const MDDTextInputField({
    this.onChange,
    required this.textController,
    required this.label,
    required this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      keyboardType: TextInputType.text,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelStyle: TextStyle(color: AppColors.secondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary),
        ),

        contentPadding: EdgeInsets.all(12),
      ),
    );
  }
}

class MDDPasswordInputField extends GetWidget {
  final String label;
  final String hint;
  final TextEditingController textController;
  final Function(String)? onChange;

  MDDPasswordInputField({
    this.onChange,
    required this.textController,
    required this.label,
    required this.hint,
    super.key,
  });

  final InputController inputController = Get.put(InputController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: textController,
        obscureText: inputController.obscure.value,
        keyboardType: TextInputType.text,
        onChanged: onChange,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelStyle: TextStyle(color: AppColors.secondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          contentPadding: EdgeInsets.all(12),
          suffixIcon: GestureDetector(
            onTap:
                () =>
                    inputController.obscure.value =
                        !inputController.obscure.value,
            child: Icon(
              inputController.obscure.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColors.secondary
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
