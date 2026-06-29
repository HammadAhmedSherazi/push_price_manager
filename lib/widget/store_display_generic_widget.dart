import 'package:push_price_manager/utils/extension.dart';

import '../data/network/api_response.dart';
import '../export_all.dart';

class StoreDisplayGenericWidget extends StatefulWidget {
  final ApiResponse response;
  final List<int> selectedStoreIds;
  final List<StoreDataModel> stores;
  final Function(StoreDataModel store) onTap;
  final VoidCallback onRetryFun;
  final VoidCallback? onScrollFun;

  const StoreDisplayGenericWidget({
    super.key,
    required this.response,
    required this.selectedStoreIds,
    required this.stores,
    required this.onTap,
    required this.onRetryFun,
    this.onScrollFun,
  });

  @override
  State<StoreDisplayGenericWidget> createState() =>
      _StoreDisplayGenericWidgetState();
}

class _StoreDisplayGenericWidgetState extends State<StoreDisplayGenericWidget> {
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
    final itemWidth = context.isTablet ? context.responsiveWidth(0.10) : 80.w;

    return SizedBox(
      height: context.isTablet ? 96.ih : 85.h,
      child: AsyncStateHandler(
        status: widget.response.status,
        dataList: widget.stores,
        onRetry: widget.onRetryFun,
        itemBuilder: null,
        customSuccessWidget: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: widget.stores.length,
          separatorBuilder: (_, __) => SizedBox(width: 8.iw),
          itemBuilder: (context, index) {
            final store = widget.stores[index];
            final isSelected =
                widget.selectedStoreIds.contains(store.storeId);

            return SizedBox(
              width: itemWidth,
              child: GestureDetector(
                onTap: () => widget.onTap(store),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 28.iw,
                      backgroundColor: isSelected
                          ? null
                          : AppColors.primaryAppBarColor,
                      child: Image.asset(
                        Assets.store,
                        width: 36,
                        height: 36,
                      ),
                    ),
                    Text(
                      store.storeName,
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
