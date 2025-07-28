import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.options = const [],
    this.value,
    this.expandIcon,
    this.onChanged,
    this.isDense = true,
    this.filled = false,
    this.fillColor,
    this.dropdownColor,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.placeholderText,
    this.placeholderStyle,
    this.expandIconColor,
    this.error,
  });

  final List<CustomDropDownOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget? expandIcon;
  final bool? isDense;
  final bool? filled;
  final Color? fillColor;
  final Color? dropdownColor;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final String? placeholderText;
  final TextStyle? placeholderStyle;
  final Color? expandIconColor;
  final Widget? error;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: false,
      dropdownColor: dropdownColor ?? Colors.white,
      borderRadius: BorderRadius.circular(16.r),

      icon:
          Padding(
            padding: EdgeInsets.only(
              bottom: 10.r,
              right: 10.r
            ),
            child: expandIcon ??
            Transform.rotate(
              angle:  1.5 * 3.1416 , // 270° or 90° in radians
              child: Icon(
                Icons.arrow_back_ios,
                color: expandIconColor ?? AppColors.secondaryColor,
              ),
            ),
          ),
      hint: Text(
        placeholderText ?? 'Select',
        style:
            placeholderStyle ??
            context.inputTheme.hintStyle!.copyWith(color: Colors.black),
      ),
      items:
          options.map((option) {
            return DropdownMenuItem(
              value: option.value,

              child: Text(
                option.displayOption,
                style: context.textStyle.bodyMedium!.copyWith(
                  color: Colors.black
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
      decoration: InputDecoration(
        contentPadding: contentPadding,

        filled: filled,
        fillColor: fillColor ?? Colors.white,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        disabledBorder:
            disabledBorder ??
            context.inputTheme.disabledBorder,
        enabledBorder:
            enabledBorder ??
            context.inputTheme.enabledBorder,
        focusedBorder:
            focusedBorder ??
            context.inputTheme.focusedBorder,
        errorBorder:
            errorBorder ??
            context.inputTheme.enabledBorder,
        focusedErrorBorder:
            focusedErrorBorder ??
            context.inputTheme.focusedErrorBorder,
        isDense: isDense,
        error: error,
      ),
      style: context.textStyle.bodyMedium,
      value: value,
      onChanged: onChanged,
    );
  }
}

class CustomDropDownOption<T> {
  final T value;
  final String displayOption;

  const CustomDropDownOption({
    required this.value,
    required this.displayOption,
  });
}
