import 'dart:async';

import 'package:push_price_manager/utils/extension.dart';
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
          type: Helper.setType(types[selectIndex]),
          searchText: text ?? txt,
          skip: skip
          
        );
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
        title: "Live Listing- Select Product",
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
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalPadding
            ),
            child: CustomSearchBarWidget(hintText: "Hinted search text", suffixIcon: SvgPicture.asset(Assets.filterIcon), onTapOutside: (v){
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
    );
  }


}

