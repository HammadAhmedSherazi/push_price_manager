import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class CustomSearchBarWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool isArabic;
  final String hintText;
  final String? value;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final bool? readOnly;
  final bool? autoFocus;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;

  const CustomSearchBarWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.value,
    this.onTap,
    this.onTapOutside,
    this.focusNode,
    this.isArabic = false,
    this.suffixIcon,
    this.readOnly = false,
    this.autoFocus = false,
    required this.hintText,
  });

  @override
  State<CustomSearchBarWidget> createState() => _CustomSearchBarWidgetState();
}

class _CustomSearchBarWidgetState extends State<CustomSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      focusNode: widget.focusNode,
      autoFocus: widget.autoFocus ?? false,
      readOnly: widget.readOnly ?? false,
      onTapOutside: widget.onTapOutside,
      elevation: const WidgetStatePropertyAll(0.0),
      onTap: widget.onTap,
      trailing: widget.suffixIcon != null ? [widget.suffixIcon!] : null,
      hintText: widget.hintText,
      onChanged: widget.onChanged,
      controller: widget.controller,
      leading: SvgPicture.asset(
        Assets.searchIcon,
        width: 18.iw,
        height: 18.iw,
        colorFilter: ColorFilter.mode(
          Colors.black.withValues(alpha: 0.6),
          BlendMode.srcIn,
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 44.h,
        maxHeight: 44.h,
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16.r),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500.r),
          side: const BorderSide(color: AppColors.borderColor),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        context.textStyle.titleMedium!.copyWith(
          color: Colors.black,
          height: 1.2,
          fontSize: widget.isArabic
              ? (context.textStyle.titleMedium?.fontSize ?? 16.sp)
              : context.textStyle.titleMedium?.fontSize,
        ),
      ),
      hintStyle: WidgetStatePropertyAll(
        context.textStyle.titleMedium!.copyWith(
          color: Colors.black.withValues(alpha: 0.6),
          height: 1.2,
          fontSize: widget.isArabic
              ? (context.textStyle.titleMedium?.fontSize ?? 16.sp) * 0.7
              : context.textStyle.titleMedium?.fontSize,
        ),
      ),
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
    );
  }
}
