import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';
import 'package:push_price_manager/widget/store_display_generic_widget.dart';

import '../../../export_all.dart';

class LiveListingView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const LiveListingView({super.key, required this.scrollController});

  @override
  ConsumerState<LiveListingView> createState() => _LiveListingViewState();
}

class _LiveListingViewState extends ConsumerState<LiveListingView> {
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
    final response1 = data.$3;
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
   ref
        .read(productProvider.notifier)
        .getLiveListProducts(
          limit: 10,
          type: selectIndex == -1? null: Helper.setType(types[selectIndex]),
          searchText: text ?? txt,
          skip: skip,
          storeId: selectStoreIds.isEmpty ? null : selectStoreIds,
          categoryId: selectCategoryIds.isEmpty ? null : selectCategoryIds
          
        );
  }
void selectChip(int index){
     setState(() {
                    selectIndex = index == selectIndex ? -1: index;
                  });
                  fetchProduct(skip:0);
  }
  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final providerVM = ref.watch(productProvider);
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.22,
        backgroundColor: Colors.transparent,
        radius: 0.0,
        title: context.tr("live_listing_select_product"),
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
                               selectChip(i);
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
                                  context.tr(types[i]),
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
                                  selectChip(i+ 1);
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
                                    context.tr(types[i + 1]),
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
              padding:  EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding
              ),
              child: CustomSearchBarWidget(hintText: context.tr("search_product"), suffixIcon: GestureDetector(
                  onTap: () => _showCategoriesModal(context, ref),
                  child: SvgPicture.asset(Assets.filterIcon),
                ), onTapOutside: (v){
                 FocusScope.of(context).unfocus();

              },  onChanged: (text) {
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
                },),
            ),
            Expanded(
              child: AsyncStateHandler(
                status: providerVM.listLiveApiResponse.status,
                scrollController: _scrollController,
                dataList: providerVM.listLiveProducts!,
                onRetry: (){
                  fetchProduct(skip: 0);
                },
                padding: EdgeInsets.all(AppTheme.horizontalPadding).copyWith(
                  bottom: 100.r
                ),
                itemBuilder: (context, index) {
                  final item = providerVM.listLiveProducts![index];
                  return ProductDisplayWidget(
                  data: item.product!,
                  onTap: (){
                     AppRouter.push(ProductLiveListingDetailView(
                          data: item,
                         ),fun: (){
                          fetchProduct(skip: 0);
                         });
                  },
                );
                }, ),
            )
          ],
        ),
      ),
    );
  }


}

