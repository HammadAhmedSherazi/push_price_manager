import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class HomeView extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const HomeView({super.key, required this.scrollController});

  @override
  ConsumerState<HomeView> createState() => _HomeViewConsumerState();
}

class _HomeViewConsumerState extends ConsumerState<HomeView> {

  @override
  void initState() {
    Future.microtask(() {
      ref
          .read(productProvider.notifier)
          .getPendingReviewList(limit: 10, skip: 0);
      ref
          .read(productProvider.notifier)
          .getLiveListProducts(limit: 10, skip: 0);
      ref.read(authProvider.notifier).getMyStores();
      ref.read(authProvider.notifier).getCategories(limit: 10, skip: 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        height: context.screenheight * 0.15,
        title: context.tr("home"),
        children: [
          Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final userImage = ref.watch(
                    authProvider.select((e) => e.staffInfo),
                  )?.profileImage ?? "";

                  return UserProfileWidget(
                    radius: 18.r,
                    imageUrl: userImage,
                    borderWidth: 1.4,
                  );
                },
              ),
              10.pw,
              Consumer(
                builder: (context, ref, child) {
                  final userName = ref.watch(
                    authProvider.select((e) => e.staffInfo) ,
                  )?.fullName ?? "";
                  return Text(
                    userName.toUpperCase(),
                    style: context.textStyle.displayMedium,
                  );
                },
              ),
              Spacer(),
              CustomButtonWidget(
                height: 30.h,
                width: 120.w,
                title: "",
                onPressed: () {
                  AppRouter.push(ListingRequestView());
                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text(
                      context.tr("listing_request"),
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
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref
              .read(productProvider.notifier)
              .getPendingReviewList(limit: 10, skip: 0);
          ref
              .read(productProvider.notifier)
              .getLiveListProducts(limit: 10, skip: 0);
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(AppTheme.horizontalPadding),
          controller: widget.scrollController,
          children: [PendingListingSection(), 30.ph, LiveListingSection()],
        ),
      ),
    );
  }
}

class PendingListingSection extends ConsumerWidget {
  const PendingListingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(
      productProvider.select(
        (e) => (e.pendingReviewApiRes, e.pendingReviewList),
      ),
    );

    final response = data.$1;
    final products = data.$2 ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.tr("pending_listings"), style: context.textStyle.displayMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              ),
              onPressed: () {
                // AppRouter.push(
                //   SeeAllProductView(title: context.tr("pending_listings")),
                //   fun: () {
                //     ref
                //         .read(productProvider.notifier)
                //         .getPendingReviewList(limit: 10, skip: 0);
                //   },
                // );
                ref.read(navigationProvider.notifier).setIndex(1);
              },
              child: Text(
                context.tr("see_all"),
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
            status: response.status,
            dataList: products,
            onRetry: () {
              ref
                  .read(productProvider.notifier)
                  .getPendingReviewList(limit: 10, skip: 0);
            },

            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                AppRouter.push(
                  PendingProductDetailView(data: products[index]),
                  fun: () {
                    ref
                        .read(productProvider.notifier)
                        .getPendingReviewList(limit: 10, skip: 0);
                  },
                );
              },
              child: ProductDisplayBoxWidget(data: products[index].product!),
            ),
          ),
        ),
      ],
    );
  }
}

class LiveListingSection extends StatelessWidget {
  const LiveListingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(
          productProvider.select(
            (e) => (e.listLiveApiResponse, e.listLiveProducts),
          ),
        );

        final response = data.$1;
        final products = data.$2 ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.tr("live_listings"), style: context.textStyle.displayMedium),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    visualDensity: VisualDensity(
                      horizontal: -4.0,
                      vertical: -4.0,
                    ),
                  ),
                  onPressed: () {
                    // AppRouter.push(
                    //   SeeAllProductView(
                    //     title: context.tr("live_listings"),

                    //     //           , onTap: (){
                    //     //            AppRouter.push(ProductLiveListingDetailView(
                    //     //   type: "Best By Products",
                    //     //  ));
                    //     //         }
                    //   ),
                    //   fun: () {
                    //     ref
                    //         .read(productProvider.notifier)
                    //         .getLiveListProducts(limit: 10, skip: 0);
                    //   },
                    // );
                    ref.read(navigationProvider.notifier).setIndex(2);
                  },
                  child: Text(
                    context.tr("see_all"),
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
                dataList: products,
                status: response.status,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                onRetry: () {
                  ref
                      .read(productProvider.notifier)
                      .getLiveListProducts(limit: 10, skip: 0);
                },
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    AppRouter.push(
                      ProductLiveListingDetailView(data: products[index]),
                      fun: () {
                        ref
                            .read(productProvider.notifier)
                            .getLiveListProducts(limit: 10, skip: 0);
                      },
                    );
                  },
                  child: ProductDisplayBoxWidget(
                    data: products[index].product!,
                  ),
                  //
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
