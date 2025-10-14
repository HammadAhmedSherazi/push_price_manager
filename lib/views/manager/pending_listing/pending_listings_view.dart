import 'dart:async';

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
  late final TextEditingController _searchTextEditController;
  Timer? _searchDebounce;
  List<String> types = [
    "Best By Products",
    "Instant Sales",
    "Weighted Items",
    "Promotional Products",
  ];
  int selectIndex = -1;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchTextEditController = TextEditingController();
    Future.microtask(() {
      fetchProduct(skip: 0);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        int skip = ref.read(productProvider).skip ?? 0;
        if (skip > 0) {
          fetchProduct(skip: skip);
        }
      }
    });
  }

  void fetchProduct({String? text, required int skip}) {
    String? txt = _searchTextEditController.text.isEmpty
        ? null
        : _searchTextEditController.text;
    if (AppConstant.userType == UserType.employee) {
      ref
        .read(productProvider.notifier)
        .getListApprovedProducts(
          limit: 10,
          type: selectIndex == -1? null: Helper.setType(types[selectIndex]),
          searchText: text ?? txt,
          skip: skip
          
        );
    }
    else{
      ref
        .read(productProvider.notifier)
        .getPendingReviewList(
          limit: 10,
          type: selectIndex == -1? null: Helper.setType(types[selectIndex]),
          searchText: text ?? txt,
          skip: skip
          
        );
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(productProvider.select((e)=>(e.productListingApiResponse, e.pendingReviewApiRes, e.listApprovedproducts, e.pendingReviewList)));
    final response = AppConstant.userType == UserType.employee? data.$1 : data.$2;
    final list = AppConstant.userType == UserType.employee? data.$3: data.$4;
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
                                fetchProduct(skip: 0);
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
                                  fetchProduct(skip: 0);
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
      body: RefreshIndicator.adaptive(
        onRefresh: ()async {
          fetchProduct(skip: 0);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              child: CustomSearchBarWidget(
                hintText: "Hinted search text",
                suffixIcon: SvgPicture.asset(Assets.filterIcon),
                onChanged: (text) {
                  if (_searchDebounce?.isActive ?? false) {
                    _searchDebounce!.cancel();
                  }
        
                  _searchDebounce = Timer(const Duration(milliseconds: 500), () {
                    if (text.length >= 3) {
                      fetchProduct(text: text, skip: 0);
                    }
                    else{
                      fetchProduct(skip: 0);
                    }
                  });
                },
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: AsyncStateHandler(
                status: response.status,
                dataList: list!,
                onRetry: () {
                  fetchProduct(skip: 0);
                },
                scrollController: _scrollController,
                padding: EdgeInsets.all(
                  AppTheme.horizontalPadding,
                ).copyWith(bottom: 100.r),
                itemBuilder: (context, index) {
                  final item =list[index];
                  return ProductDisplayWidget(
                  onTap: () {
                    AppRouter.push(
                      PendingProductDetailView(
                        
                        data: item,
                      ),
                      fun: (){
                        fetchProduct(skip: 0);
                      }
                    );
                  },
                  data: item.product!,
                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
