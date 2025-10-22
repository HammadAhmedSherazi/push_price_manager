import 'package:push_price_manager/utils/extension.dart';

import '../data/network/api_response.dart';
import '../export_all.dart';

class CategoryDisplayGenericWidget extends StatefulWidget {
  final ApiResponse response;
  final List<int>? selectedCategoryIds;
  final List<CategoryDataModel> categories;
  final Function(CategoryDataModel category) onTap;
  final VoidCallback onRetryFun;
  final VoidCallback? onScrollFun; // 👈 optional scroll callback

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

    // 👇 Trigger callback when user scrolls near the end
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
    return SizedBox(
      height: 85.h,
      child: AsyncStateHandler(
        status: widget.response.status,
        dataList: widget.categories,
        onRetry: widget.onRetryFun,
        itemBuilder: null,
        customSuccessWidget: GridView.builder(
          controller: _scrollController, // 👈 added controller
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Single horizontal row
            mainAxisSpacing: 2.r,
            crossAxisSpacing: 5.r,
            childAspectRatio: 1.2,
          ),
          itemCount: widget.response.status == Status.loadingMore ? widget.categories.length + 1: widget.categories.length,
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            final isSelected = widget.selectedCategoryIds?.contains(category.id) ?? false;
      
            return widget.response.status == Status.loadingMore && widget.categories.length == index ? CustomLoadingWidget(): GestureDetector(
              onTap: () => widget.onTap(category),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: isSelected
                        ? null
                        : AppColors.primaryAppBarColor,
                    child: DisplayNetworkImage(
                      width: 30.r,
                      height: 30.r,
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
            );
          },
        ),
      ),
    );
  }
}
