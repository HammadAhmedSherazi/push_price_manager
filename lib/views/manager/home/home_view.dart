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
      ref.read(productProvider.notifier).getPendingReviewList(limit: 10);
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
              Text("ABC BUSINESS", style: context.textStyle.displayMedium),
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
                      "Listing Request",
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
        children: [PendingListingSection(), 30.ph, LiveListingSection()],
      ),
    );
  }
}

class PendingListingSection extends ConsumerWidget {
  const PendingListingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(productProvider.select((e) => e.pendingReviewApiRes));
    final providerVM = ref.watch(productProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Pending Listings", style: context.textStyle.displayMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              ),
              onPressed: () {
                AppRouter.push(
                  SeeAllProductView(
                    title: "Pending Listings",
                    
                    //   , onTap: (){
                    //   AppRouter.push(PendingProductDetailView(
                    //     type: "Best By Products",
                    //   ));
                    // },
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
            status: providerVM.pendingReviewApiRes.status,
            dataList: providerVM.pendingReviewList ?? [],
            onRetry: () {
              ref
                  .read(productProvider.notifier)
                  .getPendingReviewList(limit: 10);
            },

            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                AppRouter.push(
                  PendingProductDetailView(
                    type: Helper.getTypeTitle(providerVM.pendingReviewList![index].listingType),
                    data: providerVM.pendingReviewList![index],
                  ),
                  fun: (){
                    ref.read(productProvider.notifier).getPendingReviewList(limit: 10);
                  }
                );
              },
              child: ProductDisplayBoxWidget(
                data: providerVM.pendingReviewList![index].product!,
              ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Live Listings", style: context.textStyle.displayMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              ),
              onPressed: () {
                AppRouter.push(
                  SeeAllProductView(
                    title: "Live Listings",
                   
                    //           , onTap: (){
                    //            AppRouter.push(ProductLiveListingDetailView(
                    //   type: "Best By Products",
                    //  ));
                    //         }
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
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // AppRouter.push(
                //   ProductLiveListingDetailView(type: "Best By Products", data: ,),
                // );
              },
              child: SizedBox.shrink(),
              // ProductDisplayBoxWidget()
            ),
            separatorBuilder: (context, index) => 10.pw,
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
