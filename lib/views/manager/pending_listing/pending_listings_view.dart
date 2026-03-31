import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';
import 'package:push_price_manager/widget/store_display_generic_widget.dart';

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
    "best_by_products",
    "instant_sales",
    "weighted_items",
    "promotional_products",
  ];
  int selectIndex = -1;
  List<int> selectCategoryIds = [];
  List<int> selectStoreIds = [];
  void _showCategoriesModal(BuildContext context, WidgetRef ref) {
    final data = ref.watch(authProvider.select((e) => (e.categories, e.myStores, e.getCategoriesApiResponse, e.getStoresApiRes)));
    final categories =
        data.$1 ?? [];
    final stores = data.$2 ?? [];
    final response1 =  data.$3;
    final response2 = data.$4;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState)=>Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.horizontalPadding
          ),

          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr("categories"),
                style: context.textStyle.displayMedium!.copyWith(
                  fontSize: 18.sp,
                ),
              ),

               CategoryDisplayGenericWidget(
                  response: response1,
                  selectedCategoryIds: selectCategoryIds,
                  categories: categories,
                  onScrollFun: () {
                    final skip = ref.watch(authProvider.select((e)=>e.categoriesSkip)) ?? 0;
                    if(skip > 0){
                      ref.read(authProvider.notifier).getCategories(limit: 5, skip: skip);
                    }

                  },
                  onTap: (category) {
                    setState((){
                      if (selectCategoryIds.contains(category.id)) {
                        selectCategoryIds.remove(category.id);
                      } else {
                        selectCategoryIds.add(category.id!);
                      }
                    });
                  },
                  onRetryFun: () {
                    ref.read(authProvider.notifier).getCategories(limit: 10, skip: 0);
                  },

                ),
             
              if(AppConstant.userType == UserType.manager)...[
                 10.ph,
              Text(
                context.tr("select_store"),
                style: context.textStyle.displayMedium!.copyWith(
                  fontSize: 18.sp,
                ),
              ),

               StoreDisplayGenericWidget(response: response2, selectedStoreIds: selectStoreIds, stores: stores, onTap: (store){
              setState((){
                if (selectStoreIds.contains(store.storeId)) {
                  selectStoreIds.remove(store.storeId);
                } else {
                  selectStoreIds.add(store.storeId);
                }
              });
             }, onRetryFun: (){
              ref.read(authProvider.notifier).getMyStores();
             })
              ],
              ],
          ),
        )
     ); },
    ).then((c){
      
        fetchProduct(skip: 0);
      
    });
  }

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
            type: selectIndex == -1 ? null : Helper.setType(types[selectIndex]),
            searchText: text ?? txt,
            skip: skip,
            categoryId: selectCategoryIds.isEmpty ? null : selectCategoryIds ,
            
          );
    } else {
      ref
          .read(productProvider.notifier)
          .getPendingReviewList(
            limit: 10,
            type: selectIndex == -1 ? null : Helper.setType(types[selectIndex]),
            searchText: text ?? txt,
            skip: skip,
            storeId: selectStoreIds.isEmpty ? null : selectStoreIds,
            categoryId: selectCategoryIds.isEmpty ? null : selectCategoryIds
          );
    }
  }

  void selectChip(int index) {
    setState(() {
      selectIndex = index == selectIndex ? -1 : index;
    });
    fetchProduct(skip: 0);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(
      productProvider.select(
        (e) => (
          e.productListingApiResponse,
          e.pendingReviewApiRes,
          e.listApprovedproducts,
          e.pendingReviewList,
        ),
      ),
    );
    final response = AppConstant.userType == UserType.employee
        ? data.$1
        : data.$2;
    final list = AppConstant.userType == UserType.employee ? data.$3 : data.$4;
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: 200,
        backgroundColor: Colors.transparent,
        radius: 0.0,
        title: AppConstant.userType == UserType.employee
            ? context.tr("product_listings_select_product")
            : context.tr("pending_listings_select_product")
           ,
        children: [
          15.ph,
          Expanded(
            child: ProductTypeFilterChipsWidget(
              types: types,
              selectedIndex: selectIndex,
              onSelect: selectChip,
            ),
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          fetchProduct(skip: 0);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding,
              ),
              child: CustomSearchBarWidget(
                hintText: context.tr("search_product"),
                suffixIcon: GestureDetector(
                  onTap: () => _showCategoriesModal(context, ref),
                  child: SvgPicture.asset(Assets.filterIcon),
                ),
                onChanged: (text) {
                  if (_searchDebounce?.isActive ?? false) {
                    _searchDebounce!.cancel();
                  }

                  _searchDebounce = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      if (text.length >= 3) {
                        fetchProduct(text: text, skip: 0);
                      } else {
                        fetchProduct(skip: 0);
                      }
                    },
                  );
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
                  final item = list[index];
                  return ProductDisplayWidget(
                    onTap: () {
                      AppRouter.push(
                        PendingProductDetailView(data: item),
                        fun: () {
                          fetchProduct(skip: 0);
                        },
                      );
                    },
                    data: item.product,
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
