import 'package:push_price_manager/utils/extension.dart';
import '../data/network/api_response.dart';
import '../export_all.dart';

class StoreDisplayGenericWidget extends StatefulWidget {
  final ApiResponse response;
  final int selectedStoreId;
  final List<StoreDataModel> stores;
  final Function(StoreDataModel store) onTap;
  final VoidCallback onRetryFun;
  final VoidCallback? onScrollFun; // 👈 optional scroll callback

  const StoreDisplayGenericWidget({
    super.key,
    required this.response,
    required this.selectedStoreId,
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
    return SizedBox(
      height: 85.h,
      child: AsyncStateHandler(
        status: widget.response.status,
        dataList: widget.stores,
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
          itemCount: widget.stores.length,
          itemBuilder: (context, index) {
            final store = widget.stores[index];
            final isSelected = store.storeId == widget.selectedStoreId;
      
            return GestureDetector(
              onTap: () => widget.onTap(store),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: isSelected
                        ? null
                        : AppColors.primaryAppBarColor,
                    child: Image.asset(
                      Assets.store,
                      width: 40,
                      height: 40,
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
            );
          },
        ),
      ),
    );
  }
}
