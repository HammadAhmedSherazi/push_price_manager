import 'package:push_price_manager/data/network/api_response.dart';
import 'package:push_price_manager/export_all.dart';

class SeeAllProductView extends ConsumerStatefulWidget {
  final String title;
  // final VoidCallback onTap;

  const SeeAllProductView({super.key, required this.title});

  @override
  ConsumerState<SeeAllProductView> createState() => _SeeAllProductViewState();
}

class _SeeAllProductViewState extends ConsumerState<SeeAllProductView> {
  late final ScrollController _scrollController;
  List<ListingModel> list = [];
  ApiResponse response = ApiResponse.undertermined();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.microtask(() {
      fetchProducts(skip: 0);
    });
     _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        int skip = ref.read(productProvider).skip ?? 0;
        if (skip > 0) {
          fetchProducts(skip: skip);
        }
      }
    });
  }

  void fetchProducts({required int skip}) {
    if (widget.title == "Listing Request") {
      ref.read(productProvider.notifier).getListRequestProducts(limit: 10);
      
      // AppRouter.push(
      //  ListingProductDetailView(isRequest: true, type: setType(index),));
    } else if (widget.title == "Product Listings") {
     
     ref.read(productProvider.notifier).getListApprovedProducts(limit: 10);
    } else if (widget.title == "Pending Listings") {
      
      ref.read(productProvider.notifier).getPendingReviewList(limit: 10);
      //              AppRouter.push(PendingProductDetailView(
      //   type: setType(index),
      // ));
    } else {
      ref.read(productProvider.notifier).getLiveListProducts(limit: 10);
      //                          AppRouter.push(ProductLiveListingDetailView(
      //   type: setType(index),
      //  ));
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final providerVM = ref.watch(productProvider);
    if (widget.title == "Listing Request") {
      response = providerVM.listRequestApiResponse;
      list = providerVM.listRequestproducts!;
      // AppRouter.push(
      //  ListingProductDetailView(isRequest: true, type: setType(index),));
    } else if (widget.title == "Product Listings") {
      response = providerVM.productListingApiResponse;
      list = providerVM.listApprovedproducts!;
      //              AppRouter.push(PendingProductDetailView(
      //   type: setType(index),
      // ));
    } else if (widget.title == "Pending Listings") {
     
      response = providerVM.pendingReviewApiRes;
      list = providerVM.pendingReviewList!;
      //              AppRouter.push(PendingProductDetailView(
      //   type: setType(index),
      // ));
    } else {
      response = providerVM.listLiveApiResponse;
      list = providerVM.listLiveProducts!;
      //        
      //                  AppRouter.push(ProductLiveListingDetailView(
      //   type: setType(index),
      //  ));
    }
    return CustomScreenTemplate(
      title: widget.title,
      child: AsyncStateHandler(
        status: response.status,
        dataList: list,
        itemBuilder: null,
        onRetry: () {
          fetchProducts(skip: 0);
        },
        customSuccessWidget: GridView.builder(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.horizontalPadding,
            vertical: AppTheme.horizontalPadding,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // item height (since scrolling is horizontal)
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.999,
            maxCrossAxisExtent: 200,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
           
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                onTap: () {
                  if (widget.title == "Listing Request") {
                    AppRouter.push(
                      ListingProductDetailView(isRequest: true, type:setType(index), data: list[index])
                    
                  );
                    // AppRouter.push(
                    //  ListingProductDetailView(isRequest: true, type: setType(index),));
                  } 
                  // else if (widget.title == "Product Listings") {
                  //    AppRouter.push(
                  //   PendingProductDetailView(
                  //     type: Helper.getTypeTitle(item.listingType),
                  //     data: item,
                  //   ),
                  //   fun: () {
                  //     ref
                  // .read(productProvider.notifier)
                  // .getListApprovedProducts(limit: 10);
                  //   },
                  // );
                  
                  // } 
                  else if (widget.title == "Pending Listings" || widget.title == "Product Listings") {
                    //              AppRouter.push(PendingProductDetailView(
                    //   type: setType(index),
                    // ));
                      AppRouter.push(
                  PendingProductDetailView(
                    type: Helper.getTypeTitle(list[index].listingType),
                    data: list[index],
                  ),
                  fun: () {
                    fetchProducts(skip: 0);
                  },
                );
                  } else {
                    //                          AppRouter.push(ProductLiveListingDetailView(
                    //   type: setType(index),
                    //  ));
                    AppRouter.push(
                      ProductLiveListingDetailView(data: list[index]),
                      fun: () {
                        fetchProducts(skip: 0);
                      },
                    );
                  }
                },
                child: 
                ProductDisplayBoxWidget(data: list[index].product!,)
              ),
            );
          },
        ),
      ),
    );
  }
}
