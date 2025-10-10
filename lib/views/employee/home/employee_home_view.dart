import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class EmployeeHomeView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const EmployeeHomeView({super.key, required this.scrollController});

  @override
  ConsumerState<EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends ConsumerState<EmployeeHomeView> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(productProvider.notifier).getListApprovedProducts(limit: 10);
      ref.read(productProvider.notifier).getListRequestProducts(limit: 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.15,
        title: "Home",
        children: [
          Row(
            children: [
              UserProfileWidget(
                radius: 18.r,
                imageUrl: Assets.userImage,
                borderWidth: 1.4,
              ),
              10.pw,
              Expanded(
                child: Text(
                  "ABC BUSINESS",
                  style: context.textStyle.displayMedium,
                ),
              ),

              CustomButtonWidget(
                height: 30.h,
                width: 110.w,
                title: "",
                onPressed: () {
                  AppRouter.push(ListingRequestView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text(
                      "List Product",
                      style: context.textStyle.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        controller: widget.scrollController,
        children: [ListingRequestSection(), 30.ph, ProductListingSection()],
      ),
    );
  }
}

class ListingRequestSection extends ConsumerWidget {
  const ListingRequestSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(productProvider.select((e) => e.listRequestApiResponse));
    final providerVM = ref.watch(productProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Listing Request", style: context.textStyle.displayMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              ),
              onPressed: () {
                AppRouter.push(
                  SeeAllProductView(
                    title: "Listing Request",
                    initFunCall: (){},
                    onMoreFunCall: (){},
                    // ,onTap: (){

                    //           AppRouter.push(
                    //            ListingProductDetailView(isRequest: true, type: setType(-1),));
                    //         },
                  ),
                );
              },
              child: Text(
                "See All",
                style: context.textStyle.displayMedium!.copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
         SizedBox(
          height: 125.h,
          child: AsyncStateHandler(
            padding: EdgeInsets.zero,
            status: providerVM.listRequestApiResponse.status,
            dataList: providerVM.listRequestproducts ?? [],
            onRetry: () {
              ref
                  .read(productProvider.notifier)
                  .getListRequestProducts(limit: 10);
            },
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = providerVM.listRequestproducts![index];
              return GestureDetector(
                onTap: () {
                  AppRouter.push(
                      ListingProductDetailView(isRequest: true, type:setType(index), data: item.product!)
                    
                  );
                },
                child: ProductDisplayBoxWidget(data: item.product!),
              );
            },
          ),
        ),
    
      ],
    );
  }
}

class ProductListingSection extends ConsumerWidget {
  const ProductListingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(productProvider.select((e) => e.productListingApiResponse));
    final providerVM = ref.watch(productProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Product Listings", style: context.textStyle.displayMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              ),
              onPressed: () {
                AppRouter.push(
                  SeeAllProductView(
                    title: "Product Listings",
                    initFunCall: (){},
                    onMoreFunCall: (){},
                    // , onTap: (){
                    //           AppRouter.push(PendingProductDetailView(
                    //   type: "Best By Products",
                    // ));
                    //           // AppRouter.push(
                    //           // ListingProductDetailView());
                    //         },
                  ),
                );
              },
              child: Text(
                "See All",
                style: context.textStyle.displayMedium!.copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 125.h,
          child: AsyncStateHandler(
            padding: EdgeInsets.zero,
            status: providerVM.productListingApiResponse.status,
            dataList: providerVM.listApprovedproducts ?? [],
            onRetry: () {
              ref
                  .read(productProvider.notifier)
                  .getListApprovedProducts(limit: 10);
            },
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = providerVM.listApprovedproducts![index];
              return GestureDetector(
                onTap: () {
                  AppRouter.push(
                    PendingProductDetailView(
                      type: Helper.getTypeTitle(item.listingType),
                      data: item,
                    ),
                  );
                },
                child: ProductDisplayBoxWidget(data: item.product!),
              );
            },
          ),
        ),
      ],
    );
  }
}

String setType(int index) {
  switch (index) {
    case 0:
      return "Best By Products";
    case 1:
      return "Instant Sales";
    case 2:
      return "Weighted Items";
    case 3:
      return "Promotional Products";
    default:
      return "Best By Products";
  }
}
  // List<String> types = [
  //   "Best By Products",
  //   "Instant Sales",
  //   "Weighted Items",
  //   "Promotional Products"
  // ];