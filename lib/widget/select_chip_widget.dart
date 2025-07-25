import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class SelectChipWidget extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int) onSelected;

  const SelectChipWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.horizontalPadding
      ),
      child: ListView.separated(
        
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        final bool isSelected = index == selectedIndex;
        return ChoiceChip(
            label: Text(
              items[index],
              style: context.textStyle.displayMedium!.copyWith(
                color: isSelected ? Colors.white : Color(0xff5B5B5B)
              ),
            ),
            selected: isSelected,
            selectedColor: AppColors.primaryColor,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            padding: EdgeInsets.symmetric(
              horizontal: 10.r
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
                width: 1.2,
              ),
            ),
            onSelected: (_) => onSelected(index),
          );
      }, separatorBuilder: (context, index)=> 10.pw, itemCount: items.length),
    );
  }
}
