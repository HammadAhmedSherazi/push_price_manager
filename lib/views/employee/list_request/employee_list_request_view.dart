import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class EmployeeListRequestView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const EmployeeListRequestView({super.key, required this.scrollController});

  @override
  ConsumerState<EmployeeListRequestView> createState() =>
      _EmployeeListRequestViewState();
}

class _EmployeeListRequestViewState
    extends ConsumerState<EmployeeListRequestView> {
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

  void _showCategoriesModal(BuildContext context, WidgetRef ref) {
    final categories =
        ref.watch(authProvider.select((e) => e.categories)) ?? [];
    final response = ref.watch(
      authProvider.select((e) => e.getCategoriesApiResponse),
    );

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding,
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
                  response: response,
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
             
              ],
            ),
          ),
        );
      },
    ).then((c) {
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
        .getListRequestProducts(
          limit: 10,
          type: selectIndex == -1 ? null : Helper.setType(types[selectIndex]),
          searchText: text ?? txt,
          skip: skip,
          categoryId: selectCategoryIds.isEmpty ? null : selectCategoryIds,
        );
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
    final providerVM = ref.watch(productProvider);
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: 200,
        backgroundColor: Colors.transparent,
        radius: 0.0,
        title: context.tr("listing_requests"),
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
                controller: _searchTextEditController,
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
                hintText: context.tr("search_product"),
                suffixIcon: GestureDetector(
                  onTap: () => _showCategoriesModal(context, ref),
                  child: SvgPicture.asset(Assets.filterIcon),
                ),
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: AsyncStateHandler(
                status: providerVM.listRequestApiResponse.status,
                dataList: providerVM.listRequestproducts!,
                onRetry: () {
                  fetchProduct(skip: 0);
                },
                scrollController: _scrollController,
                padding: EdgeInsets.all(
                  AppTheme.horizontalPadding,
                ).copyWith(bottom: 100.r),
                itemBuilder: (context, index) {
                  final item = providerVM.listRequestproducts![index];
                  return ProductDisplayWidget(
                    onTap: () {
                      AppRouter.push(
                        ListingProductDetailView(
                          isRequest: true,
                          data: ListingModel(product: item.product),
                        ),
                        fun: () {
                          fetchProduct(skip: 0);
                        },
                      );
                      // AppRouter.push(
                      //   PendingProductDetailView(
                      //     type: types[selectIndex],
                      //     data: providerVM.listRequestproducts![index],
                      //   ),
                      // );
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
