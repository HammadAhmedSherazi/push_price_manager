import 'package:push_price_manager/utils/extension.dart';

import '../data/network/api_response.dart';
import '../export_all.dart';

class CategoryDisplayGenericWidget extends StatefulWidget {
  final ApiResponse response;
  final List<int>? selectedCategoryIds;
  final List<CategoryDataModel> categories;
  final Function(CategoryDataModel category) onTap;
  final VoidCallback onRetryFun;
  final VoidCallback? onScrollFun;

  const CategoryDisplayGenericWidget({
    super.key,
    required this.response,
    required this.selectedCategoryIds,
    required this.categories,
    required this.onTap,
    required this.onRetryFun,
    this.onScrollFun,
  });

  @override
  State<CategoryDisplayGenericWidget> createState() =>
      _CategoryDisplayGenericWidgetState();
}

class _CategoryDisplayGenericWidgetState
    extends State<CategoryDisplayGenericWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.onScrollFun != null) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
          widget.onScrollFun!();
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = context.categoryItemWidth;
    final itemCount = widget.response.status == Status.loadingMore
        ? widget.categories.length + 1
        : widget.categories.length;

    return SizedBox(
      height: context.isTablet ? 96.ih : 85.h,
      child: AsyncStateHandler(
        status: widget.response.status,
        dataList: widget.categories,
        onRetry: widget.onRetryFun,
        itemBuilder: null,
        customSuccessWidget: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: itemCount,
          separatorBuilder: (_, __) => SizedBox(width: 8.iw),
          itemBuilder: (context, index) {
            if (widget.response.status == Status.loadingMore &&
                widget.categories.length == index) {
              return SizedBox(
                width: itemWidth,
                child: const Center(child: CustomLoadingWidget()),
              );
            }

            final category = widget.categories[index];
            final isSelected =
                widget.selectedCategoryIds?.contains(category.id) ?? false;

            return SizedBox(
              width: itemWidth,
              child: GestureDetector(
                onTap: () => widget.onTap(category),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 28.iw,
                      backgroundColor: isSelected
                          ? null
                          : AppColors.primaryAppBarColor,
                      child: DisplayNetworkImage(
                        width: 30,
                        height: 30,
                        imageUrl: category.icon,
                      ),
                    ),
                    Text(
                      category.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: context.textStyle.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
