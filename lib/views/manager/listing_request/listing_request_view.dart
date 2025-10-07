import 'dart:async';

import 'package:push_price_manager/providers/product_provider/product_provider.dart';

import '../../../export_all.dart';

class ListingRequestView extends ConsumerStatefulWidget {
  const ListingRequestView({super.key});

  @override
  ConsumerState<ListingRequestView> createState() => _ListingRequestViewState();
}

class _ListingRequestViewState extends ConsumerState<ListingRequestView> {
  late TextEditingController _searchTextEditController;
  late ScrollController _scrollController;
  int offset = 0;
  Timer? _searchDebounce;
  @override
  void initState() {
    super.initState();
    _searchTextEditController = TextEditingController();
    _scrollController = ScrollController();
    Future.microtask(() {
      ref
          .read(productProvider.notifier)
          .getProductfromDatabase(limit: 10, offset: offset);
    });
     _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
            offset++;
             Future.microtask(() {
      ref
          .read(productProvider.notifier)
          .getProductfromDatabase(limit: 10, offset: offset);
    });
      
      }
    });
  }
  @override
void dispose() {
  _searchDebounce?.cancel();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "scan",
      onButtonTap: () {
        AppRouter.push(ScanView());
      },
      title: AppConstant.userType == UserType.employee
          ? "Search From Database"
          : "Listing Request - Select Product",
      child: RefreshIndicator.adaptive(
         onRefresh: () async{
                    offset = 0;
                    ref.read(productProvider.notifier).getProductfromDatabase(limit: 10, offset: offset);
                  },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppTheme.horizontalPadding),
              child: CustomSearchBarWidget(
                controller: _searchTextEditController,
                onChanged: (text) {
                  if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
        
            _searchDebounce = Timer(const Duration(milliseconds: 500), () {
        if (text.length >= 3) {
          ref.read(productProvider.notifier).getProductfromDatabase(
            limit: 20,
            offset: 0,
            searchText: text,
          );
        }
            });
                },
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                hintText: "Hinted search text",
                suffixIcon: SvgPicture.asset(Assets.filterIcon),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final providerVM = ref.watch(
                  productProvider.select((e) => e.productApiResponse),
                );
                return Expanded(
                  child: AsyncStateHandler(
                    scrollController: _scrollController,
                    status: providerVM.status,
                                  
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.horizontalPadding,
                    ),
                    itemBuilder: (context, index) {
                      final product = ref.watch(productProvider).products![index];
                      return ProductDisplayWidget(
                        data: product,
                      onTap: () {
                        AppRouter.push(ListingProductDetailView(
                          data: product,
                        ));
                      },
                    );
                    },
                    dataList: ref.watch(productProvider).products!,
                    onRetry: () {
                      ref
                          .read(productProvider.notifier)
                          .getProductfromDatabase(limit: 5, offset: offset);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: CustomAppBarWidget(
    //     height: context.screenheight * 0.15,
    //     title: AppConstant.userType == UserType.employee? "Search From Database": "Listing Request - Select Product",
    //     children: [
    // CustomSearchBarWidget(
    //   hintText: "Hinted search text",
    //   suffixIcon: SvgPicture.asset(Assets.filterIcon),
    // ),
    //     ],
    //   ),
    //   body: Column(
    //     children: [
    // Expanded(child: ListView.separated(
    //   padding: EdgeInsets.all(AppTheme.horizontalPadding),
    //   itemBuilder: (context, index)=>ProductDisplayWidget(
    //     onTap: (){},
    //   ), separatorBuilder: (context, index)=> 10.ph, itemCount: 10)),
    //       Padding(
    //         padding: EdgeInsets.all(AppTheme.horizontalPadding),
    //         child: CustomButtonWidget(title: "scan", onPressed: (){
    //           AppRouter.push(ScanView());
    //         }),
    //       )
    //     ],
    //   ),
    // );
  }
}
