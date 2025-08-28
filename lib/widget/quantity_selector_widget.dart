import 'package:flutter/services.dart';
import '../../utils/extension.dart';
import '../export_all.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged; // Callback to return quantity

  const QuantitySelector({
    super.key,
    this.initialQuantity = 0,
    this.onQuantityChanged,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _controller;
  int quantity = 0;

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
    widget.onQuantityChanged?.call(quantity); // Notify parent
  }

  void removeQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
        _controller.text = quantity.toString();
      }
    });
    widget.onQuantityChanged?.call(quantity); // Notify parent
  }

  void onQuantityChangedManually(String value) {
    final int? newQuantity = int.tryParse(value);
    if (newQuantity != null ) {
      setState(() {
        quantity = newQuantity;
      });
      widget.onQuantityChanged?.call(quantity); // Notify parent
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
              onChanged: onQuantityChangedManually,
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
