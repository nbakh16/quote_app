// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final Widget? label;
  final String? extraLabel;
  final TextStyle? labelStyle;
  final TextStyle? extraLabelStyle;
  final TextStyle? errorStyle;
  final VoidCallback? onTap;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final EdgeInsetsGeometry? padding;
  final Color? cursorColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final TextStyle? style;
  final String? errorText;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final double? marginBottom;
  final int characterLimit;

  const CustomTextField({
    super.key,
    this.controller,
    this.obscureText,
    this.readOnly,
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.label,
    this.onTap,
    this.autovalidateMode,
    this.keyboardType,
    this.validator,
    this.onChange,
    this.padding,
    this.cursorColor,
    this.inputFormatters,
    this.autofocus,
    this.autocorrect,
    this.enableSuggestions,
    this.textAlign,
    this.fontSize,
    this.style,
    this.errorText,
    this.onEditingComplete,
    this.maxLines,
    this.extraLabel,
    this.extraLabelStyle,
    this.labelStyle,
    this.errorStyle,
    this.marginBottom,
    this.characterLimit = 128,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ********** extraLabel ********
        if (extraLabel != null) Text(extraLabel ?? ''),
        if (extraLabel != null) const SizedBox(height: 8),
        TextFormField(
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          controller: controller,
          validator: validator,
          onChanged: onChange,
          obscureText: obscureText ?? false,
          readOnly: readOnly ?? false,
          autovalidateMode: autovalidateMode,
          // cursorColor: cursorColor ?? theme.primaryColor,
          maxLines: maxLines ?? 1,
          autofocus: autofocus ?? false,
          enableSuggestions: enableSuggestions ?? true,
          autocorrect: autocorrect ?? true,
          textAlign: textAlign ?? TextAlign.start,
          onTap: onTap,
          style: style ?? theme.textTheme.bodyMedium,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: kDisabledColor.withOpacity(.6),
            // ********** errorText ********
            errorText: errorText,
            errorStyle:
                errorStyle ??
                theme.textTheme.labelMedium?.copyWith(color: Colors.red),
            errorMaxLines: 5,

            // ********** padding ********
            contentPadding: padding ?? const EdgeInsets.all(8),
            // ********** prefixIcon ********
            prefixIcon: prefixIcon,
            // ********** suffixIcon ********
            suffix: suffix,
            suffixIcon: suffixIcon,
            // ********** border ********
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.disabledColor),
            ),
            // ********** focusedBorder ********
            focusColor: theme.primaryColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.disabledColor),
            ),
            // ********** enabledBorder ********
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.disabledColor),
            ),
            // ********** errorBorder ********
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.disabledColor),
            ),
            // ********** hintText ********
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
            // ********** label ********
            label: label,
            labelStyle: labelStyle ?? theme.textTheme.labelMedium,
          ),
          // ********** inputFormatters ********
          inputFormatters:
              inputFormatters ??
              [LengthLimitingTextInputFormatter(characterLimit)],
        ),
        // ********** marginBottom ********
        SizedBox(height: marginBottom ?? 16),
      ],
    );
  }
}
