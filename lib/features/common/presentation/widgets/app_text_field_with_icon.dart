import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/resources/color_res.dart';
import '../../../../core/utils/lang/app_localizations.dart';

class AppTextFieldWithIcon extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final TextInputType keyboardType;

  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final String? initialValue;
  final int? maxLength;
  final int? minLength;
  final Widget widget;

  const AppTextFieldWithIcon({
    super.key,
    required this.labelText,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChange,
    this.inputFormatters,
    this.textInputAction,
    this.readOnly = false,
    this.initialValue,
    this.maxLength,
    this.minLength,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 0),
          decoration: BoxDecoration(
            border: Border.all(color: ColorRes.kSecondaryColor, width: 0.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: TextFormField(
                  textInputAction: textInputAction,
                  initialValue: initialValue,
                  readOnly: readOnly,
                  maxLength: maxLength,
                  controller: controller,
                  onChanged: (value) {
                    if (onChange != null) {
                      onChange!(value);
                    }
                  },
                  inputFormatters: inputFormatters,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate(labelText),
                    border: InputBorder.none,
                    counterText: '',
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(17, 36, 10, 0.75),
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Expanded(flex: 2, child: widget)
            ],
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            AppLocalizations.of(context).translate(errorText ?? ''),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
