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
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;
  const CustomSearchBarWidget(
      {super.key,
      this.controller,
      this.onChanged,
      this.value,
      this.onTap,
      this.onTapOutside,
      this.focusNode,
      this.isArabic = false,
      this.suffixIcon,
      required this.hintText});

  @override
  State<CustomSearchBarWidget> createState() => _CustomSearchBarWidgetState();
}

class _CustomSearchBarWidgetState extends State<CustomSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      // padding: EdgeInsets.symmetric(horizontal: 18.r),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(500.r), right: Radius.circular(500.r))),
      child:
          // Row(
          //   children: [
          //     SvgPicture.asset(
          //       Assets.searchIcon,
          //       colorFilter: ColorFilter.mode(
          //           Colors.black.withValues(alpha: 0.6), BlendMode.srcIn),
          //     ),
          //     10.pw,
          //     GenericTranslateWidget( 
          //      widget.value ?? widget.hintText,
          //       style: context.textStyle.titleMedium!
          //           .copyWith(color: widget.value == null ? Colors.black.withValues(alpha: 0.6): Colors.black),
          //     )
          //   ],
          // )
          SearchBar(
            focusNode: widget.focusNode,
            
        onTapOutside: widget.onTapOutside ,
        elevation: const WidgetStatePropertyAll(0.0),
        onTap: widget.onTap,
        trailing: widget.suffixIcon != null? [
          widget.suffixIcon!
        ] : null,
        hintText: widget.hintText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        
        leading: SvgPicture.asset(
          Assets.searchIcon,
          colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.6), BlendMode.srcIn),
        ),
        padding: WidgetStatePropertyAll(
            EdgeInsets.only(left: 17.r, right: 17.r, bottom:  5.r, top: 5.r)),
        textStyle: WidgetStatePropertyAll(
            context.textStyle.titleMedium!.copyWith(color: Colors.black, fontSize: widget.isArabic ? (context.textStyle.titleMedium?.fontSize ?? 16.sp)  // Adjust as needed
          : context.textStyle.titleMedium?.fontSize)),
        hintStyle: WidgetStatePropertyAll(context.textStyle.titleMedium!
            .copyWith(color: Colors.black.withValues(alpha: 0.6), fontSize: widget.isArabic ? (context.textStyle.titleMedium?.fontSize ?? 16.sp) * 0.7 // Adjust as needed
          : context.textStyle.titleMedium?.fontSize )),
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }
}