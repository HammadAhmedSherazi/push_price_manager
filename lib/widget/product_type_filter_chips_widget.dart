import 'package:push_price_manager/utils/extension.dart';

import '../export_all.dart';

class ProductTypeFilterChipsWidget extends StatelessWidget {
  final List<String> types;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const ProductTypeFilterChipsWidget({
    super.key,
    required this.types,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryAppBarColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        spacing: 8,
        children: [
          for (int i = 0; i < types.length; i += 2)
            Expanded(
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: _TypeChip(
                      labelKey: types[i],
                      isSelected: selectedIndex == i,
                      onTap: () => onSelect(i),
                    ),
                  ),
                  if (i + 1 < types.length)
                    Expanded(
                      child: _TypeChip(
                        labelKey: types[i + 1],
                        isSelected: selectedIndex == i + 1,
                        onTap: () => onSelect(i + 1),
                      ),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String labelKey;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.labelKey,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.borderColor,
                ),
        ),
        child: Text(
          context.tr(labelKey),
          style: isSelected
              ? context.textStyle.displaySmall!.copyWith(
                  color: Colors.white,
                )
              : context.textStyle.bodySmall!.copyWith(
                  color: AppColors.primaryTextColor,
                ),
        ),
      ),
    );
  }
}

