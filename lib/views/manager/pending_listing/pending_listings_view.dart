import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class PendingListingView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const PendingListingView({super.key, required this.scrollController});

  @override
  ConsumerState<PendingListingView> createState() => _PendingListingViewState();
}

class _PendingListingViewState extends ConsumerState<PendingListingView> {
  late final ScrollController _scrollController;
  List<String> types = [
    "Best By Products",
    "Instant Sales",
    "Weighted Items",
    "Promotional Products",
  ];
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.microtask(() {
      fetchProduct();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        int skip = ref.read(productProvider).skip ?? 0;
        if (skip > 0) {
          ref
              .read(productProvider.notifier)
              .getListApprovedProducts(
                limit: 10,
                type: Helper.setType(types[selectIndex]),
                skip: skip,
              );
        }
      }
    });
  }

  void fetchProduct() {
    ref
        .read(productProvider.notifier)
        .getListApprovedProducts(
          limit: 10,
          type: Helper.setType(types[selectIndex]),
        );
  }

  @override
  Widget build(BuildContext context) {
    final providerVM = ref.watch(productProvider);
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.22,
        backgroundColor: Colors.transparent,
        radius: 0.0,
        title: AppConstant.userType == UserType.employee
            ? "Product Listings - Select Product"
            : "Pending Listing - Select Product",
        children: [
          15.ph,
          Expanded(
            child: Container(
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
                          // First item in the row
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = i;
                                });
                                fetchProduct();
                              },
                              child: Container(
                                // margin: EdgeInsets.only(bottom: 8),
                                // padding: EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectIndex == i
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: selectIndex == i
                                      ? null
                                      : Border.all(
                                          color: AppColors.borderColor,
                                        ),
                                ),
                                child: Text(
                                  types[i],
                                  style: selectIndex == i
                                      ? context.textStyle.displaySmall!
                                            .copyWith(color: Colors.white)
                                      : context.textStyle.bodySmall!.copyWith(
                                          color: AppColors.primaryTextColor,
                                        ),
                                ),
                              ),
                            ),
                          ),

                          // Second item in the row (check if it exists)
                          if (i + 1 < types.length)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectIndex = i + 1;
                                  });
                                  fetchProduct();
                                },
                                child: Container(
                                  // margin: EdgeInsets.only(bottom: 8),
                                  // padding: EdgeInsets.symmetric(vertical: 12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectIndex == i + 1
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: selectIndex == i + 1
                                        ? null
                                        : Border.all(
                                            color: AppColors.borderColor,
                                          ),
                                  ),
                                  child: Text(
                                    types[i + 1],
                                    style: selectIndex == i + 1
                                        ? context.textStyle.displaySmall!
                                              .copyWith(color: Colors.white)
                                        : context.textStyle.bodySmall!.copyWith(
                                            color: AppColors.primaryTextColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Expanded(child: SizedBox()), // Filler if odd number
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
            ),
            child: CustomSearchBarWidget(
              hintText: "Hinted search text",
              suffixIcon: SvgPicture.asset(Assets.filterIcon),
              onChanged: (value){
                
              },
              onTapOutside: (v) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Expanded(
            child: AsyncStateHandler(
              status: providerVM.productListingApiResponse.status,
              dataList: providerVM.listApprovedproducts!,
              onRetry: () {
                fetchProduct();
              },
              scrollController: _scrollController,
              padding: EdgeInsets.all(
                AppTheme.horizontalPadding,
              ).copyWith(bottom: 100.r),
              itemBuilder: (context, index) => ProductDisplayWidget(
                onTap: () {
                  AppRouter.push(
                    PendingProductDetailView(
                      type: types[selectIndex],
                      data: providerVM.listApprovedproducts![index],
                    ),
                  );
                },
                data: providerVM.listApprovedproducts![index].product!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
