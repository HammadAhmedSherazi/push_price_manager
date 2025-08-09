import 'package:flutter/services.dart';
import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  const QuantitySelector({super.key, this.initialQuantity = 1});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _controller;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    _controller = TextEditingController(text: quantity.toString());
  }

  void addQuantity() {
    setState(() {
      quantity++;
      _controller.text = quantity.toString();
    });
  }

  void removeQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        _controller.text = quantity.toString();
      }
    });
  }

  void onQuantityChanged(String value) {
    final int? newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity > 0) {
      setState(() {
        quantity = newQuantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        GestureDetector(
          onTap: removeQuantity,
          child: SvgPicture.asset(
            Assets.minusSquareIcon,
            width: 25.r,
            height: 25.r,
          ),
        ),
        Container(
          height: 24.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: SizedBox(
            width: 30.w,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textAlign: TextAlign.center,
              style: context.textStyle.displayMedium,
              onChanged: onQuantityChanged,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: addQuantity,
          child: SvgPicture.asset(
            Assets.plusSquareIcon,
            width: 25.r,
          ),
        ),
      ],
    );
  }
}
